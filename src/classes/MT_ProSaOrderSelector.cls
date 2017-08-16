/************************************************************************************************************
Name:  		MT_ProSaOrderSelector
======================================================
Purpose: 	Selector class for MT_ProSaOrder__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
09.02.2017	Sven Kretschmann            Initial architecture & development
15.03.2017  Falco Aulitzky				Align Class
*************************************************************************************************************/
public with sharing class MT_ProSaOrderSelector extends MT_Selector {
  public static final String objectAPIName = MT_ProSaOrder__c.SobjectType.getDescribe().getName();

  public List<SObject> getRecordsByMediaCampaignIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_MediaCampaign_ref__c in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }
}