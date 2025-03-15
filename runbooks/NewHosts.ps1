# get number of new hosts
Param
(
  [Parameter(Mandatory = $true)]
  [int]$sessionHostCount
)
# not work properly for az commands
# try
# {
#     Connect-AzAccount -Identity
#     az login --identity
# }
# catch {
#     Write-Error -Message $_.Exception
#     throw $_.Exception
# }
# Get credentials from Automation Account
$creds = Get-AutomationPSCredential -Name "AVDServicePrincipal"
$clientId = $creds.UserName
#$clientSecret = $creds.Password
$clientSecretaz = $creds.GetNetworkCredential().Password 
#$myPsCred = New-Object System.Management.Automation.PSCredential ($clientId,$clientSecret)

$tenantId = Get-AutomationVariable -Name "TenandID"
$subsid = Get-AutomationVariable -Name "SubscriptionId"

#Connect-AzAccount -ServicePrincipal -Credential $myPsCred -SubscriptionId $subsid -TenantId $tenantId 
az login --allow-no-subscriptions --service-principal --username $clientId --password $clientSecretaz --tenant $tenantId


# Variables

$resourceGroupName = Get-AutomationVariable -Name "ResourceGroupName"
$hostPoolName = Get-AutomationVariable -Name "HostPoolName"
$newHostName = Get-AutomationVariable -Name "NewHostName"
$location = Get-AutomationVariable -Name "Region"
$vmSize = Get-AutomationVariable -Name "VMSKUSize"
$gallery = Get-AutomationVariable -Name "AZGallery"
$imageDef = Get-AutomationVariable -Name "ImageDefinition"
$imageversion = $(az sig image-version list --resource-group $resourceGroupName --gallery-name $gallery  --gallery-image-definition $imageDef --query 'sort_by([].{id:id, version:name}, &version)[-1].id' --output tsv)
$version = $imageVersion.Split('/')[-1]
$vnet = Get-AutomationVariable -Name "VNETName"
$subnet = Get-AutomationVariable -Name "SubnetName"
$domainJoinName = Get-AutomationVariable -Name "DomainName"
$OUPath = Get-AutomationVariable -Name "DomainOUPath"


# Get credentials from Automation Account for AD Admin
$credsDomain = Get-AutomationPSCredential -Name "AVDDomainAdmin"
$aduser = $credsDomain.UserName
$adpass = $credsDomain.GetNetworkCredential().Password
$settings = '{\"Name\":\"' + $domainJoinName + '\",\"OUPath\":\"' + $ouPath + '\",\"User\":\"' + $adUser + '\",\"Restart\":true,\"Options\":3}'
$protectedSettings = '{\"Password\":\"' + $adPass + '\"}'


# Get credentials from Automation Account for Local Admin
$credsLocal = Get-AutomationPSCredential -Name "AVDLocalAdmin"
$localuser = $credsLocal.UserName
$localpass = $credsLocal.GetNetworkCredential().Password

# Get the host pool
#$hostPool = Get-AzWvdHostPool -ResourceGroupName $resourceGroupName -Name $hostPoolName
#$hostPool = az desktopvirtualization hostpool show --resource-group $resourceGroupName --name $hostPoolName | ConvertFrom-Json

az config set extension.use_dynamic_install=yes_without_prompt
az extension add --name desktopvirtualization
# Get Token
$expirationTime = (Get-Date).AddDays(20).ToString("yyyy-MM-ddTHH:mm:ss.fffffffZ")
Write-Output "Calculated Expiration Time: $expirationTime"
Write-Output "List Pool"
az desktopvirtualization hostpool list -g $resourceGroupName
$hostpoolToken = az desktopvirtualization hostpool update --resource-group $resourceGroupName --name $hostPoolName --registration-info expiration-time=$expirationTime registration-token-operation="Update" --query 'registrationInfo.token'

#$sessionHostCount = 1
$initialNumber = 1

# Azure AD Join domain extension
# $domainJoinName = "AADLoginForWindows"
# $domainJoinPublisher = "Microsoft.Azure.ActiveDirectory"
# $domainJoinVersion   = "1.0"
# $domainJoinSettings  = '{""mdmId"": ""0000000a-0000-0000-c000-000000000000""}'

# AVD Azure AD Join domain extension
$moduleLocation = "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_6-1-2021.zip"
$avdExtensionName = "DSC"
$avdExtensionPublisher = "Microsoft.Powershell"
$avdExtensionVersion = "2.73"
$avdExtensionSetting = '{""modulesUrl"": ""'+$moduleLocation+'"",""ConfigurationFunction"":""Configuration.ps1\\AddSessionHost"",""Properties"": {""hostPoolName"": ""'+ $hostPoolName + '"",""registrationInfoToken"": ""'+ $hostpoolToken + '"", ""aadJoin"": "'+ $false + '"}}'


Do {
    $prefix = -join ((65..90) + (97..122) | Get-Random -Count 4 | ForEach-Object { [char]$_ })
    $vmName = $newHostName+"$prefix"
    az vm create --name $vmName --location $location --resource-group $resourceGroupName --image $imageversion  --security-type TrustedLaunch --size $vmSize --vnet-name $vnet --subnet $subnet --admin-username $localuser --admin-password $localpass --public-ip-address '""' --nsg '""'
    az vm update --name $vmName --resource-group $resourceGroupName --set tags.IMGVer=$version
    az vm identity assign --name $vmName --resource-group $resourceGroupName
    #az vm extension set --vm-name $vmName --resource-group $resourceGroupName --name $domainJoinName --publisher $domainJoinPublisher --version $domainJoinVersion --settings $domainJoinSettings
    az vm extension set --vm-name $vmName --resource-group $resourceGroupName --name JsonADDomainExtension --publisher Microsoft.Compute --version 1.3 --settings $settings --protected-settings $protectedSettings 
    az vm restart --name $vmName --resource-group $resourceGroupName
    Start-Sleep -Seconds 60
    az vm extension set --vm-name $vmName --resource-group $resourceGroupName --name $avdExtensionName --publisher $avdExtensionPublisher --version $avdExtensionVersion --settings $avdExtensionSetting

    $initialNumber++
    $sessionHostCount--
    Write-Output "$vmName deployed"
}
while ($sessionHostCount -gt 0) 

Write-Verbose "Session hosts are created"