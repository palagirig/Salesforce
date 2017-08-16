/************************************************************************************************************
Name:  		MT_MediaForecastValueSelector
======================================================
Purpose: 	Selector class for MT_ForecastValue__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
09.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaForecastValueSelector extends MT_Selector {
  public static final String objectAPIName = MT_ForecastValue__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Media Forecast Value query by Ids: ' + query);
    return Database.query(query);
  }

  public List<SObject> getRecordsByMediaCampaignTypeIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE MT_MediaCampaignType__c in ' + constructInClauseString(recordIds);
    System.debug('Media Forecast Value query by Media Campaign Type Ids: ' + query);
    return Database.query(query);
  }

  public List<SObject> getRecordsByMediaForecastVersionIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE MT_MediaForecastVersion_ref__c in ' + constructInClauseString(recordIds);
    System.debug('Media Forecast Value query by Media Forecast Version Ids: ' + query);
    return Database.query(query);
  }
}