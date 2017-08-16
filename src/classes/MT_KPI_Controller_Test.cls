@isTest
private class MT_KPI_Controller_Test {

  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_MediaCampaign__c camp = [SELECT ID, MT_ActualMonthlyBMV_sum__c FROM MT_MediaCampaign__c limit 1];

    MT_KPI_Controller ctlr = new MT_KPI_Controller(new ApexPages.StandardController(camp));

    Test.stopTest();

    System.assertNotEquals(null, ctlr.context);
    System.assertEquals(camp, ((MT_KPI_Controller.MT_KPI_Global_ConsoleComp) ctlr.context).mCamp);
  }
}