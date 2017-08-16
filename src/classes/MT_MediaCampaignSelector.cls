/*
* Name:  		MT_MediaBuildingBlockSelector
*
* Purpose: 	Selector class for MT_MediaCampaign__c object
*
* History
* -------
* Date	     	AUTHOR						DETAIL
* 17.11.2016	Duc Nguyen Tien             Initial architecture & development
* 21.04.2017    Falco Aulitzky              Javadoc style documentation added
*/
public with sharing class MT_MediaCampaignSelector extends MT_Selector {
  public static final String objectAPIName = MT_MediaCampaign__c.SobjectType.getDescribe().getName();

    /*
    * Method that queries data from the database
    *
    * @param     Set<Id> recordIds:  MediaTransparencyCampaign object ids
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

    /*
    * Method that queries data from the database
    *
    * @param     Set<Id> recordIds:  OpporunityApproval object ids
    *            Set<String> fields: fields that are queried for MediaTransparencyCampaign objects
    * @return generic list of an object
    */
  public List<SObject> getRecordsByOpportunityApprovalIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_OpportunityApproval_ref__c in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }

    /*
    * Method that queries data from the database
    *
    * @param     Set<Id> recordIds:  Opporunity object ids
    *            Set<String> fields: fields that are queried for MediaTransparencyCampaign objects
    * @return generic list of an object
    */
  public List<SObject> getRecordsByOpportunityIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_Opportunity_ref__c in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }

  /**
   * Queries Media Campaigns by KRS IDs.
   *
   * @param krsIds set of KRS IDs
   * @param fields fields that are queried
   * @return query results
   */
  public List<sObject> getRecordsByKrsIds(Set<String> krsIds, Set<String> fields) {
    if (krsIds.isEmpty()) {
      return new List<sObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where ' + MT_MediaCampaign__c.MT_KRSID__c.getDescribe().getName() + ' in ' + constructInClauseString(krsIds);
    system.debug(query);
    return Database.query(query);
  }
}