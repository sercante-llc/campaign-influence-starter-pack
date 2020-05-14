#!/bin/bash
set -e

echo "Installing Pardot package: 'Pardot Package@4.68.0.1'"
sfdx force:package:install --package 04t1W000000kpBDQAY -w 20
#echo "Installing Sercante Core Objects package: 'Pardot Internal Integration@1.6.0.1'"
#sfdx force:package:install --package 04tf4000001VsyYAAS -w 20

# echo "Doing initial push of source"
# sfdx force:source:push

# echo "Setting up test data"
# cd sfdx-data
# sh importData.sh
# cd ..
echo "Generating new password for the scratch org user"
sfdx force:user:password:generate
echo "You should be ready to go! In VSCode, bring up the command pallette and Refresh SObject Definitions"
