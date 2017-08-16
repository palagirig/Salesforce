/************************************************************************************************************
Name:  		MT_MediaForecastVersionSelector
======================================================
Purpose: 	Selector class for MT_ForecastVersion__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
09.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaForecastVersionSelector extends MT_Selector {
  public static final String objectAPIName = MT_ForecastVersion__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsOfYear(Integer wantedYear, Set<String> fields) {

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE MT_VersionDate__c <= ' + (wantedYear + 1) + '-01-01 AND MT_VersionDate__c >= ' + wantedYear + '-01-01 ORDER BY CreatedDate DESC NULLS FIRST';
    System.debug('Media Forecast Version: ' + query);
    return Database.query(query);
  }

  public List<SObject> getRecords(Set<String> fields) {
    Integer currentYear = System.Today().year();

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE MT_VersionDate__c <= ' + (currentYear + 1) + '-01-01 AND MT_VersionDate__c >= ' + currentYear + '-01-01 ORDER BY CreatedDate DESC NULLS FIRST';
    System.debug('Media Forecast Version: ' + query);
    return Database.query(query);
  }

  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    Integer currentYear = System.Today().year();

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds) + ' AND MT_VersionDate__c <= ' + (currentYear + 1) + '-01-01 AND MT_VersionDate__c >= ' + currentYear + '-01-01 ORDER BY CreatedDate DESC NULLS FIRST';
    System.debug('Media Forecast Version query by Ids: ' + query);
    return Database.query(query);
  }
}