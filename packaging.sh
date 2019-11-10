# Import auto pilot
source ./autopilot.sh

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
dprintf "sfdx force:package:create -n dhpkg -t Unlocked -r force-app/"
dprintf "sfdx force:package:version:create -p dhpkg -x -w 10"
dprintf "sfdx force:org:open -u SBtest2"
dprintf "sfdx force:package:install --package 04t3s000003OnVxAAK -u SBtest2 -r
echo '*******Now we will make another change to the code, in VS Code
dprintf "sfdx force:package:version:create -p dhpkg -x -w 10"
sfdx force:package:install --package XXXXXXX -u SBtest2 -r
