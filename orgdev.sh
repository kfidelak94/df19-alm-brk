# assign variables
gitusername=dfalmteam
devsb=DevSB
uat=UAT

# Import auto pilot
source ./autopilot.sh

# Cleanup
rm -rf ./dfdemo
rm -rf ./dfdemo_working
hub delete -y $gitusername/dfdemo > /dev/null 2>&1
node ./testing.js

# Demo script
dprintf "mkdir dfdemo"
dprintf "cd dfdemo"
dprintf "git init"
dprintf "sfdx force:project:create -n myproject"
dprintf "cd myproject"
dprintf "git add ."
dprintf "git commit -m 'commit project'"
dprintf "git remote add origin https://github.com/$gitusername/dfdemo.git"
dprintf "hub create"
dprintf "git push -u origin master"
git push origin -d feature1 > /dev/null 2>&1
git push origin -d uat > /dev/null 2>&1
git checkout -b uat > /dev/null 2>&1
git push origin uat > /dev/null 2>&1

dprintf "sfdx force:source:pull -u $devsb" 
echo '*******Now we will make a change in the Sandbox'
dprintf "sfdx force:org:open -u $devsb"
dprintf "sfdx force:source:pull -u $devsb"
echo '*******Now we will create and checkout a new feature branch for our changes'
dprintf "git branch feature1"
dprintf "git checkout feature1"
echo '*******And add and commit the changes to the feature branch'
dprintf "git add ."
dprintf "git commit -m 'My first feature commit'"
echo '*******Now we will push the changes to the remote repository feature branch'
dprintf "git push -u origin feature1"
echo '*******Now we will create a Pull Request'
dprintf "hub pull-request -b uat -h feature1"
echo '*******Now we will go into GitHub and review and merge the Pull Request'
dprintf "mkdir ../../dfdemo_working"
dprintf "cd ../../dfdemo_working"
dprintf "git clone https://github.com/$gitusername/dfdemo"
dprintf "cd dfdemo/myproject"
dprintf "git pull origin uat"
dprintf "sfdx force:source:deploy -p force-app/ -u $uat -w 10"
dprintf "sfdx force:org:open -u $uat"
dprintf "hub pull-request -b master -h uat"
