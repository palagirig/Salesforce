/************************************************************************************************************
Name:  		MT_ProSaOrderService_Test
======================================================
Purpose: 	Test class for MT_ProSaOrders, MT_ProSaOrderService and MT_ProSaOrderSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
15.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_ProSaOrderService_Test {
  @testSetup static void setup() {
    MT_Test.init();

    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    Opportunity opp = [Select Id FROM Opportunity limit 1];
    System.assertNotEquals(null, opp);

    P7S1_OpportunityApproval__c oppApp = [Select Id FROM P7S1_OpportunityApproval__c limit 1];
    System.assertNotEquals(null, oppApp);
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_ProSaOrders amp = new MT_ProSaOrders(new List<MT_ProSaOrder__c>());
    Test.stopTest();
  }

  testmethod static void getProSaOrdersByMediaCampaignIds() {
    MT_MediaCampaign__c mc = [SELECT Id FROM MT_MediaCampaign__c limit 1];
    System.assertNotEquals(null, mc);

    MT_ProSaOrder__c pso = [SELECT Id FROM MT_ProSaOrder__c limit 1];
    System.assertNotEquals(null, pso);

    Test.startTest();

    System.assert(!MT_ProSaOrderService.getProSaOrdersByMediaCampaignIds(new Set<Id>{
      mc.Id
    }).isEmpty());
    System.assert(MT_ProSaOrderService.getProSaOrdersByMediaCampaignIds(new Set<Id>()).isEmpty());
    System.assertEquals('123334', MT_ProSaOrderService.getProSaOrdersByMediaCampaignIds(new Set<Id>{
      mc.Id
    }).get(0).MT_OrderNumber__c);

    Test.stopTest();
  }

  testmethod static void getProSaOrdersByMediaCampaignIdsWithFields() {
    MT_MediaCampaign__c mc = [SELECT Id FROM MT_MediaCampaign__c limit 1];
    System.assertNotEquals(null, mc);

    MT_ProSaOrder__c pso = [SELECT Id FROM MT_ProSaOrder__c limit 1];
    System.assertNotEquals(null, pso);

    Test.startTest();

    System.assert(!MT_ProSaOrderService.getProSaOrdersByMediaCampaignIds(new Set<Id>{
      mc.Id
    }, new Set<String>{
      'MT_OrderNumber__c'
    }).isEmpty());
    System.assert(MT_ProSaOrderService.getProSaOrdersByMediaCampaignIds(new Set<Id>(), new Set<String>{
      'MT_OrderNumber__c'
    }).isEmpty());
    System.assertEquals('123334', MT_ProSaOrderService.getProSaOrdersByMediaCampaignIds(new Set<Id>{
      mc.Id
    }, new Set<String>{
      'MT_OrderNumber__c'
    }).get(0).MT_OrderNumber__c);

    Test.stopTest();
  }
}