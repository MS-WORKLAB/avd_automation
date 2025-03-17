# Create automated process for AVD Image Update 
This repo contains simple templates and script to ...........

## Useful links
- [quick-start-custom-image](https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.devcenter/devbox-with-customized-image/customized-image/customized-image.bicep)

##  How-To / Summary
- Follow the steps in the [Quickstart: Configure Microsoft Dev Box](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service) until you reach the point of creating a custom image. So the prerequisite steps / resources required (and not covered by this Bicep) are:
    - Create a [Dev Center](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#create-a-dev-center)
        - Create a [Vnet](https://learn.microsoft.com/en-us/azure/dev-box/how-to-configure-network-connections?tabs=AzureADJoin#create-a-virtual-network-and-subnet) and [attach it to the dev center](https://learn.microsoft.com/en-us/azure/dev-box/how-to-configure-network-connections?tabs=AzureADJoin#attach-a-network-connection-to-a-dev-center)
        - Create a [Project](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#create-a-project)
- Before yoy proceed with the next steps, you need to create a custom image. The documentation is not 100% correct. At the time of writing (March 2025) the OS SKU suggested in the detailed steps is not supported, as a custom image for DevBox. 
    - Configure the Bicep.param file and run the deploy.azcli script (essentialy the same as the [quick-start-custom-image] [Create a custom image](https://learn.microsoft.com/en-us/azure/dev-box/how-to-customize-devbox-azure-image-builder). (BUT This is having a lot of issues - Powershell, not correct OS SKUs, no correct ARM templates - needs to be fixed)
    - [Configure the newly created galley / attach it to the Dev Center](https://learn.microsoft.com/en-us/azure/dev-box/how-to-configure-azure-compute-gallery#attach-a-gallery-to-a-dev-center)
    - Create a [Dev Box Definition](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#create-a-dev-box-definition)
- Create a [Dev Box Pool](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#create-a-dev-box-pool)
    - Provide [access to a dev box project](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-configure-dev-box-service#provide-access-to-a-dev-box-project)
- [Create a Dev Box](https://learn.microsoft.com/en-us/azure/dev-box/quickstart-create-dev-box?tabs=no-existing-dev-boxes#create-a-dev-box)

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

⚠️ You will need to modify some steps in the Logic App after initializing your connections.

### - [LogicAppQuide](https://github.com/MS-WORKLAB/avd_automation/templates/logicapp/quide.md)

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMS-WORKLAB%2Favd_automation%2Fmain%2Ftemplates%2Flogicapp%2Fazuredeploy.json)

