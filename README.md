# Create automated process for AVD Image Update 
This repo contains simple templates and script to ...........

## Useful links
- [quick-start-custom-image](https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.devcenter/devbox-with-customized-image/customized-image/customized-image.bicep)

## Summary

- Create a New VM from an Existing Image Version in Azure Gallery:

    - Use the Azure CLI or ARM template to deploy a new virtual machine (VM) based on a specific image version from the Azure Marketplace or custom image gallery.
    - Customize the VM configuration (size, network settings, etc.) based on requirements.
    - Provision and deploy the VM, ensuring it is ready for use within your environment.
    - Create a New Image Version Based on a Specific VM:

- Capture the state of an existing VM by creating a custom image version from it.
    - Use the Azure CLI or ARM template to automate the process of creating a new image version.
    - The new image version will be based on the VM’s current configuration, including installed software, settings, and customizations.
    - Create New Hosts for Azure Virtual Desktop (AVD) Session Hosts:

- Automate the creation of new AVD session host VMs by using an existing image or custom image version.
    - Configure the new hosts as part of the AVD environment, ensuring they are added to the correct host pool and ready for user sessions.
    - Implement automation to scale the number of session hosts dynamically, ensuring optimal performance and resource availability for end-users.


### TL;DR; Steps
1. Create a Service Principal 
2. Create Automation Account for 3 main tasks 
    a. New VM Based on AZ Gallery Image
    b. Capture existing VM as new Version
    c. Create new AVD Hosts
3. Create Logic App to trigger automations


## NOTE: Image Builder Managed Identity
The Azure Image Builder needs a Managed Identity to be able to create the image. So you need to add a new (or existing) Managed Identity in the imageTemplate (Microsoft.VirtualMachineImages/imageTemplates) that needs to have a custom role definition assigned. as described below. The Role Assignment can be done on the whole RG hosting the image Library

```json
{
    "Name": "Azure Image Builder <Image-Name>",
    "IsCustom": true,
    "Description": "Image Builder access to create resources for the image build, you should delete or split out as appropriate",
    "Actions": [
        "Microsoft.Compute/galleries/read",
        "Microsoft.Compute/galleries/images/read",
        "Microsoft.Compute/galleries/images/versions/read",
        "Microsoft.Compute/galleries/images/versions/write",

        "Microsoft.Compute/images/write",
        "Microsoft.Compute/images/read",
        "Microsoft.Compute/images/delete"
    ],
    "NotActions": [
  
    ],
    "AssignableScopes": [
      "/subscriptions/<subscriptionID>/resourceGroups/<rgName>"
    ]
  }





```

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

⚠️ You will need to modify some steps in the Logic App after initializing your connections. [LogicAppQuide](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/logicapp/quide.md)

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMS-WORKLAB%2Favd_automation%2Fmain%2Ftemplates%2Flogicapp%2Fazuredeploy.json)

