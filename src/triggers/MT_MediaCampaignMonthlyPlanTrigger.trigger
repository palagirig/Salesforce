trigger MT_MediaCampaignMonthlyPlanTrigger on MT_MediaCampaignMonthlyPlan__c (before insert, after insert, before update, after update, before delete, after delete) {

new MT_BuildingBlockMonthPlan_TriggerHandler(Trigger.isAfter, Trigger.isBefore, Trigger.isDelete, Trigger.isInsert, Trigger.isUndelete, Trigger.isUpdate, Trigger.new, Trigger.newMap, Trigger.old,Trigger.oldMap).run();

}