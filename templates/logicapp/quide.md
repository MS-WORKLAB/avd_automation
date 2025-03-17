# Create automated process for AVD Image Update 

## Useful links

- [Azure Logic Apps](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-overview)
- [Microsoft Graph API for MSTeams](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicapp.jpg)

##  Summary

The Logic App monitors a specific Teams Channel for messages containing the keyword "AVD". Upon detecting such messages, it parses the message details from JSON format to extract relevant information. Based on the parsed data, the Logic App determines the associated process and divides the routine into three distinct jobs. These jobs utilize variables defined within the Microsoft Teams chat for customization.

All these configurations are parameterized, allowing users to modify them according to their specific requirements.

⚠️ Two of the loggic app triggers need '=' sign to get dynamic parameter for next steps.

##  Examples

```bash
AVD: new image  
```
triggers Automation Account NewImage

```bash
AVD: version based = MASTER-0-0-2  
```
triggers Automation Account UpdateImage

```bash
AVD: update host = 12 
```
triggers Automation Account NewHosts