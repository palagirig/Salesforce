/************************************************************************************************************
Name:  		MT_MediaUpdateHistories
======================================================
Purpose: 	Domain class for MT_MediaUpdateHistory__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
02.12.2016	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
public class MT_MediaUpdateHistories {
  private static final string OppPrefix = 'MT_Opp_';
  private static final string OppAppPrefix = 'MT_OppApp_';

  private List<MT_MediaUpdateHistory__c> scope;
  private Map<Id, MT_MediaUpdateHistory__c> oldScopeMap;
  public MT_MediaUpdateHistories(List<MT_MediaUpdateHistory__c> scope) {
    this.scope = scope;
  }
  public MT_MediaUpdateHistories(List<MT_MediaUpdateHistory__c> scope, Map<Id, MT_MediaUpdateHistory__c> oldScopeMap) {
    this.scope = scope;
    this.oldScopeMap = oldScopeMap;
  }
  // Method only to be used in before insert trigger context
  public MT_MediaUpdateHistories copyValuesFromReferenceObjects() {
    Set<Id> oppIds = new Set<Id>();
    Set<Id> oppAppIds = new Set<Id>();
    Set<Id> mcampIds = new Set<Id>();

    for (MT_MediaUpdateHistory__c muh : this.scope) {
      if (muh.MT_Opportunity_ref__c != null)
        oppIds.add(muh.MT_Opportunity_ref__c);
      if (muh.MT_OpportunityApproval_ref__c != null)
        oppAppIds.add(muh.MT_OpportunityApproval_ref__c);
      if (muh.MT_MediaCampaign_ref__c != null)
        mcampIds.add(muh.MT_MediaCampaign_ref__c);
    }

    Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>((List<Opportunity>) new MT_OpportunitySelector().getRecordsByIds(oppIds, MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.Opp)));
    Map<Id, MT_MediaCampaign__c> mcampMap = new Map<Id, MT_MediaCampaign__c>((List<MT_MediaCampaign__c>) new MT_MediaCampaignSelector().getRecordsByIds(mcampIds, MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC)));
    Map<Id, P7S1_OpportunityApproval__c> oppAppMap = new Map<Id, P7S1_OpportunityApproval__c>((List<P7S1_OpportunityApproval__c>) new MT_OpportunityApprovalSelector().getRecordsByIds(oppAppIds, MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.OppApp)));

    List<Opportunity> oppToUpdate = new List<Opportunity>();
    List<MT_MediaCampaign__c> mCampToUpdate = new List<MT_MediaCampaign__c>();
    List<P7S1_OpportunityApproval__c> oppAppToUpdate = new List<P7S1_OpportunityApproval__c>();

    for (MT_MediaUpdateHistory__c muh : this.scope) {
      MT_MediaCampaign__c mc = mcampMap.get(muh.MT_MediaCampaign_ref__c);
      Opportunity opp = oppMap.get(muh.MT_Opportunity_ref__c);
      P7S1_OpportunityApproval__c oppApp = oppAppMap.get(muh.MT_OpportunityApproval_ref__c);

      if (opp != null) {
        if (mc != null && muh.MT_Sys_ApprovalSubmittedFromCampaign__c) { // DNT: THis if statement is to revert the opp/oppApp to state equal to Campaign as the approval was submitted by Campaign!
          if (MT_SynchronisationModule.synchronise(opp, mc)) {
            oppToUpdate.add(opp);
          }
        }
        MT_SynchronisationModule.synchronise(muh, opp);
      }
      if (oppApp != null) {
        if (mc != null && muh.MT_Sys_ApprovalSubmittedFromCampaign__c) { // DNT: THis if statement is to revert the opp/oppApp to state equal to Campaign as the approval was submitted by Campaign!
          system.debug(oppApp);
          system.debug(mc);
          if (MT_SynchronisationModule.synchronise(oppApp, mc)) {
            oppAppToUpdate.add(oppApp);
          }
        }
        MT_SynchronisationModule.synchronise(muh, oppApp);
      }
      if (mc != null) {
        MT_SynchronisationModule.synchronise(muh, mc);
      }
    }
    MT_SynchronisationModule.SYNCFLAG_MediaCampaign = false; //FOr opportunity to not run the syncing mechanism for MediaCampaign
    MT_SynchronisationModule.ACTIVE_HASCHANGED_Opportunity = false;
    MT_SynchronisationModule.ACTIVE_HASCHANGED_OpportunityApproval = false;
    if (!oppToUpdate.isEmpty())
      update oppToUpdate;
    system.debug('===> ');
    system.debug(oppAppToUpdate);
    if (!oppAppToUpdate.isEmpty())
      update oppAppToUpdate;
    MT_SynchronisationModule.SYNCFLAG_MediaCampaign = true;
    MT_SynchronisationModule.ACTIVE_HASCHANGED_Opportunity = true;
    MT_SynchronisationModule.ACTIVE_HASCHANGED_OpportunityApproval = true;
    return this;
  }
  public MT_MediaUpdateHistories ApprovalProcess_Approved() {
    List<MT_MediaCampaign__c> mcToUpdate = new List<MT_MediaCampaign__c>();
    for (MT_MediaUpdateHistory__c muh : this.scope) {
      MT_MediaUpdateHistory__c oldMuh = this.oldScopeMap.get(muh.Id);
      if (muh.MT_ApprovalStatus__c != oldMuh.MT_ApprovalStatus__c && muh.MT_ApprovalStatus__c == MT_Constants.getInstance().MediaUpdateHistory_Status_Approved) {
        if (muh.MT_MediaCampaign_ref__c != null)
          mcToUpdate.add(MT_MediaCampaigns.approve(new MT_MediaCampaign__c(Id = muh.MT_MediaCampaign_ref__c)));
      }
    }
    if (!mcToUpdate.isEmpty())
      update mcToUpdate;
    return this;
  }
  public MT_MediaUpdateHistories ApprovalProcess_Rejected() {
    Map<Id, MT_MediaUpdateHistory__c> filteredScope = new Map<Id, MT_MediaUpdateHistory__c>();
    Set<Id> oppAppIds = new Set<Id>();
    for (MT_MediaUpdateHistory__c muh : this.scope) {
      MT_MediaUpdateHistory__c oldMuh = this.oldScopeMap.get(muh.Id);
      if (muh.MT_ApprovalStatus__c != oldMuh.MT_ApprovalStatus__c && muh.MT_ApprovalStatus__c == MT_Constants.getInstance().MediaUpdateHistory_Status_Rejected) {
        filteredScope.put(muh.Id, muh);
        oppAppIds.add(muh.MT_OpportunityApproval_ref__c);
      }
    }
    if (!filteredScope.isEmpty()) {
      Set<String> muhQueryFields = new Set<String>{
        'MT_OpportunityApproval_ref__c', 'MT_Opportunity_ref__c', 'MT_MediaCampaign_ref__c', 'MT_Sys_ApprovalSubmittedFromCampaign__c'
      };
      muhQueryFields.addAll(MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MUH));

      Map<Id, MT_MediaUpdateHistory__c> oppAppIdToMediaUpdateHistoryMap = new Map<Id, MT_MediaUpdateHistory__c>();
      for (MT_MediaUpdateHistory__c approvedMUH : new MT_MediaUpdateHistorySelector().getApprovedRecordsByOpportunityApprovalRefId(oppAppIds, muhQueryFields)) {
        if (!oppAppIdToMediaUpdateHistoryMap.containsKey(approvedMUH.MT_OpportunityApproval_ref__c))
          oppAppIdToMediaUpdateHistoryMap.put(approvedMUH.MT_OpportunityApproval_ref__c, approvedMUH);
      }

      List<Sobject> oppToUpdate = new List<Sobject>();
      List<Sobject> oppAppToUpdate = new List<Sobject>();
      List<Sobject> mCampToUpdate = new List<Sobject>();
      for (MT_MediaUpdateHistory__c muh : filteredScope.values()) {
        if (oppAppIdToMediaUpdateHistoryMap.containsKey(muh.MT_OpportunityApproval_ref__c)) {
          MT_MediaUpdateHistory__c approvedMUH = oppAppIdToMediaUpdateHistoryMap.get(muh.MT_OpportunityApproval_ref__c);
          if (approvedMUH.MT_Opportunity_ref__c != null) {
            Opportunity opp = new Opportunity(Id = approvedMUH.MT_Opportunity_ref__c);
                        /*for(String muhSyncField : MT_SynchronisationModule.mediaUpdateHistory_Opportunity_FieldMapping.keySet()){
                            String oppSyncField = MT_SynchronisationModule.mediaUpdateHistory_Opportunity_FieldMapping.get(muhSyncField);
                            opp.put(oppSyncField, approvedMUH.get(muhSyncField));
                        }*/
            if (MT_SynchronisationModule.synchronise(opp, approvedMUH))
              oppToUpdate.add(opp);
          }
          if (approvedMUH.MT_MediaCampaign_ref__c != null) {
            MT_MediaCampaign__c mc = new MT_MediaCampaign__c(Id = approvedMUH.MT_MediaCampaign_ref__c);
                        /*for(String muhSyncField : MT_SynchronisationModule.mediaUpdateHistory_MediaCampaign_FieldMapping.keySet()){
                            String mcSyncField = MT_SynchronisationModule.mediaUpdateHistory_MediaCampaign_FieldMapping.get(muhSyncField);
                            mc.put(mcSyncField, approvedMUH.get(muhSyncField));
                        }*/
            if (MT_SynchronisationModule.synchronise(mc, approvedMUH))
              mCampToUpdate.add(MT_MediaCampaigns.approve(mc));
          }
          if (approvedMUH.MT_OpportunityApproval_ref__c != null) {
            P7S1_OpportunityApproval__c oppApp = new P7S1_OpportunityApproval__c(Id = approvedMUH.MT_OpportunityApproval_ref__c);
                        /*for(String muhSyncField : MT_SynchronisationModule.mediaUpdateHistory_OpportunityApproval_FieldMapping.keySet()){
                            String oppAppSyncField = MT_SynchronisationModule.mediaUpdateHistory_OpportunityApproval_FieldMapping.get(muhSyncField);
                            oppApp.put(oppAppSyncField, approvedMUH.get(muhSyncField));
                        }*/
            if (MT_SynchronisationModule.synchronise(oppApp, approvedMUH))
              oppAppToUpdate.add(MT_OpportunityApprovals.approve(oppApp));
          }
        }
      }
      MT_SynchronisationModule.SYNCFLAG_Opportunity = false;
      MT_SynchronisationModule.SYNCFLAG_MediaCampaign = false;
      MT_SynchronisationModule.SYNCFLAG_OpportunityApproval = false;
      MT_SynchronisationModule.ACTIVE_HASCHANGED_Opportunity = false;
      MT_SynchronisationModule.ACTIVE_HASCHANGED_MediaCampaign = false;
      MT_SynchronisationModule.ACTIVE_HASCHANGED_OpportunityApproval = false;
      if (!oppToUpdate.isEmpty())
        update oppToUpdate;
      if (!oppAppToUpdate.isEmpty())
        update oppAppToUpdate;
      MT_MediaCampaigns.ACTIVE_ValidateStatus = false;
      if (!mCampToUpdate.isEmpty())
        update mCampToUpdate;
      MT_MediaCampaigns.ACTIVE_ValidateStatus = true;
      MT_SynchronisationModule.SYNCFLAG_Opportunity = true;
      MT_SynchronisationModule.SYNCFLAG_MediaCampaign = true;
      MT_SynchronisationModule.SYNCFLAG_OpportunityApproval = true;
      MT_SynchronisationModule.ACTIVE_HASCHANGED_Opportunity = true;
      MT_SynchronisationModule.ACTIVE_HASCHANGED_MediaCampaign = true;
      MT_SynchronisationModule.ACTIVE_HASCHANGED_OpportunityApproval = true;
    }
    return this;
  }
  public static MT_MediaUpdateHistory__c create(Opportunity opp, P7S1_OpportunityApproval__c oppApp, MT_MediaCampaign__c mc) {
    if (mc != null)
      return new MT_MediaUpdateHistory__c(MT_OpportunityApproval_ref__c = oppApp.Id, MT_Sys_ApprovalSubmittedFromCampaign__c = oppApp.MT_Sys_ApprovalSubmittedFromCampaign__c, MT_Opportunity_ref__c = opp.Id, MT_MediaCampaign_ref__c = mc.Id, MT_ApprovalStatus__c = MT_Constants.getInstance().MediaUpdateHistory_Status_Submitted); else
      return new MT_MediaUpdateHistory__c(MT_OpportunityApproval_ref__c = oppApp.Id, MT_Sys_ApprovalSubmittedFromCampaign__c = oppApp.MT_Sys_ApprovalSubmittedFromCampaign__c, MT_Opportunity_ref__c = opp.Id, MT_ApprovalStatus__c = MT_Constants.getInstance().MediaUpdateHistory_Status_Submitted);
  }
  public static MT_MediaUpdateHistory__c reject(MT_MediaUpdateHistory__c muh) {
    muh.MT_ApprovalStatus__c = MT_Constants.getInstance().MediaUpdateHistory_Status_Rejected;
    return muh;
  }
  public static MT_MediaUpdateHistory__c approve(MT_MediaUpdateHistory__c muh) {
    muh.MT_ApprovalStatus__c = MT_Constants.getInstance().MediaUpdateHistory_Status_Approved;
    return muh;
  }

}