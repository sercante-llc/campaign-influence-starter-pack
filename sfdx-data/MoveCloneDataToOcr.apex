List<OpportunityContactRoleClone__c> clones = [SELECT Contact__c, Opportunity__c, Primary__c, Role__c FROM OpportunityContactRoleClone__c];
List<OpportunityContactRole> ocrs = new List<OpportunityContactRole>();

for(OpportunityContactRoleClone__c c : clones) {
    ocrs.add(
        new OpportunityContactRole(
            ContactId = c.Contact__c,
            OpportunityId = c.Opportunity__c,
            IsPrimary = c.Primary__c,
            Role = c.Role__c
        )
    );
}
insert ocrs;