/**
 * Validates all entries in the MT_MediaBroadcastImportData__c against the
 * MT_MediaBroadcastImportControlData__c.
 */
public with sharing class MT_BroadcastImportDataValidator implements Database.Batchable<sObject>, Database.Stateful {

  private MT_MediaBroadcastImportControlData__c controlRecord;

  @TestVisible
  private Integer recordCount;

  @TestVisible
  private Decimal mb1Sum;

  @TestVisible
  private Decimal mb3Sum;

  @TestVisible
  private Decimal mn3Sum;


  @TestVisible
  private Boolean errorOccurred;

  @TestVisible
  private Exception caughtException;

  /**
   * Instantiates a new instance based on the provided control record.
   *
   * @param control Control Record
   */
  public MT_BroadcastImportDataValidator(MT_MediaBroadcastImportControlData__c control) {
    if (control == null) {
      throw new MT_BroadcastImportDataValidatorException('Provided control record is null');
    }
    this.controlRecord = control;

    this.recordCount = 0;
    this.mb1Sum = 0;
    this.mb3Sum = 0;
    this.mn3Sum = 0;

    this.errorOccurred = false;
  }


  /**
   * Query the affected records for validation
   *
   * @param Database.BatchableContext bc The execution context
   *
   * @return Database.QueryLocator
   */
  public Database.QueryLocator start(Database.BatchableContext bc) {
    return Database.getQueryLocator([SELECT MT_MB1__c, MT_MB3__c, MT_MN3__c FROM MT_MediaBroadcastImportData__c]);
  }


  /**
   * Execute the actual transformation on a chunk of the records.
   *
   * @param Database.BatchableContext bc The execution context
   * @param List<sObject> scope The records to transform
   */
  public void execute(Database.BatchableContext bc, List<MT_MediaBroadcastImportData__c> scope) {
    if (errorOccurred) {
      return;
    }
    try {
      for (MT_MediaBroadcastImportData__c record : scope) {
        recordCount++;
        mb1Sum += record.MT_MB1__c;
        mb3Sum += record.MT_MB3__c;
        mn3Sum += record.MT_MN3__c;
      }
    } catch (Exception e) {
      this.errorOccurred = true;
      this.caughtException = e;
      System.debug(System.LoggingLevel.ERROR, e);
      throw e;
    }
  }

  /**
   * Send out the status email for the run.
   *
   * @param Database.BatchableContext info
   */
  public void finish(Database.BatchableContext info) {
    if (errorOccurred) {
      sendErrorMail();
    } else if (this.recordCount != this.controlRecord.MT_RecordCount__c ||
        this.mb1Sum.setScale(MT_MediaBroadcastImportControlData__c.MT_SumMB1__c.getDescribe().getScale(), System.RoundingMode.HALF_UP) != this.controlRecord.MT_SumMB1__c ||
        this.mb3Sum.setScale(MT_MediaBroadcastImportControlData__c.MT_SumMB3__c.getDescribe().getScale(), System.RoundingMode.HALF_UP) != this.controlRecord.MT_SumMB3__c ||
        this.mn3Sum.setScale(MT_MediaBroadcastImportControlData__c.MT_SumMN3__c.getDescribe().getScale(), System.RoundingMode.HALF_UP) != this.controlRecord.MT_SumMN3__c) {
      sendValidationFailureMail();
    } else {
      Database.executeBatch(new MT_BroadcastImportDataTransformator());
    }
  }


  private void sendErrorMail() {
    String subject = System.Label.MT_BC_ImportDataControl_ERROR_ValidationFailedSubject;

    String body = String.format(System.Label.MT_BC_ImportDataControl_ERROR_ValidationExceptionBody, new List<String>{
      this.caughtException.getMessage(),
      this.caughtException.getStackTraceString()
    });

    sendMail(subject, body);
  }


  private void sendValidationFailureMail() {
    String subject = System.Label.MT_BC_ImportDataControl_ERROR_ValidationFailedSubject;

    String body = String.format(System.Label.MT_BC_ImportDataControl_ERROR_ValidationFailedBody, new List<String>{
      String.valueOf(this.controlRecord.MT_RecordCount__c), String.valueOf(this.recordCount),
      String.valueOf(this.controlRecord.MT_SumMB1__c), String.valueOf(this.mb1Sum),
      String.valueOf(this.controlRecord.MT_SumMB3__c), String.valueOf(this.mb3Sum),
      String.valueOf(this.controlRecord.MT_SumMN3__c), String.valueOf(this.mn3Sum)
    });

    sendMail(subject, body);
  }


  private void sendMail(String subject, String body) {
    MT_SystemEmailFactory.getInstance().createNewSystemEmailFor(UserInfo.getUserId()).
        saveAsActivity(false).
        subject(subject).
        plainTextBody(body).
        treatBodiesAsTemplate(false).
        sendEmail();
  }


  /**
   * Exception to indicate errors during processing.
   */
  public class MT_BroadcastImportDataValidatorException extends Exception {}
}