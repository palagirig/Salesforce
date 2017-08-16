/************************************************************************************************************
Name:  		MT_UnitSelector
======================================================
Purpose: 	Selector class for P7S1_Unit__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
08.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_UnitSelector extends MT_Selector {
  public static final String objectAPIName = P7S1_Unit__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Unit query by Ids: ' + query);
    return Database.query(query);
  }

  public List<SObject> getRecordsWithAssetsByIds(Set<Id> recordIds, Set<String> unitFields, Set<String> assetFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(unitFields) + ',(SELECT ' + constructFieldString(assetFields) + ' FROM Assets__r) FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Unit with Assets query by Ids: ' + query);
    return Database.query(query);
  }

  public List<SObject> getRecordsBySegments(Set<String> segments, Set<String> fields) {
    if (segments.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE P7S1_Segment__c in ' + constructInClauseString(segments);
    System.debug('Unit query by Segments' + query);
    return Database.query(query);
  }
}