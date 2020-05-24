List<CampaignInfluenceClone__c> clones = [SELECT Contact__c, Opportunity__c, Campaign__c, ModelDeveloperName__c, Influence__c, CreatedDate FROM CampaignInfluenceClone__c];
CampaignInfluenceModel model = [SELECT Id FROM CampaignInfluenceModel WHERE DeveloperName = 'primaryModel'];
List<CampaignInfluence> cis = new List<CampaignInfluence>();

for(CampaignInfluenceClone__c c : clones) {
    cis.add(
        new CampaignInfluence(
            ContactId = c.Contact__c,
            OpportunityId = c.Opportunity__c,
            CampaignId = c.Campaign__c,
            Influence = c.Influence__c,
            ModelId = model.Id,
            CreatedDate = c.CreatedDate
        )
    );
}
insert cis;
delete clones;