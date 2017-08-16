/************************************************************************************************************
Name:  		MT_AssetSelector
======================================================
Purpose: 	Selector class for P7S1_Asset__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
08.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_AssetSelector extends MT_Selector {
  public static final String objectAPIName = P7S1_Asset__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Asset query by Ids: ' + query);
    return Database.query(query);
  }

  public List<SObject> getRecordsByUnitIds(Set<Id> unitIds, Set<String> fields) {
    if (unitIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE P7S1_Unit__c in ' + constructInClauseString(unitIds);
    System.debug('Asset query by Unit ids: ' + query);
    return Database.query(query);
  }

  public List<SObject> getRecordsWithMediaCampaignTypesByIds(Set<Id> recordIds, Set<String> assetFields, Set<String> mediaCampaignTypeFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(assetFields) + ',(SELECT ' + constructFieldString(mediaCampaignTypeFields) + ' FROM Media_Campaign_Types__r) FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Asset query with Media Campaign Type by ids: ' + query);
    return Database.query(query);
  }
}