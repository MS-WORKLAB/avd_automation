# Automation Account guide for AVD Image Update 

## Useful links

- [Azure Automation Account](https://learn.microsoft.com/en-us/azure/automation/overview)

##  Summary

The automation logic is divided into three main processes:

1️⃣ The first process creates a new VM based on the latest image version from an existing Azure Compute Gallery. This VM is ready to receive new applications or updates. Once it is generalized, the next process begins.

2️⃣ The second process takes the VM name as input via Microsoft Teams and creates a new image version. This version is then prepared for deployment to the hosts within an AVD host pool.

3️⃣ Finally, the third runbook takes the number of VMs as a parameter and initiates the routine for provisioning and integrating the VMs including TAG: IMGVer:#.#.# as session hosts into the AVD infrastructure.


##  Details

| Parameter                     | Description |
|--------------------------------|-------------|
| Automation Account Name       | Name of the Azure Automation Account |
| > **Site Information**          |  |
| Subscription Id               | Subscription ID of AVD Host Pool, i.e. 00000000-0000-0000-0000-000000000000 |
| Tenant ID                     | Tenand ID of AVD Host Pool, i.e. 00000000-0000-0000-0000-000000000000  |
| Region Name                   | Region of AVD Host Pool, i.e. germanywestcentral |
| Resource Group Name           | Resource Group Name of AVD Host Pool |
| > **AVD Information**           |  |
| Host Pool Name                | Existing Host Pool Name |
| Vnet Name                     | VNET Name of Session Hosts, i.e. avd-vnet |
| Subnet Name                   | Subnet Name of Seassion Hosts, i.e. avd-snet |
| New Host Name Prefix          | Prefix for newly created AVD Session Hosts, i.e. AVDVM- |
| VM SKU Size                   | SKU Size for your new AVD Session Hosts, i.e. Standard_D2as_v5 |
| Local Username                | Local Administrator Username for VMs |
| Local Password                | Local Administrator Password for VMs |
| > **Image Information**         |  |
| Azure Gallery Name            | Azure Gallery name |
| Image Definition              | Azure Gallery Image Definition Name |
| Second Image Region           | Second Image Region Location, i.e. eastus |
| > **Domain Information**        |  |
| Domain Name                   | Domain name, i.e. contoso.lab |
| Domain OU Path                | OU Path for your AVD Session Hosts, i.e. OU=AVD,DC=contoso,DC=lab |
| Domain Username               | Add user with delegate permissions for domain join i.e. user@contoso.com |
| Domain Password               | Domain User password |
| > **Service Principal**           |  |
| Service Principal Client ID   | Service Principal App/Client ID result from Azure cloud shell First Step **Create Service Principal** |
| Service Principal Secret      | Service Principal Secret result from Azure cloud shell First Step **Create Service Principal** |

[![Back To Install](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/back.png)](https://github.com/MS-WORKLAB/avd_automation?tab=readme-ov-file#installation)