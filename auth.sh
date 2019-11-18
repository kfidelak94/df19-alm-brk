# Import auto pilot
source ./autopilot.sh

dprintf "sfdx force:auth:web:login --setalias Prod --setdefaultdevhubusername"
dprintf "sfdx force:auth:web:login --setalias DevSB1 --instanceurl https://test.salesforce.com"
dprintf "sfdx force:auth:web:login --setalias UATFull --instanceurl https://test.salesforce.com"
dprintf "sfdx force:auth:web:login --setalias ProdMask
dprintf "sfdx force:auth:web:login --setalias DreamSB1 --instanceurl https://test.salesforce.com"
