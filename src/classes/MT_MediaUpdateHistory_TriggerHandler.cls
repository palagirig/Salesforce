/************************************************************************************************************
Name:  		MT_MediaUpdateHistory_TriggerHandler
======================================================
Purpose:
======================================================
History
-------
Date		AUTHOR						DETAIL
02.12.2016	Duc Nguyen Tien				Initial architecture & development
*************************************************************************************************************/
public class MT_MediaUpdateHistory_TriggerHandler extends TriggerController {
  public MT_MediaUpdateHistory_TriggerHandler(Boolean isAfter, Boolean isBefore, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate,
    List<sObject> lstNewItems, Map<Id, sObject> mapNewItems, List<sObject> lstOldItems, Map<Id, sObject> mapOldItems) {
    super(isAfter, isBefore, isDelete, isInsert, isUndelete, isUpdate, lstNewItems, mapNewItems, lstOldItems, mapOldItems);
  }
  public override void runBeforeInsert() {
    new MT_MediaUpdateHistories(lstNewItems).copyValuesFromReferenceObjects();
  }
  public override void runAfterInsert() {

  }
  public override void runAfterUpdate() {
    new MT_MediaUpdateHistories(lstNewItems, (Map<Id, MT_MediaUpdateHistory__c>) mapOldItems).ApprovalProcess_Approved().ApprovalProcess_Rejected();
  }
}