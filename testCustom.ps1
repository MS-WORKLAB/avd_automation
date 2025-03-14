#az config set core.login_experience_v2=off
$subsid = "d1857a3e-d145-4293-b1bf-b528dab49617"
$tenantId = "6a258e3f-f31d-45b8-a422-bd28c9636e4f"
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
