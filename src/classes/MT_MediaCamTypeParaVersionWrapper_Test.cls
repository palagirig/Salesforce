@isTest
private class MT_MediaCamTypeParaVersionWrapper_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void testWrapper() {
    MT_MediaCampaignType__c mct = [SELECT Id From MT_MediaCampaignType__c Limit 1];

    Test.startTest();

    Test.stopTest();

  }
}