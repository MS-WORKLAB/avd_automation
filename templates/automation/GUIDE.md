# Automation Account guide for AVD Image Update 

## Useful links

- [Azure Automation Account](https://learn.microsoft.com/en-us/azure/automation/overview)

##  Summary

The Logic App monitors a specific Teams Channel for messages containing the keyword "AVD". Upon detecting such messages, it parses the message details from JSON format to extract relevant information. Based on the parsed data, the Logic App determines the associated process and divides the routine into three distinct jobs. These jobs utilize variables defined within the Microsoft Teams chat for customization.

All these configurations are parameterized, allowing users to modify them according to their specific requirements.

⚠️ Two of the loggic app triggers need '=' sign to get dynamic parameter for next steps.
⚠️ You will need to modify MS Teams and Automation Account steps in the Logic App after initializing your connections.

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
