/**
 * Unit test for <code>MT_CampaignImportData</code> domain class.
 *
 * @author Fabio Andree Scheurel (MaibornWolff GmbH)
 */
@IsTest
private class MT_CampaignImportData_Test {
  @IsTest
  private static void testCreate() {
    Integer krsId = 42;
    Id opportunityId = Opportunity.SObjectType.getDescribe().getKeyPrefix() + '0'.repeat(15);

    Test.startTest();
    MT_CampaignImportData__c rec = MT_CampaignImportData.create(krsId, opportunityId);
    Test.stopTest();

    System.assertNotEquals(null, rec, 'No record was created');
    System.assertEquals(krsId, rec.MT_CampaignId__c, 'KRS ID is not set on new record');
    System.assertEquals(opportunityId, rec.MT_OpportunitySalesforceId__c, 'Salesforce Opportunity ID is not set on new record');
  }
}