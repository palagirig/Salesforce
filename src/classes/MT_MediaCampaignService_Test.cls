@isTest
private class MT_MediaCampaignService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }
  testmethod static void getMediaCampaignsByIds() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];

    Test.startTest();

    system.assert(!MT_MediaCampaignService.getMediaCampaignsByIds(new Set<ID>{
      mc.Id
    }).isEmpty());
    system.assertEquals(mc.Id, MT_MediaCampaignService.getMediaCampaignsByIds(new Set<ID>{
      mc.Id
    }).get(0).Id);

    Test.stopTest();
  }
  testmethod static void getMediaCampaignsByIds_2() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];

    Test.startTest();

    system.assert(!MT_MediaCampaignService.getMediaCampaignsByIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'MT_RunTimeTVStart__c'
    }).isEmpty());
    system.assertEquals(Date.today().addMonths(-2), MT_MediaCampaignService.getMediaCampaignsByIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'MT_RunTimeTVStart__c'
    }).get(0).MT_RunTimeTVStart__c);

    Test.stopTest();
  }
  testmethod static void isMediaBuildingBlockStructureChanged() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];

    Test.startTest();

    system.assert(!new MT_MediaCampaignSelector().getRecordsByIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'MT_HasMediaDigital__c', 'MT_HasMediaDooH__c', 'MT_HasMediaTV__c'
    }).isEmpty());
    MT_MediaCampaign__c mcAssert = (MT_MediaCampaign__c) new MT_MediaCampaignSelector().getRecordsByIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'MT_HasMediaDigital__c', 'MT_HasMediaDooH__c', 'MT_HasMediaTV__c'
    }).get(0);
    system.assertEquals(false, mcAssert.MT_HasMediaDigital__c);
    system.assertEquals(false, mcAssert.MT_HasMediaDooH__c);
    system.assertEquals(true, mcAssert.MT_HasMediaTV__c);

    mcAssert.MT_HasMediaTV__c = false;

    Test.stopTest();
  }
  testmethod static void postFlightPlanUpdate() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];

    Test.startTest();

    MT_MediaCampaign__c mcAssert = (MT_MediaCampaign__c) new MT_MediaCampaignSelector().getRecordsByIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'MT_HasMediaDigital__c', 'MT_HasMediaDooH__c', 'MT_HasMediaTV__c'
    }).get(0);

    MT_MediaCampaignService.postFlightPlanUpdate(mcAssert, 'Test');

    Test.stopTest();
  }
  testmethod static void notifyImaAboutFlightPlanUpdate() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c mc = [Select ID from MT_MediaCampaign__c limit 1];

    Test.startTest();

    MT_MediaCampaign__c mcAssert = (MT_MediaCampaign__c) new MT_MediaCampaignSelector().getRecordsByIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name', 'MT_HasMediaDigital__c', 'MT_HasMediaDooH__c', 'MT_HasMediaTV__c'
    }).get(0);
    MT_TvTarget__c mbAssert = (MT_TvTarget__c) new MT_MediaBuildingBlockSelector().getRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    }).get(0);
    mcAssert.MT_Responsible_IM_Agent__c = UserInfo.getUserId();
    MT_MediaCampaignService.notifyImaAboutFlightPlanUpdate(mcAssert, mbAssert.Id, 'Test');

    Test.stopTest();
  }
}