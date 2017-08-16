/*
* Name:     MT_CamTypeParaVersion_TriggerHandler
* Purpose:  Trigger; As soon as a Media Campaign Type Parameter Version object is created and nearly saved, the trigger is called.
*			It then will start a batch job after it determines begin and end date range of the object itself
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 28.04.2017  Falco Aulitzky              Initial architecture and development
*
*/
public without sharing class MT_CamTypeParaVersion_TriggerHandler extends TriggerController {
  public MT_CamTypeParaVersion_TriggerHandler(Boolean isAfter, Boolean isBefore, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate,
    List<sObject> lstNewItems, Map<Id, sObject> mapNewItems, List<sObject> lstOldItems, Map<Id, sObject> mapOldItems) {
    super(isAfter, isBefore, isDelete, isInsert, isUndelete, isUpdate, lstNewItems, mapNewItems, lstOldItems, mapOldItems);
  }

	/* Determines the Start and End date of a parameter version and maps them to a Media Campaign Type id*/
  public override void runAfterInsert() {
    Set<MT_CampaignTypeParameterVersion__c> ctpvsSet = new Set<MT_CampaignTypeParameterVersion__c>((List<MT_CampaignTypeParameterVersion__c>) lstNewItems);
    Map<Id, Set<MT_CampaignTypeParameterVersion__c>> mctIdsToPvs = new Map<Id, Set<MT_CampaignTypeParameterVersion__c>>();

    Date earliestDate = null;
    Date latestDate = null;
    Date tempDate = null;

    for (MT_CampaignTypeParameterVersion__c ctpv: ctpvsSet) {
      tempDate = ctpv.MT_ValidFrom__c;

      if (earliestDate == null) {
        earliestDate = tempDate;
      } else if (tempDate < earliestDate) {
        earliestDate = tempDate;
      }

      if (!mctIdsToPvs.containsKey(ctpv.MT_MediaCampaignType_ref__c)) {
        mctIdsToPvs.put(ctpv.MT_MediaCampaignType_ref__c, new Set<MT_CampaignTypeParameterVersion__c>());
      }

      mctIdsToPvs.get(ctpv.MT_MediaCampaignType_ref__c).add(ctpv);
    }

    ctpvsSet.addAll(MT_CampaignTypeParameterVersionService.getCampaignTypeParameterVersionsFromDate(earliestDate));

    earliestDate = null;

    for (MT_CampaignTypeParameterVersion__c ctpv: ctpvsSet) {
      tempDate = ctpv.MT_ValidFrom__c;

      if (earliestDate == null) {
        earliestDate = tempDate;
      }

      if (latestDate == null) {
        latestDate = tempDate;
      }

      if (tempDate < earliestDate) {
        earliestDate = tempDate;
      } else if (tempDate > latestDate) {
        latestDate = tempDate;
      }

    }

    if (earliestDate == latestDate) {
      Id batchInstanceId = Database.executeBatch(new MT_AssignCampTypeVersionToMonthlyPlans(mctIdsToPvs, earliestDate, null));
    } else {
      Id batchInstanceId = Database.executeBatch(new MT_AssignCampTypeVersionToMonthlyPlans(mctIdsToPvs, earliestDate, latestDate));
    }
  }
}