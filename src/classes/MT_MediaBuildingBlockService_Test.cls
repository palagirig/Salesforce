@isTest
private class MT_MediaBuildingBlockService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }
  @isTest static void constructor() {
    Test.startTest();
    MT_MediaBuildingBlocks mbb = new MT_MediaBuildingBlocks(new List<MT_TvTarget__c>());
    Test.stopTest();
  }

  testmethod static void getMediaBuildingBlocksByIds() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];
    MT_TvTarget__c mb = (MT_TvTarget__c) new MT_MediaBuildingBlockSelector().getRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    }).get(0);

    Test.startTest();

    system.assert(!MT_MediaBuildingBlockService.getMediaBuildingBlocksByIds(new Set<ID>{
      mb.Id
    }).isEmpty());
    system.assertEquals(mb.Id, MT_MediaBuildingBlockService.getMediaBuildingBlocksByIds(new Set<ID>{
      mb.Id
    }).get(0).Id);

    Test.stopTest();
  }

  testmethod static void getMediaBuildingBlocksByIds_2() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];
    MT_TvTarget__c mb = (MT_TvTarget__c) new MT_MediaBuildingBlockSelector().getRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    }).get(0);

    Test.startTest();

    system.assert(!MT_MediaBuildingBlockService.getMediaBuildingBlocksByIds(new Set<ID>{
      mb.Id
    }, new Set<String>{
      'Name'
    }).isEmpty());
    system.assertEquals(mb.Id, MT_MediaBuildingBlockService.getMediaBuildingBlocksByIds(new Set<ID>{
      mb.Id
    }, new Set<String>{
      'Name'
    }).get(0).Id);

    Test.stopTest();
  }
}