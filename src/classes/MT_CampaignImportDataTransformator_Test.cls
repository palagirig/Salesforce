/**
 * Unit test for the <code>MT_CampaignImportDataTransformator</code>
 * batch job.
 *
 * @author Fabio Andree Scheurel (MaibornWolff GmbH)
 */
@IsTest
private class MT_CampaignImportDataTransformator_Test {
  @IsTest
  private static void testStart() {
    MT_CampaignImportDataTransformator batch = new MT_CampaignImportDataTransformator();

    Test.startTest();
    Object result = batch.start(null);
    Test.stopTest();

    System.assertEquals(true, result instanceof Database.QueryLocator, 'Batch.start() should but does not return a QueryLocator instance');
    Database.QueryLocator ql = (Database.QueryLocator) result;
    String query = ql.getQuery();

    String queryLocatorSobjectTarget = MT_CampaignImportData__c.getSObjectType().getDescribe().getName();
    System.assertEquals(true, query.contains(queryLocatorSobjectTarget), 'Batch.start() does not return a query on ' + queryLocatorSobjectTarget);

    FieldSet batchFields = SObjectType.MT_CampaignImportData__c.FieldSets.MT_TransformationBatchFields;
    for (FieldSetMember field : batchFields.getFields()) {
      System.assertEquals(true, query.contains(field.getFieldPath()), 'Batch.start() does not return a query that includes the field "' + field.getFieldPath() + '".');
    }
  }


  @IsTest
  private static void testFinish() {
    MT_CampaignImportDataTransformator batch = new MT_CampaignImportDataTransformator();

    Test.startTest();
    batch.finish(null);
    Test.stopTest();

    // Just code coverage, finish() does noting yet
  }


  @IsTest
  private static void testExecuteRecordsPurged() {
    MT_CampaignImportDataTransformator batch = new MT_CampaignImportDataTransformator();

    List<MT_CampaignImportData__c> testData = MT_Test.initCampaignImportTestData();
    System.assert(testData.size() > 0, 'TEST DATA FAILURE: there is no test data available!');

    Test.startTest();
    batch.execute(null, testData);
    Test.stopTest();

    System.assertEquals(
      false,
      new MT_CampaignImportDataSelector().queryLocatorForAll(new Set<String> { MT_CampaignImportData__c.Id.getDescribe().getName() }).iterator().hasNext(),
      'There is at least one record left over after the transformation batch run.'
    );
  }


  @IsTest
  private static void testExecuteCampaignsInserted() {
    MT_CampaignImportDataTransformator batch = new MT_CampaignImportDataTransformator();

    List<MT_CampaignImportData__c> testData = MT_Test.initCampaignImportTestData();
    System.assert(testData.size() > 0, 'TEST DATA FAILURE: there is no test data available!');

    MT_CampaignImportData__c specialTestData = testData.get(0);
    specialTestData.MT_CampaignName__c = 'x'.repeat(30);
    // FIXME go to full length once MT-700 bug is fixed
    // (currently on campaign creation a TV Zielvorgabe is created as well, where the campaign name is
    // copied into the tv zielvorgabe name field with an additional prefix, which exceeds the 80 character
    // field length limit. The copy process has to be modified with MT-583, with automated
    // name shortening.)
    // specialTestData.MT_CampaignName__c = 'x'.repeat(MT_CampaignImportData__c.MT_CampaignName__c.getDescribe().getLength());

    Test.startTest();
    batch.execute(null, testData);
    Test.stopTest();

    validateCampaignTransformation(testData);
  }


  @IsTest
  private static void testExecuteCampaignsUpdated() {
    MT_CampaignImportDataTransformator batch = new MT_CampaignImportDataTransformator();

    List<MT_CampaignImportData__c> testData = MT_Test.initCampaignImportTestData();
    System.assert(testData.size() > 0, 'TEST DATA FAILURE: there is no test data available!');

    // transform once
    batch.execute(null, testData);

    List<P7S1_OpportunityApproval__c> oppApprovals = [SELECT P7S1_Opportunity__c
                                                        FROM P7S1_OpportunityApproval__c];
    List<MT_CampaignImportData__c> testData2 = MT_Test.createCampaignImportTestData(oppApprovals);
    for (Integer i = 0; i < testData2.size(); i++) {
      MT_CampaignImportData__c data = testData2.get(i);
      data.MT_CampaignName__c = 'Updated Test Campaign Name #' + i;
    }
    insert testData2;

    Test.startTest();
    batch.execute(null, testData2);
    Test.stopTest();

    validateCampaignTransformation(testData2);
  }


  private static void validateCampaignTransformation(List<MT_CampaignImportData__c> importData) {
    Set<Id> oppIds = new Set<Id>();
    Map<String,MT_CampaignImportData__c> krsIdToCampaignImportMap = new Map<String,MT_CampaignImportData__c>();
    for (MT_CampaignImportData__c data : importData) {
      krsIdToCampaignImportMap.put(String.valueOf(data.MT_CampaignId__c), data);
      oppIds.add(data.MT_OpportunitySalesforceId__c);
    }

    Set<String> fields = new Set<String> {
      MT_MediaCampaign__c.MT_KRSID__c.getDescribe().getName(),
      MT_MediaCampaign__c.MT_Opportunity_ref__c.getDescribe().getName(),
      MT_MediaCampaign__c.MT_OpportunityApproval_ref__c.getDescribe().getRelationshipName() + '.' + P7S1_OpportunityApproval__c.P7S1_Opportunity__c.getDescribe().getName(),
      MT_MediaCampaign__c.Name.getDescribe().getName()
    };

    List<MT_MediaCampaign__c> campaigns = new MT_MediaCampaignSelector().getRecordsByOpportunityIds(oppIds, fields);
    System.assertEquals(importData.size(), campaigns.size(), 'Wrong number of campaigns created');
    for (MT_MediaCampaign__c campaign : campaigns) {
      System.assertEquals(true, krsIdToCampaignImportMap.containsKey(campaign.MT_KRSID__c), 'Found campaign without reference to import data: ' + JSON.serialize(campaign));
      MT_CampaignImportData__c data = krsIdToCampaignImportMap.get(campaign.MT_KRSID__c);
      System.assertEquals(data.MT_OpportunitySalesforceId__c, campaign.MT_Opportunity_ref__c, 'Wrong opportunity referenced for KRS ID ' + campaign.MT_KRSID__c);
      System.assertEquals(data.MT_OpportunitySalesforceId__c, campaign.MT_OpportunityApproval_ref__r.P7S1_Opportunity__c, 'Wrong opportunity referenced via opportunity approval for KRS ID ' + campaign.MT_KRSID__c);
      System.assertEquals(data.MT_CampaignName__c.left(MT_MediaCampaign__c.Name.getDescribe().getLength()), campaign.Name, 'Wrong campaign name for KRS ID ' + campaign.MT_KRSID__c);
    }
  }
}