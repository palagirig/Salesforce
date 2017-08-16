/**
 * Unit test for <code>MT_CampaignMPImportDataSelector</code> class.
 *
 * @author GP
 */
@isTest
private class MT_CampaignMPImportDataSelector_Test {
@IsTest
  private static void testQueryLocatorForAll() {
    Set<String> fields = new Set<String> {
      MT_CampaignMonthlyPlanImportData__c.Id.getDescribe().getName(),
      MT_CampaignMonthlyPlanImportData__c.Name.getDescribe().getName(),
      MT_CampaignMonthlyPlanImportData__c.MT_CampaignId__c.getDescribe().getName(),
      MT_CampaignMonthlyPlanImportData__c.MT_Year__c.getDescribe().getName(),
      MT_CampaignMonthlyPlanImportData__c.MT_Month__c.getDescribe().getName()
    };

    MT_CampaignMPImportDataSelector sel = new MT_CampaignMPImportDataSelector();

    Test.startTest();
    Database.QueryLocator ql = sel.queryLocatorForAll(fields);
    Test.stopTest();

    System.assertNotEquals(null, ql, 'No query locator was returned');
    String query = ql.getQuery();

    System.assertEquals(true, query.contains(' FROM ' + MT_CampaignMPImportDataSelector.OBJECT_API_NAME), 'Query does not target the sObject ' + MT_CampaignMPImportDataSelector.OBJECT_API_NAME);

    for (String field : fields) {
      System.assertEquals(true, query.contains(field), 'Query does not select field ' + field);
    }
  }
	
}