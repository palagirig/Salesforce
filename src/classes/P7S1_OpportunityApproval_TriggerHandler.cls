/************************************************************************************************************
Name:  		P7S1_OpportunityApproval_TriggerHandler
======================================================
Purpose:
======================================================
History
-------
Date		AUTHOR						DETAIL
02.12.2016	Duc Nguyen Tien				Initial architecture & development
*************************************************************************************************************/
public class P7S1_OpportunityApproval_TriggerHandler extends TriggerController {
  public P7S1_OpportunityApproval_TriggerHandler(Boolean isAfter, Boolean isBefore, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate,
    List<sObject> lstNewItems, Map<Id, sObject> mapNewItems, List<sObject> lstOldItems, Map<Id, sObject> mapOldItems) {
    super(isAfter, isBefore, isDelete, isInsert, isUndelete, isUpdate, lstNewItems, mapNewItems, lstOldItems, mapOldItems);
  }
  public override void runBeforeUpdate() {
    new MT_OpportunityApprovals(lstNewItems, (Map<Id, P7S1_OpportunityApproval__c>) mapOldItems)
      .FieldSync_LockValidation();
  }
  public override void runAfterUpdate() {
    P7S1_Account_SetSalesFields.getAccIdsFromOpportunityApproval(lstNewItems);
    new MT_OpportunityApprovals(lstNewItems, (Map<Id, P7S1_OpportunityApproval__c>) mapOldItems)
      .FieldSync_SyncFields()
      .ApprovalProcess_CreateMediaUpdateHistory()
      .ApprovalProcess_UpdateMediaUpdateHistory();
  }
}