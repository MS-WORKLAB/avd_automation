# Get credentials from Automation Account
$creds = Get-AutomationPSCredential -Name "AVDServicePrincipal"
$clientId = $creds.UserName
$clientSecret = $creds.Password
$clientSecretaz = $creds.GetNetworkCredential().Password 
$myPsCred = New-Object System.Management.Automation.PSCredential ($clientId,$clientSecret)

$tenantId = Get-AutomationVariable -Name "TenandID"
$subsid = Get-AutomationVariable -Name "SubscriptionId"
#Import-Module Az
#write-output $clientSecret
Connect-AzAccount -ServicePrincipal -Credential $myPsCred -SubscriptionId $subsid -TenantId $tenantId 
az login --allow-no-subscriptions --service-principal --username $clientId --password $clientSecretaz --tenant $tenantId

# Get credentials from Automation Account for Local Admin
$credsLocal = Get-AutomationPSCredential -Name "AVDLocalAdmin"
$localuser = $credsLocal.UserName
$localpass = $credsLocal.GetNetworkCredential().Password

$resourceGroupName = Get-AutomationVariable -Name "ResourceGroupName"
$location = Get-AutomationVariable -Name "Region"
$vmSize = Get-AutomationVariable -Name "VMSKUSize"
$gallery = Get-AutomationVariable -Name "AZGallery"
$imageDef = Get-AutomationVariable -Name "ImageDefinition"
$vnet = Get-AutomationVariable -Name "VNETName"
$subnet = Get-AutomationVariable -Name "SubnetName"

$imageversion = $(az sig image-version list --resource-group $resourceGroupName --gallery-name $gallery  --gallery-image-definition $imageDef --query 'sort_by([].{id:id, version:name}, &version)[-1].id' --output tsv)
$version = $imageVersion.Split('/')[-1] -replace '\.', '-'
$ImageVM = "MASTERVM-$version"

az vm create --name $ImageVM --location $location --resource-group $resourceGroupName --image $imageversion  --security-type TrustedLaunch --size $vmSize --vnet-name $vnet --subnet $subnet --admin-username $localuser --admin-password $localpass --public-ip-address '""' --nsg '""'
