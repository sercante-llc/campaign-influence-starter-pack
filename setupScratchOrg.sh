#!/bin/bash
set -e

#Added this as I've been burned too many times pulling reports from a scratch org, creating a new one to test them out then losing the changes
read -p "Are you sure there are NO uncommitted changes to the Reports? Proceeding will delete the reports & dashboards folder. y/N" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi
echo ""

#ok, back to our regularly scheduled programming
sfdx force:apex:execute -f sfdx-data/EnsureUserHasMarketing.apex --loglevel=FATAL

echo "Installing Pardot package (pi): 'Pardot Package@4.74'"
# get the latest package version id from the links here: https://pardot-appexchange.herokuapp.com/
# change this in Jenkinsfile, AND the DEMO jenkins file
sfdx force:package:install --package 04t1W000000cRas -w 20 --noprompt

echo "Doing initial push of source"
#we can NOT push dashboards and reports in this first push
sfdx force:source:deploy -m Settings:Security #this needs to be done before the permission set is pushed
rm -rf force-app/main/default/dashboards
rm -rf force-app/main/default/reports
sfdx force:source:push

echo "Assigning permission set"
sfdx force:user:permset:assign --permsetname "Campaign_Influence_Sercante_Labs"
sfdx force:user:permset:assign --permsetname "Campaign_Influence_Demo_Data"

echo "Setting up test data"
cd sfdx-data
sh importData.sh
cd ..

echo "Pushing reports and dashboards, which have to be done after permset is pushed"
git checkout force-app/main/default/dashboards
git checkout force-app/main/default/reports
#sfdx force:source:push
sfdx force:source:deploy --manifest manifest/package.xml -l RunLocalTests

#echo "Generating new password for the scratch org user"
sfdx force:user:password:generate
echo "You should be ready to go!"
