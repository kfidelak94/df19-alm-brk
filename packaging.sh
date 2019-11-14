# Import auto pilot
source ./autopilot.sh
sbx=DreamSB1
pkgname=dh`date +"%s"`

# Cleanup
rm -rf ./dreamhouse-lwc
node ./testing.js
#sfdx force:package:uninstall -p 04t6g0000012ngIAAQ -u $sbx -w 10 > /dev/null 2>&1 &
sfdx force:package:install --package 04t6g0000013QrDAAU -w 10 -u $sbx -r > /dev/null 2>&1 &

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
dprintf "sfdx force:package:create -n $pkgname -t Unlocked -r force-app/"
dprintf "sfdx force:package:version:create -p $pkgname -x"
dprintf "sfdx force:org:open -u $sbx"
dprintf "sfdx force:package:install --package 04t6g0000013QrIAAU -w 10 -u $sbx -r"
echo '*******Now we will make another change to the code in VS Code'
dprintf "sfdx force:source:push -u mydhdev"
dprintf "sfdx force:org:open -u mydhdev"
dprintf "sfdx force:package:version:create -p $pkgname -x"
dprintf "sfdx force:package:install --package 04t6g0000013QvVAAU -w 10 -u $sbx -r"

#demo cleanup
#sfdx force:package:update -p "DH19pkg" -n "pkg`date +"%s"`" > /dev/null
