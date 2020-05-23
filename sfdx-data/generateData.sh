# Step 1: remove current data exported
#rm *.csv

# Step 2: export the data into CSV format
# param 1 = ObjectName
# param 2 = SOQL
# param 3 = IF we should replace the Id in the file header with extId__c
function getData {
    echo "Getting $1 Records"
    sfdx force:data:soql:query --resultformat csv -q "$2" > "$1s.csv"
}

#getData Account "SELECT extId__c, Name FROM Account" true
#getData Contact "SELECT extId__c, FirstName, LastName, Account.extId__c FROM Contact" true
#getData Campaign "SELECT extId__c, IsActive, ActualCost, BudgetedCost, Name, Description, EndDate, Parent.extId__c, StartDate, Status, Type FROM Campaign" true
#getData CampaignMember "SELECT extId__c, Campaign.extId__c, Contact.extId__c, Status FROM CampaignMember" false
#getData Opportunity "SELECT extId__c, Name, Amount, CloseDate, Description, LeadSource, Probability, StageName, Type, Account.extId__c, Campaign.extId__c FROM Opportunity" true
#getData OpportunityContactRole "SELECT Opportunity.extId__c, Contact.extId__c, Role, IsPrimary FROM OpportunityContactRole" false