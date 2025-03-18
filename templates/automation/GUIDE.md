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
| Automation Account Name       |  |
| **Site Information**          |  |
| Subscription Id               |  |
| Tenant ID                     |  |
| Region Name                   |  |
| Resource Group Name           |  |
| - AVD Information -           |  |
| Host Pool Name                |  |
| Vnet Name                     |  |
| Subnet Name                   |  |
| New Host Name Prefix          |  |
| VM SKU Size                   |  |
| Local Username                |  |
| Local Password                |  |
| - Image Information -         |  |
| Azure Gallery Name            |  |
| Image Definition              |  |
| Second Image Region           |  |
| - Domain Information -        |  |
| Domain Name                   |  |
| Domain OU Path                |  |
| Domain Username               |  |
| Domain Password               |  |
| - Service Principal           |  |
| Service Principal Client ID   |  |
| Service Principal Secret      |  |
