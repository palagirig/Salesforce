/************************************************************************************************************
Name:  		MT_MediaCampaignTypeService
======================================================
Purpose: 	Service class for MT_MediaCampaignType__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
08.03.2017	Falco Aulitzky              Initial architecture & development
*************************************************************************************************************/
global with sharing class MT_MediaCampaignTypeService {

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypes() {
    return MT_MediaCampaignTypeService.getMediaCampaignTypes(
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignType__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypes(Set<String> fields) {
    return new MT_MediaCampaignTypeSelector().getRecords(
      fields
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignType__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsByIds(
      recordIds,
      fields
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesByisActive(Boolean isActive) {
    if (isActive == null) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsByIsActive(
      isActive,
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignType__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesByisActive(Boolean isActive, Set<String> fields) {
    if (isActive == null) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsByIsActive(
      isActive,
      fields
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesByAssetIds(Set<Id> assetIds) {
    if (assetIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsByAssetIds(
      assetIds,
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignType__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesByAssetIds(Set<Id> assetIds, Set<String> fields) {
    if (assetIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsByAssetIds(
      assetIds,
      fields
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesWithMediaForecastValuesByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsWithMediaForecastValuesByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignType__c.FieldSets.MT_ContextFields),
      MT_FieldSet.getFields(SObjectType.MT_ForecastValue__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesWithMediaForecastValuesByIds(Set<Id> recordIds, Set<String> mediaCampaignTypefields, Set<String> forecastValuefields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsWithMediaForecastValuesByIds(
      recordIds,
      mediaCampaignTypefields,
      forecastValuefields
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsWithMediaTransparencyCampaignsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignType__c.FieldSets.MT_ContextFields),
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaign__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesWithMediaTransparencyCampaignsByIds(Set<Id> recordIds, Set<String> mediaCampaignTypefields, Set<String> mediaTransparencyCampaignFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsWithMediaTransparencyCampaignsByIds(
      recordIds,
      mediaCampaignTypefields,
      mediaTransparencyCampaignFields
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsWithForecastValueAndMediaTransCampaignsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignType__c.FieldSets.MT_ContextFields),
      MT_FieldSet.getFields(SObjectType.MT_ForecastValue__c.FieldSets.MT_ContextFields),
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaign__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_MediaCampaignType__c> getMediaCampaignTypesWithForecastValueAndMediaTransCampaignsByIds(Set<Id> recordIds, Set<String> mediaCampaignTypefields, Set<String> forecastValuefields, Set<String> mediaTransparencyCampaignFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaCampaignTypeSelector().getRecordsWithForecastValueAndMediaTransCampaignsByIds(
      recordIds,
      mediaCampaignTypefields,
      forecastValuefields,
      mediaTransparencyCampaignFields
    );
  }
}