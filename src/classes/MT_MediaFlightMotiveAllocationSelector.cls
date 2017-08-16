/************************************************************************************************************
Name:  		MT_MediaFlightMotiveAllocationSelector
======================================================
Purpose: 	Selector class for MT_MediaFlightMotiveAllocation__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
06.02.2017	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaFlightMotiveAllocationSelector extends MT_Selector {
  public static final String objectAPIName = MT_MediaFlightMotiveAllocation__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where Id in ' + constructInClauseString(recordIds) + ' order by MT_Position__c desc';
    return Database.query(query);
  }
  public List<SObject> getRecordsByMediaFlightsIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_MediaFlight_ref__c in ' + constructInClauseString(recordIds) + ' order by MT_Position__c desc';
    return Database.query(query);
  }

}