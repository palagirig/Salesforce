/************************************************************************************************************
Name:  		MT_MediaBIControlDataTrigger
======================================================
Purpose: To trigger a data import batch job
======================================================
History
-------
Date		AUTHOR						DETAIL
04.07.2017	Gokul-Prasad Palagiri		Initial Version MT-286
*************************************************************************************************************/
trigger MT_MediaBIControlDataTrigger on MT_MediaBroadcastImportControlData__c (before insert, after insert, before update, after update, before delete, after delete) {
  new MT_MediaBIControlData_TriggerHandler(
    Trigger.isAfter, Trigger.isBefore, Trigger.isDelete, Trigger.isInsert, Trigger.isUnDelete, Trigger.isUpdate,
    Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap
  ).run();
}