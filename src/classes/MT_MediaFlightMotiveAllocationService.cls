/************************************************************************************************************
Name:  		MT_MediaFlightMotiveAllocationService
======================================================
Purpose: 	Service class for MT_MediaFlightMotiveAllocation__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
06.02.2017	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
global with sharing class MT_MediaFlightMotiveAllocationService {
  global static List<MT_MediaFlightMotiveAllocation__c> getMediaFlightMotiveAllocationsByParentIds(Set<ID> mfIds) {
    return new MT_MediaFlightMotiveAllocationSelector().getRecordsByMediaFlightsIds(mfIds, MT_FieldSet.getFields(SObjectType.MT_MediaFlightMotiveAllocation__c.FieldSets.MT_ContextFields));
  }
  global static List<MT_MediaFlightMotiveAllocation__c> getMediaFlightMotiveAllocationsByIds(Set<ID> mfmaIds) {
    return new MT_MediaFlightMotiveAllocationSelector().getRecordsByIds(mfmaIds, MT_FieldSet.getFields(SObjectType.MT_MediaFlightMotiveAllocation__c.FieldSets.MT_ContextFields));
  }
}