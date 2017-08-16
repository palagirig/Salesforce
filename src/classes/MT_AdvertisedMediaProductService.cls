/************************************************************************************************************
Name:  		MT_AdvertisedMediaProductService
======================================================
Purpose: 	Service class for MT_AdvertisedMediaProduct__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
06.02.2017	Duc Nguyen Tien             Initial architecture & development
16.02.2017  Falco Aulitzky              Updated architecture
*************************************************************************************************************/
global with sharing class MT_AdvertisedMediaProductService {
  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsByAccountIds(Set<ID> accountIds) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    return MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(
      accountIds,
      MT_FieldSet.getFields(SObjectType.MT_AdvertisedMediaProduct__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsByAccountIds(Set<ID> accountIds, Set<String> fields) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AdvertisedMediaProductSelector().getRecordsByAccountIds(
      accountIds,
      fields
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsByIds(Set<ID> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.MT_AdvertisedMediaProduct__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsByIds(Set<ID> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AdvertisedMediaProductSelector().getRecordsByIds(
      recordIds,
      fields
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsByProductNumbers(Set<String> productNumbers) {
    if (productNumbers.isEmpty()) {
      return new List<SObject>();
    }

    return MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(
      productNumbers,
      MT_FieldSet.getFields(SObjectType.MT_AdvertisedMediaProduct__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsByProductNumbers(Set<String> productNumbers, Set<String> fields) {
    if (productNumbers.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AdvertisedMediaProductSelector().getRecordsByProductNumbers(
      productNumbers,
      fields
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsWithMotivesByAccountIds(Set<Id> accountIds) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    Set<String> combinedFields = MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_ContextFields);
    combinedFields.addAll(MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_SubContextFields));

    return MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(
      accountIds,
      MT_FieldSet.getFields(SObjectType.MT_AdvertisedMediaProduct__c.FieldSets.MT_ContextFields),
      combinedFields
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsWithMotivesByAccountIds(Set<Id> accountIds, Set<String> mediaProductFields) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    Set<String> combinedFields = MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_ContextFields);
    combinedFields.addAll(MT_FieldSet.getFields(SObjectType.MT_MediaMotive__c.FieldSets.MT_SubContextFields));

    return MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(
      accountIds,
      mediaProductFields,
      combinedFields
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsWithMotivesByAccountIds(Set<Id> accountIds, Set<String> mediaProductFields, Set<String> motiveFields) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AdvertisedMediaProductSelector().getRecordsWithMotivesByAccountIds(
      accountIds,
      mediaProductFields,
      motiveFields
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(Set<Id> accountIds) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    Set<String> combinedFields = MT_FieldSet.getFields(SObjectType.MT_MediaFlightMotiveAllocation__c.FieldSets.MT_ContextFields);
    combinedFields.addAll(MT_FieldSet.getFields(SObjectType.MT_MediaFlightMotiveAllocation__c.FieldSets.MT_SubContextFields));

    return new MT_AdvertisedMediaProductSelector().getRecordsWithFlightMotiveAllocationByAccountIds(
      accountIds,
      MT_FieldSet.getFields(SObjectType.MT_AdvertisedMediaProduct__c.FieldSets.MT_ContextFields),
      combinedFields
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(Set<Id> accountIds, Set<String> mediaProductFields) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    Set<String> combinedFields = MT_FieldSet.getFields(SObjectType.MT_MediaFlightMotiveAllocation__c.FieldSets.MT_ContextFields);
    combinedFields.addAll(MT_FieldSet.getFields(SObjectType.MT_MediaFlightMotiveAllocation__c.FieldSets.MT_SubContextFields));

    return new MT_AdvertisedMediaProductSelector().getRecordsWithFlightMotiveAllocationByAccountIds(
      accountIds,
      mediaProductFields,
      combinedFields
    );
  }

  global static List<MT_AdvertisedMediaProduct__c> getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(Set<Id> accountIds, Set<String> mediaProductFields, Set<String> flightMotiveFields) {
    if (accountIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_AdvertisedMediaProductSelector().getRecordsWithFlightMotiveAllocationByAccountIds(
      accountIds,
      mediaProductFields,
      flightMotiveFields
    );
  }
}