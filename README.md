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
1. Create a Dev Center
2. Create a Vnet (or use an existing one) and make the vnet connection - attach it to the Dev Center
3. Create a Project
4. Run the the Bicep deployment
5. Attach the Gallery created by the bicep to the Dev Center
6. Create a Dev Box Definition in the Dev Center

### WSL in custom image
The custom image created by the Bicep is having WSL2 installed. The WSL2 is enabled and updated, but when you boot for the first time it asks you to update WSL again (currently to version 2.4.11).
- to update open a terminal with administrator rights and run `wsl.exe --update`. 
- To install UBUNTU 22.04 run `wsl.exe --install -d Ubuntu-22.02`
    - Alternatively you can install UBUNTU 24.04 with `wsl.exe --install -d Ubuntu-24.04`


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





# Deploy Logic App & Automation Account

Click the button below to deploy this Logic App and Automation Account to your Azure subscription:

service principal creation az ad sp create-for-rbac --name "myServicePrincipal" --role "Contributor"

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMS-WORKLAB%2Favd_automation%2Fmain%2Ftemplates%2Fautomation%2Fazuredeploy.json)

