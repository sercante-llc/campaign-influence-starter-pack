#!/bin/bash
set -e

#Step 1, import the data :)

echo "Importing Account Records"
sfdx force:data:bulk:upsert -i extId__c -w 5 -s Account -f ./Accounts.csv

echo "Importing Contact Records"
sfdx force:data:bulk:upsert -i extId__c -w 5 -s Contact -f ./Contacts.csv

echo "Importing Campaign Records"
sfdx force:data:bulk:upsert -i extId__c -w 5 -s Campaign -f ./Campaigns.csv

echo "Importing CampaignMember Records"
sfdx force:data:bulk:upsert -i extId__c -w 5 -s CampaignMember -f ./CampaignMembers.csv

echo "Importing Opportunity Records"
sfdx force:data:bulk:upsert -i extId__c -w 5 -s Opportunity -f ./Opportunitys.csv

echo "Importing OpportunityContactRole Records"
#this one is weird, we have to import to a custom object, then use APEX to create the OCR records. 
#sigh all because OCRs can't have an External Record ID
sfdx force:data:bulk:upsert -i extId__c -w 5 -s OpportunityContactRoleClone__c -f ./OpportunityContactRoles.csv
sfdx force:apex:execute -f MoveCloneDataToOcr.apex --loglevel=FATAL
