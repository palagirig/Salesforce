@isTest
private class MT_ConfigController_Test {
  @isTest static void allTest() {
    Test.startTest();
    ApexPages.StandardController std = new ApexPages.StandardController(new Account());
    MT_ConfigController ctlr = new MT_ConfigController(std);

    MT_Labels l = MT_ConfigController.getLabels();

    MT_Constants c = MT_ConfigController.getConstants();

    MT_Config conf = MT_ConfigController.getConfig();

    system.assertEquals(Date.today(), MT_ConfigController.getDate());

    Set<String> values = MT_ConfigController.getPicklistValues('Opportunity', 'StageName');

    Test.stopTest();
  }
}