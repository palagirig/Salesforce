/************************************************************************************************************
Name:  		MT_AssetService
======================================================
Purpose: 	Service class for P7S1_Asset__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
08.03.2017	Falco Aulitzky              Initial architecture & development
*************************************************************************************************************/
global with sharing class MT_AssetService {
  global static List<P7S1_Asset__c> getAssetsByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AssetSelector().getRecordsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.P7S1_Asset__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<P7S1_Asset__c> getAssetsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AssetSelector().getRecordsByIds(
      recordIds,
      fields
    );
  }

  global static List<P7S1_Asset__c> getAssetsByUnitIds(Set<Id> unitIds) {
    if (unitIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AssetSelector().getRecordsByUnitIds(
      unitIds,
      MT_FieldSet.getFields(SObjectType.P7S1_Asset__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<P7S1_Asset__c> getAssetsByUnitIds(Set<Id> unitIds, Set<String> fields) {
    if (unitIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AssetSelector().getRecordsByUnitIds(
      unitIds,
      fields
    );
  }

  global static List<P7S1_Asset__c> getAssetsWithMediaCampaignTypesByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AssetSelector().getRecordsWithMediaCampaignTypesByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.P7S1_Asset__c.FieldSets.MT_ContextFields),
      MT_FieldSet.getFields(SObjectType.MT_MediaCampaignType__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<P7S1_Asset__c> getAssetsWithMediaCampaignTypesByIds(Set<Id> recordIds, Set<String> assetFields, Set<String> mediaCampaignTypeFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AssetSelector().getRecordsWithMediaCampaignTypesByIds(
      recordIds,
      assetFields,
      mediaCampaignTypeFields
    );
  }
}