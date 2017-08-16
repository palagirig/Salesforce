trigger MT_ForecastVersionTrigger on MT_ForecastVersion__c (before insert, after insert, before update, after update, before delete, after delete) {
  new MT_ForecastVersion_TriggerHandler(
    Trigger.isAfter, Trigger.isBefore, Trigger.isDelete, Trigger.isInsert, Trigger.isUnDelete, Trigger.isUpdate,
    Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap
  ).run();
}