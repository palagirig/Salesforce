/************************************************************************************************************
Name:  		MT_UnitService
======================================================
Purpose: 	Service class for P7S1_Unit__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
08.03.2017	Falco Aulitzky              Initial architecture & development
*************************************************************************************************************/

global with sharing class MT_UnitService {
  global static List<P7S1_Unit__c> getUnitsByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_UnitSelector().getRecordsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.P7S1_Unit__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<P7S1_Unit__c> getUnitsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_UnitSelector().getRecordsByIds(
      recordIds,
      fields
    );
  }

  global static List<P7S1_Unit__c> getUnitsWithAssetsByIds(Set<Id> recordIds) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_UnitSelector().getRecordsWithAssetsByIds(
      recordIds,
      MT_FieldSet.getFields(SObjectType.P7S1_Unit__c.FieldSets.MT_ContextFields),
      MT_FieldSet.getFields(SObjectType.P7S1_Asset__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<P7S1_Unit__c> getUnitsWithAssetsByIds(Set<Id> recordIds, Set<String> unitFields, Set<String> assetFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_UnitSelector().getRecordsWithAssetsByIds(
      recordIds,
      unitFields,
      assetFields
    );
  }

  global static List<P7S1_Unit__c> getUnitsBySegments(Set<String> segments) {
    if (segments.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_UnitSelector().getRecordsBySegments(
      segments,
      MT_FieldSet.getFields(SObjectType.P7S1_Unit__c.FieldSets.MT_ContextFields)
    );
  }

  global static List<P7S1_Unit__c> getUnitsBySegments(Set<String> segments, Set<String> fields) {
    if (segments.isEmpty()) {
      return new List<SObject>();
    }

    return new MT_UnitSelector().getRecordsBySegments(
      segments,
      fields
    );
  }
}