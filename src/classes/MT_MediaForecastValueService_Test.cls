/************************************************************************************************************
Name:  		MT_MediaForecastValueService_Test
======================================================
Purpose: 	Test class for MT_MediaForecastValues, MT_MediaForecastValueService and MT_MediaForecastValueSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
18.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_MediaForecastValueService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_MediaForecastValues mfv = new MT_MediaForecastValues(new List<MT_ForecastValue__c>());
    Test.stopTest();
  }

  testmethod static void getMediaForecastValuesByIds() {
    MT_ForecastValue__c fv = [SELECT Id, MT_April__c FROM MT_ForecastValue__c limit 1];
    System.assertNotEquals(null, fv);

    Test.startTest();

    System.assert(!MT_MediaForecastValueService.getMediaForecastValuesByIds(new Set<Id>{
      fv.Id
    }).isEmpty());
    System.assert(MT_MediaForecastValueService.getMediaForecastValuesByIds(new Set<Id>()).isEmpty());
    System.assertEquals(1000, MT_MediaForecastValueService.getMediaForecastValuesByIds(new Set<Id>{
      fv.Id
    }).get(0).MT_April__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastValuesByIdsWithFields() {
    MT_ForecastValue__c fv = [SELECT Id, MT_April__c FROM MT_ForecastValue__c limit 1];
    System.assertNotEquals(null, fv);

    Test.startTest();

    System.assert(!MT_MediaForecastValueService.getMediaForecastValuesByIds(new Set<Id>{
      fv.Id
    }, new Set<String>{
      'Id'
    }).isEmpty());
    System.assert(MT_MediaForecastValueService.getMediaForecastValuesByIds(new Set<Id>(), new Set<String>{
      'Id'
    }).isEmpty());
    System.assertEquals(1000, MT_MediaForecastValueService.getMediaForecastValuesByIds(new Set<Id>{
      fv.Id
    }, new Set<String>{
      'MT_April__c'
    }).get(0).MT_April__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastValuesByMediaCampaignTypeIds() {
    MT_ForecastValue__c fv = [SELECT Id, MT_April__c FROM MT_ForecastValue__c limit 1];
    System.assertNotEquals(null, fv);

    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaForecastValueService.getMediaForecastValuesByMediaCampaignTypeIds(new Set<Id>{
      mct.Id
    }).isEmpty());
    System.assert(MT_MediaForecastValueService.getMediaForecastValuesByMediaCampaignTypeIds(new Set<Id>()).isEmpty());
    System.assertEquals(1000, MT_MediaForecastValueService.getMediaForecastValuesByMediaCampaignTypeIds(new Set<Id>{
      mct.Id
    }).get(0).MT_April__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastValuesByMediaCampaignTypeIdsWithFields() {
    MT_ForecastValue__c fv = [SELECT Id, MT_April__c FROM MT_ForecastValue__c limit 1];
    System.assertNotEquals(null, fv);

    MT_MediaCampaignType__c mct = [SELECT Id FROM MT_MediaCampaignType__c limit 1];
    System.assertNotEquals(null, mct);

    Test.startTest();

    System.assert(!MT_MediaForecastValueService.getMediaForecastValuesByMediaCampaignTypeIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'Id'
    }).isEmpty());
    System.assert(MT_MediaForecastValueService.getMediaForecastValuesByMediaCampaignTypeIds(new Set<Id>(), new Set<String>{
      'Id'
    }).isEmpty());
    System.assertEquals(1000, MT_MediaForecastValueService.getMediaForecastValuesByMediaCampaignTypeIds(new Set<Id>{
      mct.Id
    }, new Set<String>{
      'MT_April__c'
    }).get(0).MT_April__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastValuesByForecastVersionIds() {
    MT_ForecastValue__c fv = [SELECT Id, MT_April__c FROM MT_ForecastValue__c limit 1];
    System.assertNotEquals(null, fv);

    MT_ForecastVersion__c fver = [SELECT Id FROM MT_ForecastVersion__c limit 1];
    System.assertNotEquals(null, fver);

    Test.startTest();

    System.assert(!MT_MediaForecastValueService.getMediaForecastValuesByForecastVersionIds(new Set<Id>{
      fver.Id
    }).isEmpty());
    System.assert(MT_MediaForecastValueService.getMediaForecastValuesByForecastVersionIds(new Set<Id>()).isEmpty());
    System.assertEquals(1000, MT_MediaForecastValueService.getMediaForecastValuesByForecastVersionIds(new Set<Id>{
      fver.Id
    }).get(0).MT_April__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastValuesByForecastVersionIdsWithFields() {
    MT_ForecastValue__c fv = [SELECT Id, MT_April__c FROM MT_ForecastValue__c limit 1];
    System.assertNotEquals(null, fv);

    MT_ForecastVersion__c fver = [SELECT Id FROM MT_ForecastVersion__c limit 1];
    System.assertNotEquals(null, fver);

    Test.startTest();

    System.assert(!MT_MediaForecastValueService.getMediaForecastValuesByForecastVersionIds(new Set<Id>{
      fver.Id
    }, new Set<String>{
      'Id'
    }).isEmpty());
    System.assert(MT_MediaForecastValueService.getMediaForecastValuesByForecastVersionIds(new Set<Id>(), new Set<String>{
      'Id'
    }).isEmpty());
    System.assertEquals(1000, MT_MediaForecastValueService.getMediaForecastValuesByForecastVersionIds(new Set<Id>{
      fver.Id
    }, new Set<String>{
      'MT_April__c'
    }).get(0).MT_April__c);

    Test.stopTest();
  }
}