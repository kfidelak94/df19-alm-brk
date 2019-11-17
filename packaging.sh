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
dprintf "##### Start by cloning the Dreamhouse sample app ######"
dprintf "git clone https://github.com/dreamhouseapp/dreamhouse-lwc"
dprintf "cd ./dreamhouse-lwc" 
dprintf "##### Now open VS Code to browse the contents of the project #####"
dprintf "code ."
dprintf "##### Now we will create a scratch org and push source and data into it to do our development and testing #####"
dprintf "sfdx force:org:create -f config/project-scratch-def.json -a mydhdev"
dprintf "sfdx force:source:push -u mydhdev"
dprintf "sfdx force:user:permset:assign -n dreamhouse -u mydhdev"
dprintf "sfdx force:data:tree:import -p data/sample-data.json -u mydhdev"
dprintf "##### Now we will open the scratch org to make a change to the Property Explorer page of the Dreamhouse app #####"
dprintf "sfdx force:org:open -u mydhdev"
dprintf "##### Now we will pull the changes we just made to the local project directory using the source tracking capability #####"
dprintf "sfdx force:source:pull -u mydhdev"
dprintf "##### We will now create a package to be able to manage and version the application #####"
dprintf "sfdx force:package:create -n $pkgname -t Unlocked -r force-app/"
dprintf "##### And create a package version to be able to install it into other orgs #####"
dprintf "sfdx force:package:version:create -p $pkgname -x"
dprintf "##### We will install the package into a test Sandbox so we will first open the Sandbox here #####"
dprintf "sfdx force:org:open -u $sbx"
dprintf "##### And now install the package version into the Sandbox where we can verify the change #####"
dprintf "sfdx force:package:install --package 04t6g0000013QrIAAU -w 10 -u $sbx -r"
dprintf "##### Now we will make another change to the code in VS Code to increase the max price filter to 1500000 #####"
dprintf "##### And now push the changes that were just made locally to the scratch org for verification #####"
dprintf "sfdx force:source:push -u mydhdev"
dprintf "##### And open the scratch org to verify the change looks good #####"
dprintf "sfdx force:org:open -u mydhdev"
dprintf "##### Now that the change has been verified we will create a second package version to be able to install this new version of the app #####"
dprintf "sfdx force:package:version:create -p $pkgname -x"
dprintf "##### And then install this package version into the test Sandbox to again verify in this environment #####"
dprintf "sfdx force:package:install --package 04t6g0000013QvVAAU -w 10 -u $sbx -r"

#demo cleanup
#sfdx force:package:update -p "DH19pkg" -n "pkg`date +"%s"`" > /dev/null
