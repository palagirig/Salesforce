/**
 * Unit test for <code>MT_CampaignImportDataSelector</code> class.
 *
 * @author Fabio Andree Scheurel (MaibornWolff GmbH)
 */
@IsTest
private class MT_CampaignImportDataSelector_Test {
  @IsTest
  private static void testQueryLocatorForAll() {
    Set<String> fields = new Set<String> {
      MT_CampaignImportData__c.Id.getDescribe().getName(),
      MT_CampaignImportData__c.Name.getDescribe().getName(),
      MT_CampaignImportData__c.MT_CampaignId__c.getDescribe().getName(),
      MT_CampaignImportData__c.MT_OpportunitySalesforceId__c.getDescribe().getName()
    };

    MT_CampaignImportDataSelector sel = new MT_CampaignImportDataSelector();

    Test.startTest();
    Database.QueryLocator ql = sel.queryLocatorForAll(fields);
    Test.stopTest();

    System.assertNotEquals(null, ql, 'No query locator was returned');
    String query = ql.getQuery();

    System.assertEquals(true, query.contains(' FROM ' + MT_CampaignImportDataSelector.OBJECT_API_NAME), 'Query does not target the sObject ' + MT_CampaignImportDataSelector.OBJECT_API_NAME);

    for (String field : fields) {
      System.assertEquals(true, query.contains(field), 'Query does not select field ' + field);
    }
  }
}