/*
* Name:  		MT_CampaignTypeParameterVersionSelector
* 
* Purpose: 	Selector class for MT_CampaignTypeParameterVersion__c object
* 
* History
* -------
* Date	     	AUTHOR						DETAIL
* 04.05.2017	Falco Aulitzky             Initial architecture & development
*/
public with sharing class MT_CampaignTypeParameterVersionSelector extends MT_Selector {
  public static final String objectAPIName = MT_CampaignTypeParameterVersion__c.SobjectType.getDescribe().getName();

    /*
    * Method that queries data from the database
    *
    * @param     Set<String> fields: fields that are queried on said object
    * @return generic list of an object
    */
  public List<SObject> getRecords(Set<String> fields) {

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' ORDER BY MT_ValidFrom__c DESC';
    system.debug(query);
    return Database.query(query);
  }

	/*
    * Method that queries data from the database
    *
    * @param     Set<Id> recordIds:  CampaignTypeParameterVersion object ids
    *            Set<String> fields: fields that are queried on said object
    * @return generic list of an object
    */
  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where Id in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }

    /*
    * Method that queries data from the database
    *
    * @param     Set<Date> years:  years
    *            Set<String> fields: fields that are queried on said object
    * @return generic list of an object
    */
  public List<SObject> getRecordsByYears(Set<String> years, Set<String> fields) {
    if (years.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_ValidFrom__c in ' + constructInClauseString(years);
    system.debug(query);
    return Database.query(query);
  }

    /*
    * Method that queries data from the database
    *
    * @param     Date fromDate: Sets a Date limit from which Date onwards the data should be queried
    * @return generic list of an object
    */
  public List<SObject> getRecordsFromDate(Date fromDate, Set<String> fields) {
    String fromDateString = ((fromDate + '').split(' ')).get(0);
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_ValidFrom__c >' + fromDateString + ' ORDER BY MT_ValidFrom__c ASC LIMIT 1';
    system.debug(query);
    return Database.query(query);
  }

    /*
    * Method that queries data from the database
    *
    * @param     Set<Id> recordIds:  MediaCampaignType object ids
    *            Set<String> fields: fields that are queried on said object
    * @return generic list of an object
    */
  public List<SObject> getRecordsByMediaCampaignTypeIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_MediaCampaignType_ref__c in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }
}