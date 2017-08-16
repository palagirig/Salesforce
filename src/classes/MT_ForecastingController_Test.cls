/************************************************************************************************************
Name:  		MT_ForecastingController_Test
======================================================
Purpose: 	Test class for MT_ForecastingController
======================================================
History
-------
Date		AUTHOR						DETAIL
11.04.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_ForecastingController_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  testmethod static void getForecastingVersionData() {
    Test.startTest();
    MT_ForecastingController.MT_ForecastingDTO fdto = MT_ForecastingController.loadForecastingData(new List<String>{
      '2017'
    });
    System.assertNotEquals(null, fdto);
    System.assertEquals('Test Version', fdto.versions.objectList.get(0).MT_VersionName__c);
    System.assertEquals(1000, fdto.values.objectList.get(0).MT_April__c);

    Test.stopTest();
  }

  testmethod static void upsertForecastingValues() {
    Test.startTest();
    MT_ForecastingController.MT_ForecastingDTO fdto = MT_ForecastingController.loadForecastingData(new List<String>{
      '2017'
    });
    System.assertNotEquals(null, fdto);

    MT_ForecastingController.MT_ValueDTO vdto = fdto.values;
    vdto.objectList.get(0).MT_April__c = 500;

    MT_ForecastingController.MT_ForecastingDTO fdto2 = MT_ForecastingController.upsertForecastValueData(vdto, '2017');
    System.assertNotEquals(null, fdto2);
    System.assertEquals('Test Version', fdto2.versions.objectList.get(0).MT_VersionName__c);
    System.assertEquals(500, fdto2.values.objectList.get(0).MT_April__c);

    Test.stopTest();
  }
}