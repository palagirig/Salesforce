/**
* =========================================================================================
* (c) factory42 GmbH 2015, Germany, All rights reserved
* P7S1_OpportunityApproval
* @author:      BS factory42
* @email:       bschneider@factory42.com
* @version:     V0.1
* @date:        Nov 25, 2015
* @last change: DEC 02, 2016 - Modified the trigger structure to be compliant with P7S1 standard framework
* @description: Set sales fields on Account depending on Account-TeamMemberRoles
* @objects:     Account, P7S1_OpportunityApproval__c
* ==========================================================================================
*/
trigger P7S1_OpportunityApproval on P7S1_OpportunityApproval__c (before insert, after insert, before update, after update, before delete, after delete) {
  new P7S1_OpportunityApproval_TriggerHandler(
    Trigger.isAfter, Trigger.isBefore, Trigger.isDelete, Trigger.isInsert, Trigger.isUnDelete, Trigger.isUpdate,
    Trigger.new, Trigger.newMap, Trigger.old, Trigger.oldMap
  ).run();
}