/************************************************************************************************************
Name:  		MT_MediaFlightService
======================================================
Purpose: 	Service class for MT_MediaFlight object
======================================================
History
-------
Date		AUTHOR						DETAIL
24.11.2016	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
global with sharing class MT_MediaFlightService {

  global static List<MT_MediaFlight__c> getRecordsByIds(Set<ID> recordIds) {
    return new MT_MediaFlightSelector().getRecordsByIds(recordIds, MT_FieldSet.getFields(SObjectType.MT_MediaFlight__c.FieldSets.MT_ContextFields));
  }

  global static List<MT_MediaFlight__c> getMediaFlightByParentIds(Set<ID> monthlyPlandIds) {
    return new MT_MediaFlightSelector().getRecordsByParentIds(monthlyPlandIds, MT_FieldSet.getFields(SObjectType.MT_MediaFlight__c.FieldSets.MT_ContextFields));
  }

  global static List<MT_MediaFlight__c> getMediaFlightsWithMotivesByParentIds(Set<ID> monthlyPlanIds) {
    if (monthlyPlanIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaFlightSelector().getRecordsWithMotiveAllocationsByParentIds(
      monthlyPlanIds,
      MT_FieldSet.getFields(SObjectType.MT_MediaFlight__c.FieldSets.MT_ContextFields),
      MT_FieldSet.getFields(SObjectType.MT_MediaFlightMotiveAllocation__c.FieldSets.MT_SubContextFields)
    );
  }
}