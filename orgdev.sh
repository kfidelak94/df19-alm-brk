# Import auto pilot
source ./autopilot.sh

# Cleanup
rm -rf ./df3
rm -rf ./df4
rm -rf ./df3_working
rm -rf ./df4_working
hub delete -y kfidelak94/df4 > /dev/null 2>&1
node ./testing.js

# Demo script
# dprintf "git clone https://github.com/kfidelak94/df3"
# dprintf "cd df3/myproj"
dprintf "mkdir df4"
dprintf "cd df4"
dprintf "git init"
dprintf "sfdx force:project:create -n myproject"
dprintf "cd myproject"
dprintf "git add ."
dprintf "git commit -m 'commit project'"
dprintf "git remote add origin https://github.com/kfidelak94/df4.git"
dprintf "hub create"
dprintf "git push -u origin master"
git push origin -d feature1 > /dev/null 2>&1
git push origin -d integrate > /dev/null 2>&1
git checkout -b integrate > /dev/null 2>&1
git push origin integrate > /dev/null 2>&1

dprintf "sfdx force:source:pull -u SBtest"
echo '*******Now we will make a change in the Sandbox'
dprintf "sfdx force:org:open -u SBtest"
dprintf "sfdx force:source:pull -u SBtest"
echo '*******Now we will create and checkout a new feature branch for our changes'
dprintf "git branch feature1"
dprintf "git checkout feature1"
echo '*******And add and commit the changes to the feature branch'
dprintf "git add ."
dprintf "git commit -m 'My first feature commit'"
echo '*******Now we will push the changes to the remote repository feature branch'
dprintf "git push -u origin feature1"
echo '*******Now we will create a Pull Request'
dprintf "hub pull-request -b integrate -h feature1"
echo '*******Now we will go into GitHub and review and merge the Pull Request'
dprintf "mkdir ../../df4_working"
dprintf "cd ../../df4_working"
dprintf "git clone https://github.com/kfidelak94/df4"
dprintf "cd df4/myproject"
dprintf "git pull origin integrate"
dprintf "sfdx force:source:deploy -p force-app/ -u SBtest2 -w 10"
dprintf "sfdx force:org:open -u SBtest2"
dprintf "hub pull-request -b master -h integrate"
