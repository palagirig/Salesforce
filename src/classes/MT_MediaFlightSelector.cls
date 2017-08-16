/************************************************************************************************************
Name:  		MT_MediaFlightSelector
======================================================
Purpose: 	Selector class for MT_MediaFlight__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
24.11.2016	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaFlightSelector extends MT_Selector {

  public static final String objectAPIName = MT_MediaFlight__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where Id in ' + constructInClauseString(recordIds);
    return Database.query(query);
  }

  public List<SObject> getRecordsByParentIds(Set<Id> parentIds, Set<String> fields) {
    if (parentIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_MediaBuildingBlockMonthlyPlan_ref__c in ' + constructInClauseString(parentIds);
    return Database.query(query);
  }

  public List<SObject> getRecordsWithMotiveAllocationsByParentIds(Set<Id> parentIds, Set<String> flightFields, Set<String> motiveFields) {
    if (parentIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(flightFields) + ', ( SELECT ' + constructFieldString(motiveFields) + ' FROM MT_Media_Flight_Motive_Allocations__r order by MT_Position__c asc) FROM ' + objectAPIName + ' where MT_MediaBuildingBlockMonthlyPlan_ref__c in ' + constructInClauseString(parentIds) + ' order by MT_Position__c asc';
    system.debug(query);
    return Database.query(query);
  }
}