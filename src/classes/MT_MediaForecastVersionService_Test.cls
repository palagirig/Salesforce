/************************************************************************************************************
Name:  		MT_MediaForecastVersionService_Test
======================================================
Purpose: 	Test class for MT_MediaForecastVersions, MT_MediaForecastVersionService and MT_MediaForecastVersionSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
18.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_MediaForecastVersionService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_MediaForecastVersions mfv = new MT_MediaForecastVersions(new List<MT_ForecastVersion__c>());
    Test.stopTest();
  }

  testmethod static void getMediaForecastVersions() {

    Test.startTest();
    MT_ForecastVersion__c fver = MT_MediaForecastVersions.create('Test Version');
    insert fver;
    System.assert(!MT_MediaForecastVersionService.getMediaForecastVersions().isEmpty());
    System.assertEquals('Test Version', MT_MediaForecastVersionService.getMediaForecastVersions().get(0).MT_VersionName__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastVersionsWithFields() {

    Test.startTest();
    MT_ForecastVersion__c fv = MT_MediaForecastVersions.create('Test Version');
    insert fv;

    System.assert(!MT_MediaForecastVersionService.getMediaForecastVersions(new Set<String>{
      'Id'
    }).isEmpty());
    System.assertEquals('Test Version', MT_MediaForecastVersionService.getMediaForecastVersions(new Set<String>{
      'MT_VersionName__c'
    }).get(0).MT_VersionName__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastVersionsByIds() {

    Test.startTest();

    MT_ForecastVersion__c fv = MT_MediaForecastVersions.create('Test Version');
    insert fv;

    System.assert(!MT_MediaForecastVersionService.getMediaForecastVersionsByIds(new Set<Id>{
      fv.Id
    }).isEmpty());
    System.assert(MT_MediaForecastVersionService.getMediaForecastVersionsByIds(new Set<Id>()).isEmpty());
    System.assertEquals('Test Version', MT_MediaForecastVersionService.getMediaForecastVersionsByIds(new Set<Id>{
      fv.Id
    }).get(0).MT_VersionName__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastVersionsByIdsWithFields() {
    Test.startTest();

    MT_ForecastVersion__c fv = MT_MediaForecastVersions.create('Test Version');
    insert fv;

    System.assert(!MT_MediaForecastVersionService.getMediaForecastVersionsByIds(new Set<Id>{
      fv.Id
    }, new Set<String>{
      'Id'
    }).isEmpty());
    System.assert(MT_MediaForecastVersionService.getMediaForecastVersionsByIds(new Set<Id>(), new Set<String>{
      'Id'
    }).isEmpty());
    System.assertEquals('Test Version', MT_MediaForecastVersionService.getMediaForecastVersionsByIds(new Set<Id>{
      fv.Id
    }, new Set<String>{
      'MT_VersionName__c'
    }).get(0).MT_VersionName__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastVersionsForYear() {

    Test.startTest();

    MT_ForecastVersion__c fv = MT_MediaForecastVersions.create('Test Version');
    fv.MT_VersionDate__c = Date.newInstance(2017, 01, 01);
    insert fv;

    System.assert(!MT_MediaForecastVersionService.getMediaForecastVersionsForYear(2017).isEmpty());
    System.assert(MT_MediaForecastVersionService.getMediaForecastVersionsForYear(2000).isEmpty());
    System.assertEquals('Test Version', MT_MediaForecastVersionService.getMediaForecastVersionsForYear(2017).get(0).MT_VersionName__c);

    Test.stopTest();
  }

  testmethod static void getMediaForecastVersionsForYearWithFields() {
    Test.startTest();

    MT_ForecastVersion__c fv = MT_MediaForecastVersions.create('Test Version');
    fv.MT_VersionDate__c = Date.newInstance(2017, 01, 01);
    insert fv;

    System.assert(!MT_MediaForecastVersionService.getMediaForecastVersionsForYear(2017, new Set<String>{
      'Id'
    }).isEmpty());
    System.assert(MT_MediaForecastVersionService.getMediaForecastVersionsForYear(2000, new Set<String>{
      'Id'
    }).isEmpty());
    System.assertEquals('Test Version', MT_MediaForecastVersionService.getMediaForecastVersionsForYear(2017, new Set<String>{
      'MT_VersionName__c'
    }).get(0).MT_VersionName__c);

    Test.stopTest();
  }
}