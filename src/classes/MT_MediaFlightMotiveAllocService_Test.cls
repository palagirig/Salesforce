/************************************************************************************************************
Name:  		MT_MediaFlightMotiveAllocService_Test
======================================================
Purpose: 	Test class for MT_MediaFlightMotiveAllocations, MT_MediaFlightMotiveAllocationService and MT_MediaFlightMotiveAllocationSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
16.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_MediaFlightMotiveAllocService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_MediaFlightMotiveAllocations amp = new MT_MediaFlightMotiveAllocations(new List<MT_MediaFlightMotiveAllocation__c>());
    Test.stopTest();
  }

  testmethod static void getMediaFlightMotiveAllocationsByParentIds() {
    MT_MediaFlight__c mf = [SELECT Id FROM MT_MediaFlight__c limit 1];
    System.assertNotEquals(null, mf);

    Test.startTest();

    System.assert(!MT_MediaFlightMotiveAllocationService.getMediaFlightMotiveAllocationsByParentIds(new Set<Id>{
      mf.Id
    }).isEmpty());
    System.assert(MT_MediaFlightMotiveAllocationService.getMediaFlightMotiveAllocationsByParentIds(new Set<Id>()).isEmpty());
    System.assertEquals(mf.Id, MT_MediaFlightMotiveAllocationService.getMediaFlightMotiveAllocationsByParentIds(new Set<Id>{
      mf.Id
    }).get(0).MT_MediaFlight_ref__c);

    Test.stopTest();
  }

  testmethod static void getMediaFlightMotiveAllocationsByIds() {
    MT_MediaFlight__c mf = [SELECT Id FROM MT_MediaFlight__c limit 1];
    System.assertNotEquals(null, mf);

    MT_MediaFlightMotiveAllocation__c mfma = [SELECT Id FROM MT_MediaFlightMotiveAllocation__c limit 1];
    System.assertNotEquals(null, mfma);

    Test.startTest();

    System.assert(!MT_MediaFlightMotiveAllocationService.getMediaFlightMotiveAllocationsByIds(new Set<Id>{
      mfma.Id
    }).isEmpty());
    System.assert(MT_MediaFlightMotiveAllocationService.getMediaFlightMotiveAllocationsByIds(new Set<Id>()).isEmpty());
    System.assertEquals(mf.Id, MT_MediaFlightMotiveAllocationService.getMediaFlightMotiveAllocationsByIds(new Set<Id>{
      mfma.Id
    }).get(0).MT_MediaFlight_ref__c);

    Test.stopTest();
  }
}