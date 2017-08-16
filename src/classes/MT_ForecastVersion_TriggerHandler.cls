public with sharing class MT_ForecastVersion_TriggerHandler extends TriggerController {
  MT_ForecastVersion__c toBeLocked;

  public MT_ForecastVersion_TriggerHandler(Boolean isAfter, Boolean isBefore, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate,
    List<sObject> lstNewItems, Map<Id, sObject> mapNewItems, List<sObject> lstOldItems, Map<Id, sObject> mapOldItems) {
    super(isAfter, isBefore, isDelete, isInsert, isUndelete, isUpdate, lstNewItems, mapNewItems, lstOldItems, mapOldItems);
  }

  public override void runAfterInsert() {
    List<MT_ForecastVersion__c> fv = ((List<MT_ForecastVersion__c>) lstNewItems);

    if (!Test.isRunningTest()) {
      toBeLocked = [SELECT Id, MT_IsLocked__c, MT_Deadline__c FROM MT_ForecastVersion__c WHERE Id != :fv.get(0).Id ORDER BY CreatedDate DESC NULLS LAST LIMIT 1];
    }

    if (toBeLocked != null && !toBeLocked.MT_IsLocked__c) {
      toBeLocked.MT_IsLocked__c = true;
      DateTime dt = ((List<MT_ForecastVersion__c>) lstNewItems).get(0).CreatedDate;
      toBeLocked.MT_Deadline__c = Date.newInstance(dT.year(), dT.month(), dT.day());
      update toBeLocked;

      Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
      req1.setComments('Automatic lock of previous record');
      req1.setObjectId(toBeLocked.Id);
      req1.setNextApproverIds(new List<Id>{
        UserInfo.getUserId()
      });
      Approval.ProcessResult result = Approval.process(req1);

      Approval.ProcessWorkitemRequest req2 = new Approval.ProcessWorkitemRequest();
      req2.setComments('Approving request.');
      req2.setAction('Approve');
      req2.setNextApproverIds(new Id[]{
        UserInfo.getUserId()
      });

      req2.setWorkitemId((result.getNewWorkitemIds()).get(0));

      Approval.ProcessResult result2 = Approval.process(req2);

      System.debug('#### Submit ' + result);
      System.debug('#### Approval ' + result2);
    }

    new MT_MediaForecastVersions((List<MT_ForecastVersion__c>) lstNewItems);

    System.debug('#### new AfterInsert ' + lstNewItems);
  }
}