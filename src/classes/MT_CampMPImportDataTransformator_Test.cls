/**
 * Unit test for the <code>MT_CampMPImportDataTransformator</code>
 * batch job.
 *
 * @author GP
 */
@isTest
private class MT_CampMPImportDataTransformator_Test {

  @IsTest
  private static void testStart() {
    MT_CampMPImportDataTransformator batch = new MT_CampMPImportDataTransformator();

    Test.startTest();
    Object result = batch.start(null);
    Test.stopTest();

    System.assertEquals(true, result instanceof Database.QueryLocator, 'Batch.start() should but does not return a QueryLocator instance');
    Database.QueryLocator ql = (Database.QueryLocator) result;
    String query = ql.getQuery();

    String queryLocatorSobjectTarget = MT_CampaignMonthlyPlanImportData__c.getSObjectType().getDescribe().getName();
    System.assertEquals(true, query.contains(queryLocatorSobjectTarget), 'Batch.start() does not return a query on ' + queryLocatorSobjectTarget);

    FieldSet batchFields = SObjectType.MT_CampaignMonthlyPlanImportData__c.FieldSets.MT_TransformationBatchFields;
    for (FieldSetMember field : batchFields.getFields()) {
      System.assertEquals(true, query.contains(field.getFieldPath()), 'Batch.start() does not return a query that includes the field "' + field.getFieldPath() + '".');
    }
  }

  @IsTest
  private static void testFinish() {
    MT_Test.MockProvider mock = new MT_SystemEmailFactory_Test.MT_SystemEmailFactoryMockProvider();
    MT_SystemEmailFactory.INSTANCE = (MT_SystemEmailFactory) Test.createStub(MT_SystemEmailFactory.class, mock);

    MT_CampMPImportDataTransformator batch = new MT_CampMPImportDataTransformator();

    batch.processedRecords = 7;
    batch.updatedRecords = 3;
    batch.failedRecords = 4;
    batch.loggedErrors = new List<String>{
      'test 1',
      'test 2',
      'test 3'
    };

    Test.startTest();
    batch.finish(null);
    Test.stopTest();

    mock.assertMethodWasCalled(MT_SystemEmailFactory.getInstance(), MT_SystemEmailFactory_Test.MT_SYSTEMEMAILFACTORY_CREATE_MAIL_METHOD, 1);
    MT_SystemEmail mail = (MT_SystemEmail) mock.getInvocations(MT_SystemEmailFactory.getInstance(), MT_SystemEmailFactory_Test.MT_SYSTEMEMAILFACTORY_CREATE_MAIL_METHOD).get(0).getReturnValue();
    mock.assertMethodWasCalled(mail, MT_SystemEmail_Test.MT_SYSTEMEMAIL_SENDEMAIL_METHOD, 1);

    mock.assertMethodWasCalled(new MT_Test.MethodCall(MT_SystemEmailFactory.getInstance(), MT_SystemEmailFactory_Test.MT_SYSTEMEMAILFACTORY_CREATE_MAIL_METHOD, MT_SystemEmail.class, new List<Type>{
      Id.class
    }, new List<String>(), new List<Object>{
      UserInfo.getUserId()
    }));
    mock.assertMethodWasCalled(new MT_Test.MethodCall(mail, MT_SystemEmail_Test.MT_SYSTEMEMAIL_SUBJECT_METHOD, MT_SystemEmail.class, new List<Type>{
      String.class
    }, new List<String>(), new List<Object>{
      System.Label.MT_MP_ImportDataTransformator_EMAIL_ResultSubject
    }));
    String errors = '';
    for (String err : batch.loggedErrors) {
      errors += '- ' + err + '\n';
    }
    String body = String.format(System.Label.MT_MP_ImportDataTransformator_EMAIL_ResultBody, new List<String>{
      String.valueOf(batch.processedRecords),
      String.valueOf(batch.updatedRecords),
      String.valueOf(batch.failedRecords),
      errors
    });
    mock.assertMethodWasCalled(new MT_Test.MethodCall(mail, MT_SystemEmail_Test.MT_SYSTEMEMAIL_PLAINTEXTBODY_METHOD, MT_SystemEmail.class, new List<Type>{
      String.class
    }, new List<String>(), new List<Object>{
      body
    }));
  }

  @IsTest
  private static void testExecuteRecordsPurged() {
    MT_CampMPImportDataTransformator batch = new MT_CampMPImportDataTransformator();

    List<MT_CampaignMonthlyPlanImportData__c> testData = MT_Test.initCampaignMonthlyPlanImportTestData();
    System.assert(testData.size() > 0, 'TEST DATA FAILURE: there is no test data available!');

    Test.startTest();
    batch.execute(null, testData);
    Test.stopTest();

    System.assertEquals(
      false,
      new MT_CampaignMPImportDataSelector().queryLocatorForAll(new Set<String>{
        MT_CampaignMonthlyPlanImportData__c.Id.getDescribe().getName()
      }).iterator().hasNext(),
      'There is at least one record left over after the transformation batch run.'
    );
  }

  @IsTest
  private static void testExecuteMonthlyPlansUpdated() {
    MT_CampMPImportDataTransformator batch = new MT_CampMPImportDataTransformator();

    List<MT_CampaignMonthlyPlanImportData__c> testData = MT_Test.initCampaignMonthlyPlanImportTestData();
    System.assert(testData.size() > 0, 'TEST DATA FAILURE: there is no test data available');

    // FIXME add some special test cases here

    Test.startTest();
    batch.execute(null, testData);
    Test.stopTest();

    Set<String> krsIds = new Set<String>();
    for (MT_CampaignMonthlyPlanImportData__c rec : testData) {
      krsIds.add(String.valueOf(Integer.valueOf(rec.MT_CampaignId__c)));
    }

    Set<String> fields = new Set<String>{
      MT_MediaCampaignMonthlyPlan__c.MT_MediaCampaign_ref__c.getDescribe().getRelationshipName() + '.' + MT_MediaCampaign__c.MT_KRSID__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_Year__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_Month__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_FixRevenue__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_VariableRevenue1_SoldAmount__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_VariableRevenue2_SoldAmount__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_VariableRevenue3_SoldAmount__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_VariableRevenue4_SoldAmount__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_BMVSpot__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_BMVSponsoring__c.getDescribe().getName(),
      MT_MediaCampaignMonthlyPlan__c.MT_Probability__c.getDescribe().getName()
    };

    List<MT_MediaCampaignMonthlyPlan__c> monthlyPlans = new MT_MediaBuildingBlockMonthlyPlanSelector().getRecordsByKrsIds(krsIds, fields);
    Map<String, MT_MediaCampaignMonthlyPlan__c> monthlyPlanMap = new Map<String, MT_MediaCampaignMonthlyPlan__c>();
    for (MT_MediaCampaignMonthlyPlan__c monthlyPlan : monthlyPlans) {
      String key = monthlyPlan.MT_MediaCampaign_ref__r.MT_KRSID__c + '_' + String.valueOf(Integer.valueOf(monthlyPlan.MT_Year__c)) + '_' + String.valueOf(Integer.valueOf(monthlyPlan.MT_Month__c));
      monthlyPlanMap.put(key, monthlyPlan);
    }

    for (MT_CampaignMonthlyPlanImportData__c importRec : testData) {
      String key = String.valueOf(Integer.valueOf(importRec.MT_CampaignId__c)) + '_' + String.valueOf(Integer.valueOf(importRec.MT_Year__c)) + '_' + String.valueOf(Integer.valueOf(importRec.MT_Month__c));
      System.assertEquals(true, monthlyPlanMap.containsKey(key), 'For import record with key "' + key + '" there is no matching monthly plan in the system.');
      MT_MediaCampaignMonthlyPlan__c monthlyPlan = monthlyPlanMap.get(key);
      System.assertEquals(importRec.MT_RevenueFix__c, monthlyPlan.MT_FixRevenue__c, 'Fix revenue has not been updated!');
      System.assertEquals(importRec.MT_Amount1__c, monthlyPlan.MT_VariableRevenue1_SoldAmount__c, 'Sold Amount of Variable Revenue 1 has not been updated!');
      System.assertEquals(importRec.MT_Amount2__c, monthlyPlan.MT_VariableRevenue2_SoldAmount__c, 'Sold Amount of Variable Revenue 2 has not been updated!');
      System.assertEquals(importRec.MT_Amount3__c, monthlyPlan.MT_VariableRevenue3_SoldAmount__c, 'Sold Amount of Variable Revenue 3 has not been updated!');
      System.assertEquals(importRec.MT_Amount4__c, monthlyPlan.MT_VariableRevenue4_SoldAmount__c, 'Sold Amount of Variable Revenue 4 has not been updated!');
      System.assertEquals(importRec.MT_BMVSpotComplete__c, monthlyPlan.MT_BMVSpot__c, 'BMV Spot has not been updated!');
      System.assertEquals(importRec.MT_BMVSponsoringComplete__c, monthlyPlan.MT_BMVSponsoring__c, 'BMV Sponsoring has not been updated!');
      System.assertEquals(importRec.MT_DealProbabilitySpots__c, monthlyPlan.MT_Probability__c, 'Probability has not been updated!');
    }

    System.assertEquals(testData.size(), batch.processedRecords, 'Wrong number of import records have been processed.');
    System.assertEquals(testData.size(), batch.updatedRecords, 'Not all monthly plans were updated.');
    System.assertEquals(0, batch.failedRecords, 'No errors should occur, however there seem to be some.');
    System.assertEquals(new List<String>(), batch.loggedErrors, 'Some errors occurred.');
  }

  @IsTest
  private static void testExecuteMonthlyPlansNoMatch() {
    MT_CampMPImportDataTransformator batch = new MT_CampMPImportDataTransformator();

    List<MT_MediaCampaign__c> campaigns = new List<MT_MediaCampaign__c>{
      new MT_MediaCampaign__c(MT_KRSID__c = '123456', MT_RunTimeTVStart__c = Date.today().addMonths(-10), MT_RunTimeTVEnd__c = Date.today().addMonths(10)),
      new MT_MediaCampaign__c(MT_KRSID__c = '987654', MT_RunTimeTVStart__c = Date.today().addMonths(-10), MT_RunTimeTVEnd__c = Date.today().addMonths(10))
    };

    // we'll create import data for campaigns that do not exist in the database
    List<MT_CampaignMonthlyPlanImportData__c> importData = MT_Test.createCampaignMonthlyPlanImportData(campaigns);
    insert importData;

    Test.startTest();
    batch.execute(null, importData);
    Test.stopTest();

    System.assertEquals(importData.size(), batch.processedRecords, 'Wrong number of import records have been processed.');
    System.assertEquals(0, batch.updatedRecords, 'There have been updates although no records are there to be updated.');
    System.assertEquals(importData.size(), batch.failedRecords, 'Wrong number of failed records, all records should fail as there is no target record to update.');
  }
}