# Create automated process for AVD Image update 
This repo contains simple templates and script to Automate VM and AVD session host provisioning in Azure using MS Teams chat and LogicApps to trigger an Automation Account, leveraging Azure CLI for VM deployment, image creation, and scaling based on Azure Compute Gallery images.

## Useful links
- [Azure-Compute-Gallery](https://learn.microsoft.com/en-us/azure/virtual-machines/azure-compute-gallery)
- [AZ-desktopvirtualization](https://learn.microsoft.com/en-us/cli/azure/desktopvirtualization/hostpool?view=azure-cli-latest)

## Disclaimer
This project is not an official Microsoft-supported implementation. It is provided as-is, without any warranties or guarantees. Use at your own risk. Microsoft is not responsible for any issues, damages, or liabilities arising from the use of this project.

## Summary

- Create a New VM from an Existing Image Version in Azure Compute Gallery:

    - Use MS Teams chat to trigger Automation Account via LogicApp.
    - Use Azure CLI to deploy a new virtual machine based on a specific image version from Azure Compute gallery.
    - You can Customize the VM configuration (size, network settings, etc.) based on requirements.
    - Provision and deploy the VM, you can implement changes on MASTERVM-#-#-# ensuring it is ready for use within your environment.

- Create a New Image Version Based on a Specific VM:

    - Use MS Teams chat using VM Name as variable input to trigger Automation Account via LogicApp.
    - Capture the state of an existing VM by creating a custom image version from it.
    - Use Azure CLI to automate the process of creating a new image version into your definition.
    - The new image version will be based on the VM’s current configuration, including installed software, settings, and customizations.
     
- Create New Hosts for Azure Virtual Desktop (AVD) Session Hosts:

    - Use MS Teams chat using number of hosts as variable input to trigger Automation Account via LogicApp.
    - Automate the creation of new AVD session host VMs by using an existing Azure Compute Gallery image.
    - Configure the new hosts as part of the AVD environment, ensuring they are added to the correct host pool and ready for user sessions.
    - Implement automation to scale the number of session hosts dynamically, ensuring optimal performance and resource availability for end-users.

## Requirements

 - Active Azure Subscription
 - At least Microsoft Entra ID P2 
 - Azure Compute Gallery
 - VM Image Definition
 - At laest one VM image version
 - AVD Host Pool



### TL;DR; Steps
1. Create a Service Principal 
2. Create Automation Account for 3 main tasks 
    a. New VM Based on AZ Compute Gallery Image
    b. Capture existing VM as new Version
    c. Create new AVD Hosts
3. Create Logic App to trigger automations via MS Teams

# Video Snap

https://github.com/user-attachments/assets/1f89b0d9-ed04-4b33-9307-ed0e96356568

## Next Steps

- Parallel execution of hosts creation
- include Azure Image Builder on process
- Automation to generalize vm

# Service Principal

Create Service Principal for automation tasks and keep the result values:
```bash
$subs = az account list --output json | ConvertFrom-Json; $subs | ForEach-Object {Write-Host "$($subs.IndexOf($_) + 1). $($_.name) ($($_.id))"}; $selection = Read-Host "Please select Subscription number"; az account set --subscription $subs[$selection - 1].id
az ad sp create-for-rbac --name "AVDServicePrincipal" --role "Contributor" --scope "/subscriptions/$(az account show --query id --output tsv)"
```
[![Launch Cloud Shell](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/button.png)](https://shell.azure.com/?shell=azurecli)

# Automation Account

Click the button below to deploy the Automation Account to your Azure subscription:


[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMS-WORKLAB%2Favd_automation%2Fmain%2Ftemplates%2Fautomation%2Fazuredeploy.json)

# [Optional] Triger via Microsoft Teams using Logic App

Click the button below to deploy the Logic App to your Azure subscription:

⚠️ You will need to modify some steps in the Logic App after initializing your connections. [LogicApp Guide](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/logicapp/GUIDE.md)

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMS-WORKLAB%2Favd_automation%2Fmain%2Ftemplates%2Flogicapp%2Fazuredeploy.json)

