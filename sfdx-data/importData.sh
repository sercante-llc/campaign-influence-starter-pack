#!/bin/bash
set -e

#Step 1, import the data :)

echo "Importing Account Records"
sfdx force:data:bulk:upsert -i extId__c -w 2 -s Account -f ./Accounts.csv

echo "Importing Contact Records"
sfdx force:data:bulk:upsert -i extId__c -w 2 -s Contact -f ./Contacts.csv

echo "Importing Campaign Records"
sfdx force:data:bulk:upsert -i extId__c -w 2 -s Campaign -f ./Campaigns.csv

echo "Importing CampaignMember Records"
sfdx force:data:bulk:upsert -i extId__c -w 2 -s CampaignMember -f ./CampaignMembers.csv

echo "Importing Opportunity Records"
sfdx force:data:bulk:upsert -i extId__c -w 2 -s Opportunity -f ./Opportunitys.csv

echo "Importing OpportunityContactRole Records"
sfdx force:data:bulk:upsert -i extId__c -w 2 -s OpportunityContactRole -f ./OpportunityContactRoles.csv

echo "Importing CampaignInfluence Records"
sfdx force:data:bulk:upsert -i extId__c -w 2 -s CampaignInfluence -f ./CampaignInfluences.csv