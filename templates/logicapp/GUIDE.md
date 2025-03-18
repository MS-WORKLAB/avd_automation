# Logic App guide for AVD Image Update 

## Useful links

- [Azure Logic Apps](https://learn.microsoft.com/en-us/azure/logic-apps/logic-apps-overview)
- [Microsoft Graph API for MSTeams](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicapp.jpg)

##  Summary

The Logic App monitors a specific Teams Channel for messages containing the keyword "AVD". Upon detecting such messages, it parses the message details from JSON format to extract relevant information. Based on the parsed data, the Logic App determines the associated process and divides the routine into three distinct jobs. These jobs utilize variables defined within the Microsoft Teams chat for customization.

All these configurations are parameterized, allowing users to modify them according to their specific requirements.

⚠️ Two of the loggic app triggers need '=' sign to get dynamic parameter for next steps.
⚠️ You will need to modify MS Teams and Automation Account steps in the Logic App after initializing your connections.

##  Examples

```bash
AVD: new image  
```
triggers Automation Account NewImage
##
```bash
AVD: version based = MASTER-0-0-2  
```
triggers Automation Account UpdateImage
##
```bash
AVD: update host = 12 
```
triggers Automation Account NewHosts


## Design View

<details><summary>Show Content</summary>

![LogicAppView](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicview.jpg)

</p>
</details> 

## Screen guide

<details><summary>Show Content</summary>

![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335025.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335026.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335027.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335028.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335029.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335030.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335031.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335032.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335033.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335034.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335035.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335036.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335037.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335038.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335039.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335040.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335041.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335042.jpg)
![scr](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/logicscr/screenshot.1741335043.jpg)

</p>
</details> 

[![Back To Install](https://github.com/MS-WORKLAB/avd_automation/blob/main/templates/more/back.png)](https://github.com/MS-WORKLAB/avd_automation)