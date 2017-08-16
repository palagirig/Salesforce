/************************************************************************************************************
Name:  		MT_MediaForecastVersionService
======================================================
Purpose: 	Service class for MT_ForecastVersion__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
09.03.2017	Falco Aulitzky              Initial architecture & development
*************************************************************************************************************/
global with sharing class MT_MediaForecastVersionService {
  global static List<MT_ForecastVersion__c> getMediaForecastVersions() {
    return new MT_MediaForecastVersionSelector().getRecords(
      MT_FieldSet.getFields(SObjectType.MT_ForecastVersion__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_ForecastVersion__c> getMediaForecastVersions(Set<String> fields) {
    return new MT_MediaForecastVersionSelector().getRecords(
      fields
    );
  }

  global static List<MT_ForecastVersion__c> getMediaForecastVersionsForYear(Integer year) {
    return new MT_MediaForecastVersionSelector().getRecordsOfYear(
      year,
      MT_FieldSet.getFields(SObjectType.MT_ForecastVersion__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_ForecastVersion__c> getMediaForecastVersionsForYear(Integer year, Set<String> fields) {
    return new MT_MediaForecastVersionSelector().getRecordsOfYear(
      year,
      fields
    );
  }

  global static List<MT_ForecastVersion__c> getMediaForecastVersionsByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaForecastVersionSelector().getRecordsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_ForecastVersion__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_ForecastVersion__c> getMediaForecastVersionsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaForecastVersionSelector().getRecordsByIds(
      recordIds,
      fields
    );
  }
}