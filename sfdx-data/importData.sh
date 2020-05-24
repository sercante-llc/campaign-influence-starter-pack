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

echo "Importing CampaignInfluence Records"
#this one is weird, we have to import to a custom object, then use APEX to create the CampaignInfluence records.
#sign all because bulk:upsert can't get a good handle on Model.DeveloperName
sfdx force:data:bulk:upsert -i extId__c -w 2 -s CampaignInfluenceClone__c -f ./CampaignInfluences.csv
sfdx force:apex:execute -f MoveCloneDataToCampaignInfluence.apex --loglevel=FATAL

echo "Importing OpportunityContactRole Records"
#this one is weird, we have to import to a custom object, then use APEX to create the OCR records. 
#sigh all because OCRs can't have an External Record ID
sfdx force:data:bulk:upsert -i extId__c -w 2 -s OpportunityContactRoleClone__c -f ./OpportunityContactRoles.csv
sfdx force:apex:execute -f MoveCloneDataToOcr.apex --loglevel=FATAL
