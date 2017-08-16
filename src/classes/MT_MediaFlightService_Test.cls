/************************************************************************************************************
Name:  		MT_MediaFlightService_Test
======================================================
Purpose: 	Test class for MT_MediaFlights, MT_MediaFlightService and MT_MediaFlightSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
16.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_MediaFlightService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_MediaFlights mf = new MT_MediaFlights(new List<MT_MediaFlight__c>());
    Test.stopTest();
  }

  testmethod static void getRecordsByIds() {
    MT_MediaFlight__c mf = [SELECT Id FROM MT_MediaFlight__c limit 1];
    System.assertNotEquals(null, mf);

    Test.startTest();

    System.assert(!MT_MediaFlightService.getRecordsByIds(new Set<Id>{
      mf.Id
    }).isEmpty());
    System.assert(MT_MediaFlightService.getRecordsByIds(new Set<Id>()).isEmpty());
    System.assertEquals(Date.today().addMonths(-5), MT_MediaFlightService.getRecordsByIds(new Set<Id>{
      mf.Id
    }).get(0).MT_StartDate__c);

    Test.stopTest();
  }

  testmethod static void getMediaFlightByParentIds() {
    MT_MediaFlight__c mf = [SELECT Id, MT_MediaBuildingBlockMonthlyPlan_ref__c FROM MT_MediaFlight__c limit 1];
    System.assertNotEquals(null, mf);

    Test.startTest();

    System.assert(!MT_MediaFlightService.getMediaFlightByParentIds(new Set<Id>{
      mf.MT_MediaBuildingBlockMonthlyPlan_ref__c
    }).isEmpty());
    System.assert(MT_MediaFlightService.getMediaFlightByParentIds(new Set<Id>()).isEmpty());
    System.assertEquals(Date.today().addMonths(-5), MT_MediaFlightService.getMediaFlightByParentIds(new Set<Id>{
      mf.MT_MediaBuildingBlockMonthlyPlan_ref__c
    }).get(0).MT_StartDate__c);

    Test.stopTest();
  }

  testmethod static void getMediaFlightsWithMotivesByParentIds() {

    MT_MediaFlight__c mf = [SELECT Id, MT_MediaBuildingBlockMonthlyPlan_ref__c FROM MT_MediaFlight__c limit 1];
    System.assertNotEquals(null, mf);

    Test.startTest();

    System.assert(!MT_MediaFlightService.getMediaFlightsWithMotivesByParentIds(new Set<Id>{
      mf.MT_MediaBuildingBlockMonthlyPlan_ref__c
    }).isEmpty());
    System.assert(MT_MediaFlightService.getMediaFlightsWithMotivesByParentIds(new Set<Id>()).isEmpty());
    System.assertEquals(Date.today().addMonths(-5), MT_MediaFlightService.getMediaFlightsWithMotivesByParentIds(new Set<Id>{
      mf.MT_MediaBuildingBlockMonthlyPlan_ref__c
    }).get(0).MT_StartDate__c);

    Test.stopTest();
  }
}