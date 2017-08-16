/*
* Name:     MT_AssignCampTypeVersionToMonthlyPlans
* Purpose:  Batch job; As soon as a Media Campaign Type Parameter Version is created this class
*           queries all Media Building Block Monthly Plans and updates the lookup field to the proper one, in regards of the valid date.
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 28.04.2017  Falco Aulitzky              Initial architecture and development
*
*/
global without sharing class MT_AssignCampTypeVersionToMonthlyPlans extends MT_Selector implements Database.Batchable<sObject> {

  Map<Id, Set<MT_CampaignTypeParameterVersion__c>> mctIdsToPvs;
  Set<Id> mctIds;
  String query;

    /*
    * Queries MediaBuildingBlockMonthlyPlan objects that need to be updated
    *
    * @param    Map<Id, List<MT_CampaignTypeParameterVersion__c>> mctIdsToPvs: Map from MediaCampaignType ids to MediaCampaignTypeParameterVersion objects
    *           Date mctpvValidFromDate: MediaCampaignTypeParameterVersion earliestDate
    *           Date mctpvValidToDate: MediaCampaignTypeParameterVersion latestDate
    *
    */
  global MT_AssignCampTypeVersionToMonthlyPlans(Map<Id, Set<MT_CampaignTypeParameterVersion__c>> mctIdsToPvs, Date mctpvValidFromDate, Date mctpvValidToDate) {
    this.mctIdsToPvs = mctIdsToPvs;
    this.mctIds = mctIdsToPvs.keySet();
    String fromDate = ((mctpvValidFromDate + '').split(' ')).get(0);
    String toDate = ((mctpvValidToDate + '').split(' ')).get(0);

    if (mctpvValidToDate != null) {
      this.query = 'SELECT Id, MT_PlanningDate__c, MT_MediaCampaignTypeParameterVersion_ref__c, MT_MediaCampaign_ref__r.MT_MediaCampaignType_ref__c FROM MT_MediaCampaignMonthlyPlan__c WHERE MT_MediaCampaign_ref__r.MT_MediaCampaignType_ref__c in ' + constructInClauseString(mctIds) + ' AND MT_PlanningDate__c >= ' + fromDate + ' AND MT_PlanningDate__c < ' + toDate + ' ORDER BY MT_PlanningDate__c ASC';
    } else {
      this.query = 'SELECT Id, MT_PlanningDate__c, MT_MediaCampaignTypeParameterVersion_ref__c, MT_MediaCampaign_ref__r.MT_MediaCampaignType_ref__c FROM MT_MediaCampaignMonthlyPlan__c WHERE MT_MediaCampaign_ref__r.MT_MediaCampaignType_ref__c in ' + constructInClauseString(mctIds) + ' AND MT_PlanningDate__c >= ' + fromDate + ' ORDER BY MT_PlanningDate__c ASC';
    }

  }

  global Database.QueryLocator start(Database.BatchableContext BC) {
    System.debug('Batch start: ' + query);
    return Database.getQueryLocator(this.query);
  }

    /*
    * Compares Dates to figure out which MediaCampaignTypeParameterVersion belongs to which MediaBuildingBlockMonthlyPlan in regards to the MediaCampaignType id
    *
    * @param    List<sObject> scope : List of queried sObject
    *
    */
  global void execute(Database.BatchableContext BC, List<sObject> scope) {
    Map<Id, MT_MediaCampaignMonthlyPlan__c> toBeUpdatedMap = new Map<Id, MT_MediaCampaignMonthlyPlan__c>();

    for (sObject obj: scope) {
      MT_MediaCampaignMonthlyPlan__c toBeUpdated = (MT_MediaCampaignMonthlyPlan__c) obj;

      for (MT_CampaignTypeParameterVersion__c pv: mctIdsToPvs.get(toBeUpdated.MT_MediaCampaign_ref__r.MT_MediaCampaignType_ref__c)) {
        toBeUpdated.MT_MediaCampaignTypeParameterVersion_ref__c = pv.Id;

        toBeUpdatedMap.put(toBeUpdated.id, toBeUpdated);
      }
    }
    upsert toBeUpdatedMap.values();
  }

  global void finish(Database.BatchableContext BC) {
  }
}