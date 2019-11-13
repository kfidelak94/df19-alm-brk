# Import auto pilot
source ./autopilot.sh
sbx=DevSB5

# Cleanup
rm -rf ./dreamhouse-lwc
node ./testing.js

# Demo script
dprintf "git clone https://github.com/dreamhouseapp/dreamhouse-lwc"
dprintf "cd ./dreamhouse-lwc" 
dprintf "code ."
dprintf "sfdx force:org:create -f config/project-scratch-def.json -a mydhdev"
dprintf "sfdx force:source:push -u mydhdev"
dprintf "sfdx force:user:permset:assign -n dreamhouse -u mydhdev"
dprintf "sfdx force:data:tree:import -p data/sample-data.json -u mydhdev"
echo '*******Now we will open the scratch org to make a change'
dprintf "sfdx force:org:open -u mydhdev"
dprintf "sfdx force:source:pull -u mydhdev"
dprintf "sfdx force:package:create -n DH19pkg -t Unlocked -r force-app/"
dprintf "sfdx force:package:version:create -p DH19pkg -x -w 10"
dprintf "sfdx force:org:open -u $sbx"
dprintf "sfdx force:package:install --package 04t6g0000012nDJAAY -w 10 -u $sbx -r"
echo '*******Now we will make another change to the code, in VS Code
dprintf "sfdx force:package:version:create -p DH19pkg -x -w 10"
dprintf "sfdx force:package:install --package 04t6g0000012ngIAAQ -w 10 -u $sbx -r"

#demo cleanup
sfdx force:package:uninstall -p 04t6g0000012ngIAAQ -u $sbx -w 10
sfdx force:package:update -p "DH19pkg" -n "pkg`date +"%s"`" > /dev/null
