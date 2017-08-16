/************************************************************************************************************
Name:  		MT_FlightPlanningController_Test
======================================================
Purpose: 	Test class for MT_FlightPlanningController
======================================================
History
-------
Date		AUTHOR						DETAIL
11.04.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/
@isTest
private class MT_FlightPlanningController_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  testmethod static void getCampaignKPIs() {
    Test.startTest();

    MT_MediaCampaign__c mc = [Select Id FROM MT_MediaCampaign__c limit 1];
    System.assertNotEquals(null, mc);

    MT_FlightPlanningController.MT_CampaignKPIDTO ckpidto = MT_FlightPlanningController.getCampaignKPIs(new List<Id>{
      mc.Id
    });

    List<Map<String, Object>> psoListMap = ((List<Map<String, Object>>) ckpidto.campaignKPIs.get(mc.Id).get('MT_ProSaOrder__r'));
    Map<String, Object> psoMap = psoListMap.get(0);

    System.assertNotEquals(null, psoListMap);
    System.assertEquals('123334', psoMap.get('MT_OrderNumber__c'));

    Test.stopTest();

  }

  testmethod static void getMediaBuildingBlock() {
  		/*Test.startTest();

  		MT_MediaCampaign__c mc = [Select Id FROM MT_MediaCampaign__c limit 1];
  		System.assertNotEquals(null, mc);

  		MT_FlightPlanningController.MT_CampaignKPIDTO ckpidto = MT_FlightPlanningController.getCampaignKPIs(new List<Id>{mc.Id});

  		List<Map<String, Object>> psoListMap = ((List<Map<String, Object>>)ckpidto.campaignKPIs.get(mc.Id).get('MT_ProSaOrder__r'));
  		Map<String, Object> psoMap = psoListMap.get(0);

		System.assertNotEquals(null, psoListMap);
		System.assertEquals('123334', psoMap.get('MT_OrderNumber__c'));

  		Test.stopTest();*/

  }
}