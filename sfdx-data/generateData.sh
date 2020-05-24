# Step 1: remove current data exported
#rm *.csv

# Step 2: export the data into CSV format
# param 1 = ObjectName
# param 2 = SOQL
function getData {
    echo "Getting $1 Records"
    if $3
    then
      echo "Making sure extId__c is populated for all records"
      echo "List<$1> items = [SELECT Id, extId__c FROM $1 WHERE extId__c = NULL];for($1 i : items) i.extId__c=i.Id; update items;" > setExtIds.apex
      sfdx force:apex:execute -f setExtIds.apex --loglevel=FATAL
      rm setExtIds.apex
    fi
    sfdx force:data:soql:query --resultformat csv -q "$2" > "$1s.csv"
}

getData Account "SELECT extId__c, Name, CreatedDate FROM Account" true
getData Contact "SELECT extId__c, FirstName, LastName, Account.extId__c, CreatedDate FROM Contact" true
getData Campaign "SELECT extId__c, IsActive, ActualCost, BudgetedCost, Name, Description, EndDate, Parent.extId__c, StartDate, Status, Type FROM Campaign" true
getData CampaignMember "SELECT extId__c, Campaign.extId__c, Contact.extId__c, Status, CreatedDate FROM CampaignMember" true
getData Opportunity "SELECT extId__c, Name, Amount, CloseDate, Description, LeadSource, Probability, StageName, Type, Account.extId__c, Campaign.extId__c, CreatedDate FROM Opportunity" true
getData OpportunityContactRole "SELECT Id, Opportunity.extId__c, Contact.extId__c, Role, IsPrimary, CreatedDate FROM OpportunityContactRole" false
sed -i "1s/.*/extId__c,Opportunity__r.extId__c,Contact__r.extId__c,Role__c,IsPrimary__c,CreatedDate/" OpportunityContactRoles.csv
getData CampaignInfluence "SELECT extId__c, Campaign.extId__c, Contact.extId__c, Influence, Opportunity.extId__c, CreatedDate FROM CampaignInfluence WHERE Model.DeveloperName = 'primaryModel'" true
sed -i "1s/.*/extId__c,Campaign__r.extId__c,Contact__r.extId__c,Influence__c,Opportunity__r.extId__c,CreatedDate/" CampaignInfluences.csv
