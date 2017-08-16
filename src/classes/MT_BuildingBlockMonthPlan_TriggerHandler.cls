/*
* Name:     MT_BuildingBlockMonthPlan_TriggerHandler
* Purpose:  Trigger; As soon as a Building Block Monthly Plan object is created and nearly saved, the trigger is called.
*           It then will compare Monthly Plans to Parameter Versions and their time frame, when the range passes the PV is stored as a reference on the Plan
* History
* -------
* DATE        AUTHOR                      DETAIL
* 28.04.2017  Falco Aulitzky              Initial architecture and development
*
*/
public with sharing class MT_BuildingBlockMonthPlan_TriggerHandler extends TriggerController {
  public MT_BuildingBlockMonthPlan_TriggerHandler(Boolean isAfter, Boolean isBefore, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate,
    List<sObject> lstNewItems, Map<Id, sObject> mapNewItems, List<sObject> lstOldItems, Map<Id, sObject> mapOldItems) {
    super(isAfter, isBefore, isDelete, isInsert, isUndelete, isUpdate, lstNewItems, mapNewItems, lstOldItems, mapOldItems);
  }

    /* Finds the right Parameter Version for each created Monthly Plan */
  public override void runBeforeInsert() {
    List<MT_MediaCampaignMonthlyPlan__c> mbbmps = ((List<MT_MediaCampaignMonthlyPlan__c>) lstNewItems);
    Map<Id, List<MT_MediaCampaignMonthlyPlan__c>> mctIdsToMbbmp = new Map<Id, List<MT_MediaCampaignMonthlyPlan__c>>();
    List<Id> mcIds = new List<Id>();

    for (MT_MediaCampaignMonthlyPlan__c mbbmp: mbbmps) {
      mcIds.add(mbbmp.MT_MediaCampaign_ref__c);
    }

    Map<ID, MT_MediaCampaign__c> mcs = new Map<ID,MT_MediaCampaign__c>(MT_MediaCampaignService.getMediaCampaignsByIds(new Set<Id>(mcIds), new Set<String>{
      'Id', 'MT_MediaCampaignType_ref__c'
    }));


    for (MT_MediaCampaignMonthlyPlan__c mbbmp: mbbmps) {

      MT_MediaCampaign__c mc = mcs.get(mbbmp.MT_MediaCampaign_ref__c);

      if (!mctIdsToMbbmp.containsKey(mc.MT_MediaCampaignType_ref__c)) {
        mctIdsToMbbmp.put(mc.MT_MediaCampaignType_ref__c, new List<MT_MediaCampaignMonthlyPlan__c>());
      }

      mctIdsToMbbmp.get(mc.MT_MediaCampaignType_ref__c).add(mbbmp);
    }

    List<MT_CampaignTypeParameterVersion__c> ctpvs = [SELECT Id, MT_MediaCampaignType_ref__c, MT_ValidFrom__c FROM MT_CampaignTypeParameterVersion__c WHERE MT_MediaCampaignType_ref__c IN :mctIdsToMbbmp.keySet() ORDER BY MT_ValidFrom__c ASC];

    for (MT_CampaignTypeParameterVersion__c ctpv: ctpvs) {
      for (MT_MediaCampaignMonthlyPlan__c mbbp: mctIdsToMbbmp.get(ctpv.MT_MediaCampaignType_ref__c)) {
        if (ctpv.MT_ValidFrom__c <= mbbp.MT_PlanningDate__c) {
          mbbp.MT_MediaCampaignTypeParameterVersion_ref__c = ctpv.Id;
        }
      }
    }
  }
}