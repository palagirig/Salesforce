/**
 * It is a selector class for the MT_MediaCampaignType__c object
 *
 * History
 * -------
 * Date        AUTHOR                      DETAIL
 * 08.03.2017  Falco Aulitzky             Initial architecture & development
 * 20.04.2017  Faloc Aulitzky             Technical documentation
 */

/* Selector class to fetch data from the database */
public with sharing class MT_MediaCampaignTypeSelector extends MT_Selector {
  public static final String objectAPIName = MT_MediaCampaignType__c.SobjectType.getDescribe().getName();

  /*
  * Method to fetch data stored in salesforce
  * 
  * @param    Set<String>   fields is a set of Strings that determines which fields are queried of the MediaCampaignType object
  * @returns  List<SObject> a list of MediaCampaignType objects that are treated and stored as a generic type
  *           
  */
  public List<SObject> getRecords(Set<String> fields) {

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName;
    System.debug('Media Campaign Type query: ' + query);
    return Database.query(query);
  }

  /*
  * Method to fetch data stored in salesforce
  * 
  * @param    Set<Id>       recordIds is a set of MediaCampaignType ids
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaCampaignType object
  * @returns  List<SObject> a list of MediaCampaignType objects that are treated and stored as a generic type
  *
  */
  public List<SObject> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Media Campaign Type query by Ids: ' + query);
    return Database.query(query);
  }

  /*
  * Method to fetch data stored in salesforce
  *
  * @param    Boolean       boolean to determine if a record is active or not
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaCampaignType object
  * @returns  List<SObject> a list of MediaCampaignType objects that are treated and stored as a generic type
  *
  */
  public List<SObject> getRecordsByIsActive(Boolean isActive, Set<String> fields) {
    if (isActive == null) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE MT_IsActive__c = ' + isActive;
    System.debug('Media Campaign Type query by isActive: ' + query);
    return Database.query(query);
  }

  /*
  * Method to fetch data stored in salesforce
  *
  * @param    Set<Id>       assetIds is a set of Asset ids
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaCampaignType object
  * @returns  List<SObject> a list of MediaCampaignType objects that are treated and stored as a generic type
  *
  */
  public List<SObject> getRecordsByAssetIds(Set<Id> assetIds, Set<String> fields) {
    if (assetIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' WHERE MT_Asset_ref__c in ' + constructInClauseString(assetIds);
    System.debug('Media Campaign Type query by Asset ids: ' + query);
    return Database.query(query);
  }

  /*
  * Method to fetch data stored in salesforce
  *
  * @param    Set<Id>       recordIds is a set of MediaCampaignType ids
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaCampaignType object
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaForecastValue object
  * @returns  List<SObject> a list of MediaCampaignType objects that are treated and stored as a generic type with MediaForecastValues in it
  *
  */
  public List<SObject> getRecordsWithMediaForecastValuesByIds(Set<Id> recordIds, Set<String> mediaCampaignTypefields, Set<String> mediaForecastValueFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(mediaCampaignTypefields) + ', (SELECT ' + constructFieldString(mediaForecastValueFields) + ' FROM Media_Forecast_Values__r) FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Media Campaign Type with Media Forecast Values query by Ids: ' + query);
    return Database.query(query);
  }

  /*
  * Method to fetch data stored in salesforce
  *
  * @param    Set<Id>       recordIds is a set of MediaCampaignType ids
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaCampaignType object
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaTransparencyCampaign object
  * @returns  List<SObject> a list of MediaCampaignType objects that are treated and stored as a generic type with MediaTransparencyCampaign in it
  *
  */
  public List<SObject> getRecordsWithMediaTransparencyCampaignsByIds(Set<Id> recordIds, Set<String> mediaCampaignTypefields, Set<String> mediaCampaignFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(mediaCampaignTypefields) + ',(SELECT ' + constructFieldString(mediaCampaignFields) + ' FROM Media_Campaigns__r) FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Media Campaign Type with Media Transparency Campaigns query by Ids: ' + query);
    return Database.query(query);
  }

  /*
  * Method to fetch data stored in salesforce
  *
  * @param    Set<Id>       recordIds is a set of MediaCampaignType ids
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaCampaignType object
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaForecastValue object
  *           Set<String>   fields is a set of Strings that determines which fields are queried of the MediaTransparencyCampaign object
  * @returns  List<SObject> a list of MediaCampaignType objects that are treated and stored as a generic type with MediaForecastValue and MediaTransparencyCampaign objects in it
  *
  */
  public List<SObject> getRecordsWithForecastValueAndMediaTransCampaignsByIds(Set<Id> recordIds, Set<String> mediaCampaignTypefields, Set<String> mediaForecastValueFields, Set<String> mediaFCampaignFields) {
    if (recordIds.isEmpty()) {
      return new List<SObject>();
    }

    String query = 'SELECT ' + constructFieldString(mediaCampaignTypefields) + ', (SELECT ' + constructFieldString(mediaForecastValueFields) + ' FROM Media_Forecast_Values__r), (SELECT ' + constructFieldString(mediaFCampaignFields) + ' FROM Media_Campaigns__r) FROM ' + objectAPIName + ' WHERE Id in ' + constructInClauseString(recordIds);
    System.debug('Media Campaign Type with Forecast Values and Media Campaigns query by Ids: ' + query);
    return Database.query(query);
  }
}