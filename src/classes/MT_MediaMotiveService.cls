/************************************************************************************************************
Name:  		MT_MediaMotiveService
======================================================
Purpose: 	Service class for MT_MediaMotive__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
17.02.2017	Falco Aulitzky              Initial architecture & development
*************************************************************************************************************/
global with sharing class MT_MediaMotiveService {
  global static List<MT_MediaMotive__c> getMediaMotivesByIds(Set<ID> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    Set<String> combinedFields = MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_ContextFields);
    combinedFields.addAll(MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_SubContextFields));

    return new MT_MediaMotiveSelector().getRecordsByIds(
      recordIds,
      combinedFields
    );
  }

  global static List<MT_MediaMotive__c> getMediaMotivesByIds(Set<ID> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaMotiveSelector().getRecordsByIds(
      recordIds,
      fields
    );
  }

  global static List<MT_MediaMotive__c> getMediaMotivesByAdvertisedMediaProductIds(Set<ID> advertisedMediaProductIds) {
    if (advertisedMediaProductIds.isEmpty()) {
      return new List<SObject>();
    }

    Set<String> combinedFields = MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_ContextFields);
    combinedFields.addAll(MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_SubContextFields));

    return new MT_MediaMotiveSelector().getRecordsByAdvertisedMediaProductIds(
      advertisedMediaProductIds,
      combinedFields
    );
  }

  global static List<MT_MediaMotive__c> getMediaMotivesByAdvertisedMediaProductIds(Set<ID> advertisedMediaProductIds, Set<String> fields) {
    if (advertisedMediaProductIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaMotiveSelector().getRecordsByAdvertisedMediaProductIds(
      advertisedMediaProductIds,
      fields
    );
  }

  global static List<MT_MediaMotive__c> getMediaMotivesByAgencyProductNumbers(Set<String> agenyProductNumbers) {
    if (agenyProductNumbers.isEmpty()) {
      return new List<SObject>();
    }

    Set<String> combinedFields = MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_ContextFields);
    combinedFields.addAll(MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_SubContextFields));

    return new MT_MediaMotiveSelector().getRecordsAgencyProductNumbers(
      agenyProductNumbers,
      combinedFields
    );
  }

  global static List<MT_MediaMotive__c> getMediaMotivesByAgencyProductNumbers(Set<String> agenyProductNumbers, Set<String> fields) {
    if (agenyProductNumbers.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_MediaMotiveSelector().getRecordsAgencyProductNumbers(
      agenyProductNumbers,
      fields
    );
  }
}