#az config set core.login_experience_v2=off
$subsid = ""
$tenantId = ""
try
{
    az login --identity
}
catch {
    Write-Error -Message $_.Exception
    throw $_.Exception
}

az account list --all --output table
# az extension add --name desktopvirtualization
# az account set --subscription $subsid

# Write-Output "list"
# az desktopvirtualization hostpool list -g AVD-LAB-RG
