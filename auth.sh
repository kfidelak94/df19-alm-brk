# Import auto pilot
source ./autopilot.sh

dprintf "sfdx force:auth:web:login --setalias Prod --setdefaultdevhubusername"
dprintf "sfdx force:auth:web:login --setalias DevSB --instanceurl https://test.salesforce.com"
dprintf "sfdx force:auth:web:login --setalias UAT --instanceurl https://test.salesforce.com"
dprintf "sfdx force:auth:web:login --setalias DreamSB1 --instanceurl https://test.salesforce.com"
