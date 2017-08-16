/************************************************************************************************************
Name:  		MT_MediaCampaignTypeService_Test
======================================================
Purpose: 	Test class for MT_MediaCampaignTypes, MT_MediaCampaignTypeService and MT_MediaCampaignTypeSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
18.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
public with sharing class MT_MediaCampaignTypeService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_MediaCampaignTypes mfv = new MT_MediaCampaignTypes(new List<MT_MediaCampaignType__c>());
    MT_MediaCampaignTypes mfv2 = new MT_MediaCampaignTypes(new List<MT_MediaCampaignType__c>(), new Map<Id, MT_MediaCampaignType__c>());
    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesByIds() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>{
      mct.Id
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>()).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>{
      mct.Id
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>{
      mct.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesByIdsWithFields() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Name'
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>(), new Set<String>{
      'Name'
    }).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'MT_IsActive__c'
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Name'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesByisActive() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesByisActive(true).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesByisActive(null).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesByisActive(true).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesByisActive(true).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesByisActiveWithFields() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesByisActive(true, new Set<String>{
      'Name'
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesByisActive(null, new Set<String>{
      'Name'
    }).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesByisActive(true, new Set<String>{
      'MT_IsActive__c'
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesByisActive(true, new Set<String>{
      'Name'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesByAssetIds() {
    P7S1_Asset__c ass = [SELECT Id FROM P7S1_Asset__c limit 1];
    System.assertNotEquals(null, ass);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesByAssetIds(new Set<Id>{
      ass.Id
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesByAssetIds(new Set<Id>()).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesByAssetIds(new Set<Id>{
      ass.Id
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesByAssetIds(new Set<Id>{
      ass.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesByAssetIdsWithFields() {
    P7S1_Asset__c ass = [SELECT Id FROM P7S1_Asset__c limit 1];
    System.assertNotEquals(null, ass);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesByAssetIds(new Set<Id>{
      ass.Id
    }, new Set<String>{
      'Name'
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesByAssetIds(new Set<Id>(), new Set<String>{
      'Name'
    }).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesByAssetIds(new Set<Id>{
      ass.Id
    }, new Set<String>{
      'MT_IsActive__c'
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesByAssetIds(new Set<Id>{
      ass.Id
    }, new Set<String>{
      'Name'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesWithMediaForecastValuesByIds() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaForecastValuesByIds(new Set<Id>{
      mct.Id
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaForecastValuesByIds(new Set<Id>()).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaForecastValuesByIds(new Set<Id>{
      mct.Id
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaForecastValuesByIds(new Set<Id>{
      mct.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesWithMediaForecastValuesByIdsWithFields() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaForecastValuesByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_April__c'
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaForecastValuesByIds(new Set<Id>(), new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_April__c'
    }).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaForecastValuesByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'MT_IsActive__c'
    }, new Set<String>{
      'MT_April__c'
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaForecastValuesByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_April__c'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesWithMediaTransparencyCampaignsByIds() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(new Set<Id>{
      mct.Id
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(new Set<Id>()).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(new Set<Id>{
      mct.Id
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(new Set<Id>{
      mct.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesWithMediaTransparencyCampaignsByIdsWithFields() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_HasMediaTV__c'
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(new Set<Id>(), new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_HasMediaTV__c'
    }).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'MT_IsActive__c'
    }, new Set<String>{
      'MT_HasMediaTV__c'
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_HasMediaTV__c'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(new Set<Id>{
      mct.Id
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(new Set<Id>()).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(new Set<Id>{
      mct.Id
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(new Set<Id>{
      mct.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIdsWithFields() {
    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaCampaignTypeService.getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_April__c'
    }, new Set<String>{
      'MT_HasMediaTV__c'
    }).isEmpty());
    System.assert(MT_MediaCampaignTypeService.getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(new Set<Id>(), new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_April__c'
    }, new Set<String>{
      'MT_HasMediaTV__c'
    }).isEmpty());
    System.assertEquals(true, MT_MediaCampaignTypeService.getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'MT_IsActive__c'
    }, new Set<String>{
      'MT_April__c'
    }, new Set<String>{
      'MT_HasMediaTV__c'
    }).get(0).MT_IsActive__c);
    System.assertEquals('Test', MT_MediaCampaignTypeService.getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Name'
    }, new Set<String>{
      'MT_April__c'
    }, new Set<String>{
      'MT_HasMediaTV__c'
    }).get(0).Name);

    Test.stopTest();
  }

}