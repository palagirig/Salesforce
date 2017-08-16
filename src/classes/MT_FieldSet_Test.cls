@isTest
private class MT_FieldSet_Test {
  @isTest static void getFields_1() {
    Test.startTest();
    Set<String> s = MT_FieldSet.getFields(SObjectType.MT_MediaCampaignMonthlyPlan__c.FieldSets.MT_ContextFields);

    Test.stopTest();
  }
  @isTest static void getFields_2() {
    Test.startTest();
    Set<String> s = MT_FieldSet.getFields(SObjectType.MT_MediaCampaignMonthlyPlan__c.FieldSets.MT_ContextFields.getFields());

    Test.stopTest();
  }
}