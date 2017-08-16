/************************************************************************************************************
Name:  		MT_MediaBIControlData_TriggerHandler
======================================================
Purpose:
======================================================
History
-------
Date		AUTHOR						DETAIL
04.07.2017	Gokul-Prasad Palagiri		Initial Version MT-286
*************************************************************************************************************/
public class MT_MediaBIControlData_TriggerHandler extends TriggerController {
  public MT_MediaBIControlData_TriggerHandler(Boolean isAfter, Boolean isBefore, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate,
    List<sObject> lstNewItems, Map<Id, sObject> mapNewItems, List<sObject> lstOldItems, Map<Id, sObject> mapOldItems) {
    super(isAfter, isBefore, isDelete, isInsert, isUndelete, isUpdate, lstNewItems, mapNewItems, lstOldItems, mapOldItems);
  }
  
  public override void runBeforeInsert() {
    
    for(MT_MediaBroadcastImportControlData__c controlRec : (List<MT_MediaBroadcastImportControlData__c>)lstNewItems){
        controlRec.Import_Date_Unique__c = String.valueOf(controlRec.MT_ImportDate__c) ;
    }

  }

  public override void runAfterInsert() {
  	
  	for (MT_MediaBroadcastImportControlData__c controlRec : (List<MT_MediaBroadcastImportControlData__c>) lstNewItems){
		Database.executeBatch(new MT_BroadcastImportDataValidator(controlRec));
	  }

  }


}