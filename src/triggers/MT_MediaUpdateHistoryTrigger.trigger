/************************************************************************************************************
Name:       MT_MediaUpdateHistoryTrigger
======================================================
Purpose:
======================================================
History
-------
Date        AUTHOR                      DETAIL
02.12.2016  Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
trigger MT_MediaUpdateHistoryTrigger on MT_MediaUpdateHistory__c (before insert, after insert, before update, after update, before delete, after delete) {
  new MT_MediaUpdateHistory_TriggerHandler(
    Trigger.isAfter, Trigger.isBefore, Trigger.isDelete, Trigger.isInsert, Trigger.isUnDelete, Trigger.isUpdate,
    Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap
  ).run();
}