/************************************************************************************************************
Name:  		MT_OpportunitySelector
======================================================
Purpose: 	Selector class for Opportunity object
======================================================
History
-------
Date		AUTHOR						DETAIL
05.12.2016	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_OpportunitySelector extends MT_Selector {
  public static final String objectAPIName = Opportunity.SobjectType.getDescribe().getName();

  public List<sObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where Id in ' + constructInClauseString(recordIds);
    return Database.query(query);
  }
}