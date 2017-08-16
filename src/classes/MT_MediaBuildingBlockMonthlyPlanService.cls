/**
* Name:     MT_MediaBuildingBlockMonthlyPlanService
* Purpose:  Service class for MT_MediaBuildingBlockMonthlyPlan__c object
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 17.11.2016  Duc Nguyen Tien             Initial architecture and development
* 16.03.2017  Falco Aulitzky              Added missing functions
* 12.04.2017  Falco Aulitzky              Adding JavaDoc-Styled documentation
*
*/

/* Service class to fetch data */
global with sharing class MT_MediaBuildingBlockMonthlyPlanService {

  /*
  * Method to fetch data stored in salesforce
  *
  * @param    Set<Id> mbbmpIds is a set of MediaBuildingBlockMonthlyPlan ids
  * @returns  List<MT_MediaBuildingBlockMonthlyPlan__c> a list of MediaBuildingBlockMonthlyPlan objects
  *
  */
  global static List<MT_MediaCampaignMonthlyPlan__c> getRecordsByIds(Set<ID> mbbmpIds) {
    return new MT_MediaBuildingBlockMonthlyPlanSelector().getRecordsByIds(mbbmpIds, MT_FieldSet.getFields(SObjectType.MT_MediaCampaignMonthlyPlan__c.FieldSets.MT_ContextFields));
  }

  /*
  * Method to fetch data stored in salesforce
  *
  * @param    Set<Id> mbbIds is a set of MediaBuildingBlock ids
  * @returns  List<MT_MediaBuildingBlockMonthlyPlan__c> it is a list of MediaBuildingBlockMonthlyPlan objects
  *
  */
  global static List<MT_MediaCampaignMonthlyPlan__c> getMediaBuildingBlockMonthlyPlansByParentIds(Set<ID> mbbIds) {
    return new MT_MediaBuildingBlockMonthlyPlanSelector().getRecordsByParentIds(mbbIds, MT_FieldSet.getFields(SObjectType.MT_MediaCampaignMonthlyPlan__c.FieldSets.MT_ContextFields));
  }

  /*
  * Method to fetch data stored in salesforce
  *
  * @param    Set<Id> mbbIds is a set of MediaBuildingBlock ids
  * @returns  List<MT_MediaBuildingBlockMonthlyPlan__c> it is a list of MediaBuildingBlockMonthlyPlan objects with MediaFlight objects
  *
  */
  global static List<MT_MediaCampaignMonthlyPlan__c> getMediaBuildingBlockMonthlyPlansWithMediaFlightsByParentIds(Set<ID> mcIds) {
    return new MT_MediaBuildingBlockMonthlyPlanSelector().getRecordsWithMediaFlightsByParentIds(
      mcIds,
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignMonthlyPlan__c.FieldSets.MT_ContextFields),
      MT_FieldSet.getFields(SObjectType.MT_MediaFlight__c.FieldSets.MT_SubContextFields)
    );
  }
}