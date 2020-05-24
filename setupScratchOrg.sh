#!/bin/bash
set -e

echo "Installing Pardot package (pi): 'Pardot Package@4.68.0.1'"
sfdx force:package:install --package 04t1W000000kpBDQAY -w 20 --noprompt
#echo "Installing Pardot Integration package (b2bma): 'Pardot Internal Integration@1.6.0.1'"
#sfdx force:package:install --package 04tf4000001VsyYAAS -w 20

echo "Doing initial push of source"
#we need to NOT push dashboards and reports in this first push
sfdx force:source:deploy -m Settings:Security #this needs to be done before the permission set is pushed
rm -rf force-app/main/default/dashboards
rm -rf force-app/main/default/reports
sfdx force:source:push

echo "Assigning permission set"
sfdx force:user:permset:assign --permsetname "Campaign_Influence_Sercante_Labs"
sfdx force:user:permset:assign --permsetname "Campaign_Influence_Demo_Data"

echo "Pushing reports and dashboards, which have to be done after permset is pushed"
git checkout force-app/main/default/dashboards
git checkout force-app/main/default/reports
sfdx force:source:push

echo "Setting up test data"
cd sfdx-data
sh importData.sh
cd ..
#echo "Generating new password for the scratch org user"
#sfdx force:user:password:generate
echo "You should be ready to go! In VSCode, bring up the command pallette and Refresh SObject Definitions"
