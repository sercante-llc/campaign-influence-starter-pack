#!/bin/bash
set -e
sfdx force:apex:execute -f sfdx-data/EnsureUserHasMarketing.apex --loglevel=FATAL

echo "Installing Pardot package (pi): 'Pardot Package@4.74'"
# get the latest package version id from the links here: https://pardot-appexchange.herokuapp.com/
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
#sfdx force:user:password:generate
echo "You should be ready to go!"
