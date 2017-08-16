/************************************************************************************************************
Name:  		MT_MediaForecastValueService
======================================================
Purpose: 	Service class for MT_ForecastValue__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
09.03.2017	Falco Aulitzky              Initial architecture & development
*************************************************************************************************************/
global with sharing class MT_MediaForecastValueService {
  global static List<MT_ForecastValue__c> getMediaForecastValuesByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaForecastValueSelector().getRecordsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_ForecastValue__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_ForecastValue__c> getMediaForecastValuesByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaForecastValueSelector().getRecordsByIds(
      recordIds,
      fields
    );
  }

  global static List<MT_ForecastValue__c> getMediaForecastValuesByMediaCampaignTypeIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaForecastValueSelector().getRecordsByMediaCampaignTypeIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_ForecastValue__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_ForecastValue__c> getMediaForecastValuesByMediaCampaignTypeIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaForecastValueSelector().getRecordsByMediaCampaignTypeIds(
      recordIds,
      fields
    );
  }

  global static List<MT_ForecastValue__c> getMediaForecastValuesByForecastVersionIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaForecastValueSelector().getRecordsByMediaForecastVersionIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_ForecastValue__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_ForecastValue__c> getMediaForecastValuesByForecastVersionIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaForecastValueSelector().getRecordsByMediaForecastVersionIds(
      recordIds,
      fields
    );
  }
}