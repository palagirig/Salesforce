/**
* Name:     MT_BusinessPlanningController
* Purpose:  Controller for the page MT_BusinessPlanning. 
*           It contains all the method for an angular app to access the sfdc db. Refered as Backend
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 17.11.2016  Duc Nguyen Tien             Initial architecture and development
* 19.01.2017  Duc Nguyen Tien             US193: Cockpit header | adding query method to query the TV Building block
* 12.04.2017  Falco Aulitzky              Adding JavaDoc-Styled documentation
*
*/

/* Selector class to fetch data from the database */
public with sharing class MT_MediaBuildingBlockSelector extends MT_Selector {
  
  public static final String objectAPIName = MT_TvTarget__c.SobjectType.getDescribe().getName();

  
  /*
  * Method to fetch data stored in salesforce
  * 
  * @param    Set<Id>       recordIds is a set of MediaBuildingBlock ids
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaBuildingBlock object
  * @returns  List<SObject> a list of MediaBuildingBlock objects that are treated and stored as a generic type
  *           
  */
  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where Id in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }
  
  /*
  * Method to fetch data stored in salesforce
  * 
  * @param    Set<Id>       recordIds is a set of MediaTransparencyCampaign ids
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaBuildingBlock object
  * @returns  List<SObject> a list of MediaBuildingBlock objects that are treated and stored as a generic type that match the ids of MediaTransparencyCampaign ids
  *           
  */
  public List<SObject> getRecordsByMediaCampaignIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_MediaCampaign_ref__c in ' + constructInClauseString(recordIds);
    system.debug(query);
    return Database.query(query);
  }
  
  /*
  * Method to fetch data stored in salesforce
  * 
  * @param    Set<Id>       recordIds is a set of MediaTransparencyCampaign ids
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaBuildingBlock object
  * @returns  List<SObject> a list of MediaBuildingBlock objects that are treated and stored as a generic type that match the ids of MediaTransparencyCampaign ids and
  *                         also match the TV type
  *           
  */
  public List<SObject> getTVRecordsByMediaCampaignIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_MediaCampaign_ref__c in ' + constructInClauseString(recordIds) + ' and MT_Type__c =\'' + MT_Constants.getInstance().MediaBuildingBlock_Type_TV + '\'';
    system.debug(query);
    return Database.query(query);
  }
}