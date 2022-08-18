#!/bin/bash
set -e

echo "Create scratch org with slightly different params than SFDX would"
sfdx force:org:create --noancestors --definitionfile config/project-scratch-def.json --json --durationdays 3 --setalias cispscatchorg --setdefaultusername

#ok, back to our regularly scheduled programming
sfdx force:apex:execute -f sfdx-data/EnsureUserHasMarketing.apex --loglevel=FATAL

echo "Installing Pardot package (pi): 'Pardot Package@4.87'"
# get the latest package version id from the links here: https://pardot-appexchange.herokuapp.com/
# change this in Jenkinsfile, AND the DEMO jenkins file
sfdx force:package:install --package 04t8Z000000tmdu -w 20 --noprompt

echo "Doing initial push of source"
#we can NOT push dashboards and reports in this first push
sfdx force:source:deploy -m Settings:Security #this needs to be done before the permission set is pushed
mv force-app/main/default/dashboards ./dashboards
mv force-app/main/default/reports ./reports
mv force-app/main/default/reportTypes ./reportTypes
sfdx force:source:push

echo "Assigning permission set"
sfdx force:user:permset:assign --permsetname "Campaign_Influence_Sercante_Labs"
sfdx force:user:permset:assign --permsetname "Campaign_Influence_Demo_Data"

echo "Setting up test data"
cd sfdx-data
sh importData.sh
cd ..

echo "Pushing reports and dashboards, which have to be done after permset is pushed"
mv ./dashboards force-app/main/default/dashboards
mv ./reports force-app/main/default/reports
mv ./reportTypes force-app/main/default/reportTypes
#sfdx force:source:push
sfdx force:source:deploy -l RunLocalTests -p "force-app/main/default/reports,force-app/main/default/dashboards"
#sfdx force:source:deploy --manifest manifest/package.xml -l RunLocalTests

#echo "Generating new password for the scratch org user"
sfdx force:user:password:generate
echo "You should be ready to go!"
