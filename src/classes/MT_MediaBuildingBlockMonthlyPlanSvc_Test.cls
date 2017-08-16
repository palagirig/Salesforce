@isTest
private class MT_MediaBuildingBlockMonthlyPlanSvc_Test {

  @testSetup static void setup() {
    MT_Test.init();
  }
  testmethod static void getMediaBuildingBlockMonthlyPlansByParentIds() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];
    MT_TvTarget__c mbb = (MT_TvTarget__c) new MT_MediaBuildingBlockSelector().getRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    }).get(0);

    Test.startTest();

    system.assert(!MT_MediaBuildingBlockMonthlyPlanService.getMediaBuildingBlockMonthlyPlansByParentIds(new Set<ID>{
      mc.Id
    }).isEmpty());
    system.assertEquals(5, MT_MediaBuildingBlockMonthlyPlanService.getMediaBuildingBlockMonthlyPlansByParentIds(new Set<ID>{
      mc.Id
    }).size());

    Test.stopTest();
  }
  testmethod static void getMediaBuildingBlockMonthlyPlansWithMediaFlightsByParentIds() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];
    MT_TvTarget__c mbb = (MT_TvTarget__c) new MT_MediaBuildingBlockSelector().getRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    }).get(0);

    Test.startTest();

    system.assert(!MT_MediaBuildingBlockMonthlyPlanService.getMediaBuildingBlockMonthlyPlansWithMediaFlightsByParentIds(new Set<ID>{
      mc.Id
    }).isEmpty());
    system.assertEquals(5, MT_MediaBuildingBlockMonthlyPlanService.getMediaBuildingBlockMonthlyPlansWithMediaFlightsByParentIds(new Set<ID>{
      mc.Id
    }).size());

    Test.stopTest();
  }
}