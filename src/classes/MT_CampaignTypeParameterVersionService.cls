/*
* Name:  		MT_CampaignTypeParameterVersionService
*
* Purpose: 	Service class for MT_CampaignTypeParameterVersion__c object
* 
* History
* -------
* Date		    AUTHOR	  		     DETAIL
* 04.05.2017	Falco Aulitzky       Initial architecture & development
*/
global with sharing class MT_CampaignTypeParameterVersionService {
 
	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param Set<ID> ctpvIds: Set of MediaTransparencyCampaign ids
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersions() {
    return MT_CampaignTypeParameterVersionService.getCampaignTypeParameterVersions(MT_FieldSet.getFields(SObjectType.MT_CampaignTypeParameterVersion__c.FieldSets.MT_ContextFields));
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param  Set<ID> ctpvIds: Set of MediaTransparencyCampaign ids
	*         Set<String> fields: Set of fields that are demanded by the caller
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersions(Set<String> fields) {
    return new MT_CampaignTypeParameterVersionSelector().getRecords(fields);
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param Set<ID> ctpvIds: Set of MediaTransparencyCampaign ids
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersionsByIds(Set<ID> ctpvIds) {
    return MT_CampaignTypeParameterVersionService.getCampaignTypeParameterVersionsByIds(ctpvIds, MT_FieldSet.getFields(SObjectType.MT_CampaignTypeParameterVersion__c.FieldSets.MT_ContextFields));
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param  Set<ID> ctpvIds: Set of MediaTransparencyCampaign ids
	*         Set<String> fields: Set of fields that are demanded by the caller
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersionsByIds(Set<ID> ctpvIds, Set<String> fields) {
    return new MT_CampaignTypeParameterVersionSelector().getRecordsByIds(ctpvIds, fields);
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param Set<ID> ctpvIds: Set of MediaTransparencyCampaign ids
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersionsByYears(Set<String> years) {
    return MT_CampaignTypeParameterVersionService.getCampaignTypeParameterVersionsByYears(years, MT_FieldSet.getFields(SObjectType.MT_CampaignTypeParameterVersion__c.FieldSets.MT_ContextFields));
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param  Set<ID> ctpvIds: Set of MediaTransparencyCampaign ids
	*         Set<String> fields: Set of fields that are demanded by the caller
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersionsByYears(Set<String> years, Set<String> fields) {
    return new MT_CampaignTypeParameterVersionSelector().getRecordsByYears(years, fields);
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param Set<ID> ctpvIds: Set of MediaTransparencyCampaign ids
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersionsFromDate(Date fromDate) {
    return MT_CampaignTypeParameterVersionService.getCampaignTypeParameterVersionsFromDate(fromDate, MT_FieldSet.getFields(SObjectType.MT_CampaignTypeParameterVersion__c.FieldSets.MT_ContextFields));
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param  Set<ID> ctpvIds: Set of MediaTransparencyCampaign ids
	*         Set<String> fields: Set of fields that are demanded by the caller
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersionsFromDate(Date fromDate, Set<String> fields) {
    return new MT_CampaignTypeParameterVersionSelector().getRecordsFromDate(fromDate, fields);
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param Set<ID> mctIds: Set of MediaCampaignType ids
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersionByMediaCampaignTypeIds(Set<ID> mctIds) {
    return MT_CampaignTypeParameterVersionService.getCampaignTypeParameterVersionsByMediaCampaignTypeIds(mctIds, MT_FieldSet.getFields(SObjectType.MT_CampaignTypeParameterVersion__c.FieldSets.MT_ContextFields));
  }

	/*
	* static method to call the selector which queries the object and fields that were demanded
	*
	* @param  Set<ID> mctIds: Set of MediaCampaignType ids
	*         Set<String> fields: Set of fields that are demanded by the caller
	* @return a list with MediaTransparencyCampaign objects
	*/
  global static List<MT_CampaignTypeParameterVersion__c> getCampaignTypeParameterVersionsByMediaCampaignTypeIds(Set<ID> mctIds, Set<String> fields) {
    return new MT_CampaignTypeParameterVersionSelector().getRecordsByMediaCampaignTypeIds(mctIds, fields);
  }
}