/************************************************************************************************************
Name:  		MT_MediaMotiveSelector
======================================================
Purpose: 	Selector class for MT_MediaMotive__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
17.02.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaMotiveSelector extends MT_Selector {
  public static final String objectAPIName = MT_MediaMotive__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where Id in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }

  public List<SObject> getRecordsByAdvertisedMediaProductIds(Set<Id> advertisedMediaProductIds, Set<String> fields) {
    if (advertisedMediaProductIds.isEmpty())
      return new List<SObject>();

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_AdvertisedMediaProduct_ref__c in ' + constructInClauseString(advertisedMediaProductIds);
    system.debug(query);
    return Database.query(query);
  }

  public List<SObject> getRecordsAgencyProductNumbers(Set<String> agenyProductNumbers, Set<String> fields) {
    if (agenyProductNumbers.isEmpty())
      return new List<SObject>();

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_AgencyProductNumber__c in ' + constructInClauseString(agenyProductNumbers);
    system.debug(query);
    return Database.query(query);
  }
}