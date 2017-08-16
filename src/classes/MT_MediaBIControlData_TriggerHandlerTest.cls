/**
 * Test class for the Broadcast Import Data trigger handler.
 */
@IsTest
private class MT_MediaBIControlData_TriggerHandlerTest {
  @IsTest
  private static void testBeforeInsert() {
    MT_MediaBroadcastImportControlData__c rec = new MT_MediaBroadcastImportControlData__c(
      MT_ImportDate__c = System.today(),
      MT_RecordCount__c = 1,
      MT_SumMB1__c = 1,
      MT_SumMB3__c = 1,
      MT_SumMN3__c = 1
    );

    Test.startTest();
    insert rec;
    Test.stopTest();

    MT_MediaBroadcastImportControlData__c rec2 = [SELECT Import_Date_Unique__c
                                                    FROM MT_MediaBroadcastImportControlData__c
                                                   WHERE Id = :rec.Id];
    System.assertEquals(String.valueOf(rec.MT_ImportDate__c), rec2.Import_Date_Unique__c, 'Import date has not been copied into technical field for uniqueness check.');
  }

  @IsTest
  private static void testAfterInsert() {
    Integer noOfJobsBefore = [SELECT Id
                                FROM AsyncApexJob
                               WHERE JobType = 'BatchApex'
                                 AND Status IN ('Holding', 'Queued')
                                 AND ApexClass.NamespacePrefix = null
                                 AND ApexClass.Name = :MT_BroadcastImportDataValidator.class.getName()].size();

    MT_MediaBroadcastImportControlData__c rec = new MT_MediaBroadcastImportControlData__c(
      MT_ImportDate__c = System.today(),
      MT_RecordCount__c = 1,
      MT_SumMB1__c = 1,
      MT_SumMB3__c = 1,
      MT_SumMN3__c = 1
    );

    // startTest
    insert rec;
    // stopTest

    Integer noOfJobsAfter = [SELECT Id
                               FROM AsyncApexJob
                              WHERE JobType = 'BatchApex'
                                AND Status IN ('Holding', 'Queued')
                                AND ApexClass.NamespacePrefix = null
                                AND ApexClass.Name = :MT_BroadcastImportDataValidator.class.getName()].size();
    System.assertEquals(noOfJobsBefore + 1, noOfJobsAfter, 'Transformation batch has not been started.');
  }

}