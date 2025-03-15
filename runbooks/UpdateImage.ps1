Param
(
  [Parameter(Mandatory = $true)]
  [string]$imageVMName
)
# Get credentials from Automation Account
$creds = Get-AutomationPSCredential -Name "AVDServicePrincipal"
$clientId = $creds.UserName
$clientSecret = $creds.Password
$clientSecretaz = $creds.GetNetworkCredential().Password 
#$myPsCred = New-Object System.Management.Automation.PSCredential ($clientId,$clientSecret)

$tenantId = Get-AutomationVariable -Name "TenandID"
$subsid = Get-AutomationVariable -Name "SubscriptionId"
#Import-Module Az
#write-output $clientSecret
#Connect-AzAccount -ServicePrincipal -Credential $myPsCred -SubscriptionId $subsid -TenantId $tenantId 
az login --allow-no-subscriptions --service-principal --username $clientId --password $clientSecretaz --tenant $tenantId

$resourceGroupName = Get-AutomationVariable -Name "ResourceGroupName"
$location = Get-AutomationVariable -Name "Region"
$location2 = Get-AutomationVariable -Name "SecondImageRegion"
$gallery = Get-AutomationVariable -Name "AZGallery"
$imageDef = Get-AutomationVariable -Name "ImageDefinition"

$imageversion = $(az sig image-version list --resource-group $resourceGroupName --gallery-name $gallery  --gallery-image-definition $imageDef --query 'sort_by([].{id:id, version:name}, &version)[-1].id' --output tsv)
$lastNumber = [regex]::Match($imageversion, '\d+(\.\d+)*$').Value
$versionParts = $lastNumber.Split('.')
$versionParts[2] = [int]$versionParts[2] + 1
$newVersion = $versionParts -join '.'
write-output $newVersion

$datadisk = $(az vm show --resource-group $resourceGroupName --name $imageVMName --query "storageProfile.osDisk.managedDisk.id" --output tsv)

az sig image-version create --resource-group $resourceGroupName --gallery-name $gallery --gallery-image-definition $imageDef --gallery-image-version $newVersion --os-snapshot $datadisk --target-regions $location $location2 --replica-count 2

