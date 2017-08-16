/************************************************************************************************************
Name:  		MT_MediaMotiveService_Test
======================================================
Purpose: 	Test class for MT_MediaMotives, MT_MediaMotiveService and MT_MediaMotiveSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
15.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_MediaMotiveService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_MediaMotives amp = new MT_MediaMotives(new List<MT_MediaMotive__c>());
    Test.stopTest();
  }

  testmethod static void getMediaMotivesByIds() {
    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];
    System.assertNotEquals(null, amp);

    MT_MediaMotive__c mm = [SELECT Id FROM MT_MediaMotive__c limit 1];
    System.assertNotEquals(null, mm);

    Test.startTest();

    System.assert(!MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>{
      mm.Id
    }).isEmpty());
    System.assert(MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>()).isEmpty());
    System.assertEquals(amp.Id, MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>{
      mm.Id
    }).get(0).MT_AdvertisedMediaProduct_ref__c);
    System.assertEquals('Test Motive', MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>{
      mm.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaMotivesByIdsWithFields() {
    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];
    System.assertNotEquals(null, amp);

    MT_MediaMotive__c mm = [SELECT Id FROM MT_MediaMotive__c limit 1];
    System.assertNotEquals(null, mm);

    Test.startTest();

    System.assert(!MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>{
      mm.Id
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).isEmpty());
    System.assert(MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>(), new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).isEmpty());
    System.assertEquals(amp.Id, MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>{
      mm.Id
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).get(0).MT_AdvertisedMediaProduct_ref__c);
    System.assertEquals('Test Motive', MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>{
      mm.Id
    }, new Set<String>{
      'Name'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaMotivesByAdvertisedMediaProductIds() {
    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];
    System.assertNotEquals(null, amp);

    MT_MediaMotive__c mm = [SELECT Id FROM MT_MediaMotive__c limit 1];
    System.assertNotEquals(null, mm);

    Test.startTest();

    System.assert(!MT_MediaMotiveService.getMediaMotivesByAdvertisedMediaProductIds(new Set<Id>{
      amp.Id
    }).isEmpty());
    System.assert(MT_MediaMotiveService.getMediaMotivesByAdvertisedMediaProductIds(new Set<Id>()).isEmpty());
    System.assertEquals(amp.Id, MT_MediaMotiveService.getMediaMotivesByAdvertisedMediaProductIds(new Set<Id>{
      amp.Id
    }).get(0).MT_AdvertisedMediaProduct_ref__c);
    System.assertEquals('Test Motive', MT_MediaMotiveService.getMediaMotivesByAdvertisedMediaProductIds(new Set<Id>{
      amp.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaMotivesByAdvertisedMediaProductIdsWithFields() {
    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];
    System.assertNotEquals(null, amp);

    MT_MediaMotive__c mm = [SELECT Id FROM MT_MediaMotive__c limit 1];
    System.assertNotEquals(null, mm);

    Test.startTest();

    System.assert(!MT_MediaMotiveService.getMediaMotivesByAdvertisedMediaProductIds(new Set<Id>{
      amp.Id
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).isEmpty());
    System.assert(MT_MediaMotiveService.getMediaMotivesByAdvertisedMediaProductIds(new Set<Id>(), new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).isEmpty());
    System.assertEquals(amp.Id, MT_MediaMotiveService.getMediaMotivesByAdvertisedMediaProductIds(new Set<Id>{
      amp.Id
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).get(0).MT_AdvertisedMediaProduct_ref__c);
    System.assertEquals('Test Motive', MT_MediaMotiveService.getMediaMotivesByAdvertisedMediaProductIds(new Set<Id>{
      amp.Id
    }, new Set<String>{
      'Name'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaMotivesByAgencyProductNumbers() {
    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];
    System.assertNotEquals(null, amp);

    MT_MediaMotive__c mm = [SELECT Id FROM MT_MediaMotive__c limit 1];
    System.assertNotEquals(null, mm);

    Test.startTest();

    System.assert(!MT_MediaMotiveService.getMediaMotivesByAgencyProductNumbers(new Set<String>{
      '12345'
    }).isEmpty());
    System.assert(MT_MediaMotiveService.getMediaMotivesByAgencyProductNumbers(new Set<String>()).isEmpty());
    System.assertEquals(amp.Id, MT_MediaMotiveService.getMediaMotivesByAgencyProductNumbers(new Set<String>{
      '12345'
    }).get(0).MT_AdvertisedMediaProduct_ref__c);
    System.assertEquals('12345', MT_MediaMotiveService.getMediaMotivesByAgencyProductNumbers(new Set<String>{
      '12345'
    }).get(0).MT_AgencyProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getMediaMotivesByAgencyProductNumbersWithFields() {
    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];
    System.assertNotEquals(null, amp);

    MT_MediaMotive__c mm = [SELECT Id FROM MT_MediaMotive__c limit 1];
    System.assertNotEquals(null, mm);

    Test.startTest();

    System.assert(!MT_MediaMotiveService.getMediaMotivesByAgencyProductNumbers(new Set<String>{
      '12345'
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).isEmpty());
    System.assert(MT_MediaMotiveService.getMediaMotivesByAgencyProductNumbers(new Set<String>(), new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).isEmpty());
    System.assertEquals(amp.Id, MT_MediaMotiveService.getMediaMotivesByAgencyProductNumbers(new Set<String>{
      '12345'
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).get(0).MT_AdvertisedMediaProduct_ref__c);
    System.assertEquals('12345', MT_MediaMotiveService.getMediaMotivesByAgencyProductNumbers(new Set<String>{
      '12345'
    }, new Set<String>{
      'MT_AgencyProductNumber__c'
    }).get(0).MT_AgencyProductNumber__c);

    Test.stopTest();
  }

}