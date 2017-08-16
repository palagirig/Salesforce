/************************************************************************************************************
Name:  		MT_AdvertisedMediaProductSelector
======================================================
Purpose: 	Selector class for MT_AdvertisedMediaProduct__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
06.02.2017	Duc Nguyen Tien             Initial architecture & development
16.02.2017	Falco Aulitzky				Updated architecture
*************************************************************************************************************/
public with sharing class MT_AdvertisedMediaProductSelector extends MT_Selector {
  public static final String objectAPIName = MT_AdvertisedMediaProduct__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where Id in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }

  public List<SObject> getRecordsByAccountIds(Set<Id> accountIds, Set<String> fields) {
    if (accountIds.isEmpty())
      return new List<SObject>();

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_Account_ref__c in ' + constructInClauseString(accountIds);
    system.debug(query);
    return Database.query(query);
  }

  public List<SObject> getRecordsByProductNumbers(Set<String> productNumbers, Set<String> fields) {
    if (productNumbers.isEmpty())
      return new List<SObject>();

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_ProductNumber__c in ' + constructInClauseString(productNumbers);
    system.debug(query);
    return Database.query(query);
  }

  public List<SObject> getRecordsWithMotivesByAccountIds(Set<Id> accountIds, Set<String> mediaProductFields, Set<String> motiveFields) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(mediaProductFields) + ', ( SELECT ' + constructFieldString(motiveFields) + ' FROM MT_MediaMotives__r) FROM ' + objectAPIName + ' where MT_Account_ref__c in ' + constructInClauseString(accountIds);
    system.debug(query);
    return Database.query(query);
  }

  public List<SObject> getRecordsWithFlightMotiveAllocationByAccountIds(Set<Id> accountIds, Set<String> mediaProductFields, Set<String> flightMotiveFields) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(mediaProductFields) + ', ( SELECT ' + constructFieldString(flightMotiveFields) + ' FROM Media_Flight_Motive_Allocations__r) FROM ' + objectAPIName + ' where MT_Account_ref__c in ' + constructInClauseString(accountIds);
    system.debug(query);
    return Database.query(query);
  }
}