/**
* Name:     MT_CampTypeParameterVersionController
* Purpose:  Controller for the page MT_ParameterVersions. 
*           It contains all the method for an angular app to access the sfdc db. Refered as Backend
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 04.05.2017  Falco Aulitzky              Initial architecture and development
*
*/
public with sharing class MT_CampTypeParameterVersionController {
  public MT_CampTypeParameterVersionController(ApexPages.StandardController stdController) {
  }

	/*
  	* Remote Action that is accessed by Javascript to load CampaignTypeParameterVersions and CampaignTypes
  	* 
  	* @returns  MT_CampTypeParameterVersionControllerDTO
  	*           Map<Id, List<MT_CampaignTypeParameterVersion__c>> campainTypesToParameterVersions maps CampaignType ids to lists of CampaignTypeParameterVersions
  	*/
  @RemoteAction
  public static MT_CampTypeParameterVersionControllerDTO loadParameterVersionsCombinedWithCampaignTypes() {
    return new MT_CampTypeParameterVersionControllerDTO().getParameterVersionsCombinedWithCampaignTypes(
      MT_CampaignTypeParameterVersionService.getCampaignTypeParameterVersions(),
      MT_MediaCampaignTypeService.getMediaCampaignTypes()
    );
  }

  public class MT_CampTypeParameterVersionControllerDTO {
    Map<Id, List<MT_CampaignTypeParameterVersion__c>> campaignTypesToParameterVersions;
    Map<Id, MT_MediaCampaignType__c> campaignTypeIdToCampaignTypeObject;

		/*
	    * Method to fill a map with data from the database
	    * 
	    * @param    List<MT_CampaignTypeParameterVersion__c> paraVersions gets the CampaignTypeParameterVersion objects
	    *			List<MT_MediaCampaignType__c> campaignTypes gets the MediaCampaignType objects
	    * @returns  MT_CampTypeParameterVersionControllerDTO with:
	    *           MediaCampaignType ids mapped to a list of CampaignTypeParameterVersion objects
	    */
    public MT_CampTypeParameterVersionControllerDTO getParameterVersionsCombinedWithCampaignTypes(List<MT_CampaignTypeParameterVersion__c> paraVersions, List<MT_MediaCampaignType__c> campaignTypes) {
      campaignTypesToParameterVersions = new Map<Id, List<MT_CampaignTypeParameterVersion__c>>();
      campaignTypeIdToCampaignTypeObject = new Map<Id, MT_MediaCampaignType__c>();

      for (MT_MediaCampaignType__c mct: campaignTypes) {

        if (!campaignTypesToParameterVersions.containsKey(mct.Id)) {
          campaignTypesToParameterVersions.put(mct.Id, new List<MT_CampaignTypeParameterVersion__c>());
        }

        campaignTypeIdToCampaignTypeObject.put(mct.Id, mct);

        for (MT_CampaignTypeParameterVersion__c pv: paraVersions) {
          if (pv.MT_MediaCampaignType_ref__c == mct.Id) {
            campaignTypesToParameterVersions.get(mct.Id).add(pv);
          }
        }
      }

      return this;
    }
  }
}