/**
 * Domain class for P7S1_OpportunityApproval__c object
 *
 * History
 * -------
 * Date       AUTHOR            DETAIL
 * 02.12.2016 Duc Nguyen Tien   Initial architecture & development US:203
 * 20.04.2017 Falco Aulitzky    Code documentation
 **/
public with sharing class MT_OpportunityApprovals {
  private List<P7S1_OpportunityApproval__c> scope;
  private Map<Id, P7S1_OpportunityApproval__c> oldScopeMap;

  /* Initialzes class specific variables */
  public MT_OpportunityApprovals(List<P7S1_OpportunityApproval__c> scope, Map<Id, P7S1_OpportunityApproval__c> oldScopeMap) {
    this.scope = scope;
    this.oldScopeMap = oldScopeMap;
  }

  /*
  * Methode that creates MediaUpdateHistories according to Opporutnities and OpportunitiesApprovals and MediaTransparencyCampaigns
  *
  * @returns  MT_OpportunityApprovals
  *           List<P7S1_OpportunityApproval__c> list of OpportunityApprovals
  *           Map<Id, P7S1_OpportunityApproval__c> maps OpportunityApproval ids to OpporunityApproval objects
  */
  public MT_OpportunityApprovals ApprovalProcess_CreateMediaUpdateHistory() {
    Map<Id, P7S1_OpportunityApproval__c> oppApprovalFiltered = new Map<Id, P7S1_OpportunityApproval__c>();
    for (P7S1_OpportunityApproval__c oppApp : this.scope) {
      P7S1_OpportunityApproval__c oldOppApp = this.oldScopeMap.get(oppApp.Id);
      if (oppApp.P7S1_ApprovalState__c != oldOppApp.P7S1_ApprovalState__c && oppApp.P7S1_ApprovalState__c == MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Submitted) {
        oppApprovalFiltered.put(oppApp.Id, oppApp);
      }
    }
    if (!oppApprovalFiltered.isEmpty()) {
      List<MT_MediaUpdateHistory__c> toInsertHistories = new List<MT_MediaUpdateHistory__c>();
      Map<Id, List<MT_MediaCampaign__c>> oppAppIdToCampaignMap = new Map<id, List<MT_MediaCampaign__c>>();
      for (MT_MediaCampaign__c mc : (List<MT_MediaCampaign__c>) new MT_MediaCampaignSelector().getRecordsByOpportunityApprovalIds(oppApprovalFiltered.keySet(), new Set<String>{
        'MT_OpportunityApproval_ref__c'
      })) {
        if (!oppAppIdToCampaignMap.containsKey(mc.MT_OpportunityApproval_ref__c)) {
          oppAppIdToCampaignMap.put(mc.MT_OpportunityApproval_ref__c, new List<MT_MediaCampaign__c>());
        }
        oppAppIdToCampaignMap.get(mc.MT_OpportunityApproval_ref__c).add(mc);
      }
      for (P7S1_OpportunityApproval__c oppApp : oppApprovalFiltered.values()) {
        if (oppAppIdToCampaignMap.containsKey(oppApp.Id)) {
          List<MT_MediaCampaign__c> camps = oppAppIdToCampaignMap.get(oppApp.Id);
          if (camps.size() != 1) {
            oppApp.addError('Multiple or None Media Campaigns found');
          }
          toInsertHistories.add(
            MT_MediaUpdateHistories.create(
              new Opportunity(Id = oppApp.P7S1_Opportunity__c),
              oppApp,
              camps.get(0)
            )
          );
        }

      }
      if (!toInsertHistories.isEmpty()) {
        insert toInsertHistories;
      }
    }
    return this;
  }

  /*
  * Methode that udpates MediaUpdateHistories according to Opporutnities and OpportunitiesApprovals and MediaTransparencyCampaigns
  *
  * @returns  MT_OpportunityApprovals
  *           List<P7S1_OpportunityApproval__c> list of OpportunityApprovals
  *           Map<Id, P7S1_OpportunityApproval__c> maps OpportunityApproval ids to OpporunityApproval objects
  */
  public MT_OpportunityApprovals ApprovalProcess_UpdateMediaUpdateHistory() {
    Map<Id, P7S1_OpportunityApproval__c> oppApprovalFiltered = new Map<Id, P7S1_OpportunityApproval__c>();
    for (P7S1_OpportunityApproval__c oppApp : this.scope) {
      P7S1_OpportunityApproval__c oldOppApp = this.oldScopeMap.get(oppApp.Id);
      if (oppApp.P7S1_ApprovalState__c != oldOppApp.P7S1_ApprovalState__c &&
        (oppApp.P7S1_ApprovalState__c == MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Approved || oppApp.P7S1_ApprovalState__c == MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Rejected)) {
        oppApprovalFiltered.put(oppApp.Id, oppApp);
      }
    }
    if (!oppApprovalFiltered.isEmpty()) {
      List<MT_MediaUpdateHistory__c> toUpdateHistories = new List<MT_MediaUpdateHistory__c>();

      for (MT_MediaUpdateHistory__c muh : (List<MT_MediaUpdateHistory__c>) new MT_MediaUpdateHistorySelector().getSubmittedRecordsByOpportunityApprovalRefId(oppApprovalFiltered.keySet(), new Set<String>{
        'MT_OpportunityApproval_ref__c'
      })) {
        system.debug(muh);
        if (oppApprovalFiltered.containsKey(muh.MT_OpportunityApproval_ref__c)) {
          P7S1_OpportunityApproval__c oppApp = oppApprovalFiltered.get(muh.MT_OpportunityApproval_ref__c);
          if (oppApp.P7S1_ApprovalState__c == MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Approved) {
            toUpdateHistories.add(MT_MediaUpdateHistories.approve(muh));
          } else if (oppApp.P7S1_ApprovalState__c == MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Rejected) {
            toUpdateHistories.add(MT_MediaUpdateHistories.reject(muh));
          }
        }
        system.debug(toUpdateHistories);
        system.debug(muh);
      }
      if (!toUpdateHistories.isEmpty()) {
        system.debug(toUpdateHistories);
        update toUpdateHistories;
      }
    }
    return this;
  }

  /*
  * Methode that sets the status of a P7S1_OpportunityApproval__c object to "Approved"
  *
  * @param    P7S1_OpportunityApproval__c object
  * @returns  P7S1_OpportunityApproval__c object
  *           
  */
  public static P7S1_OpportunityApproval__c approve(P7S1_OpportunityApproval__c oppApp) {
    oppApp.P7S1_ApprovalState__c = MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Approved;
    return oppApp;
  }

  public MT_OpportunityApprovals FieldSync_LockValidation() {
    Map<Id, P7S1_OpportunityApproval__c> filteredScope = new Map<Id, P7S1_OpportunityApproval__c>();
    for (P7S1_OpportunityApproval__c oppApp : this.scope) {
      P7S1_OpportunityApproval__c oldOppApp = this.oldScopeMap.get(oppApp.Id);
      if (MT_SynchronisationModule.hasChanged(oppApp, oldOppApp, false, null)) {
        filteredScope.put(oppApp.Id, oppApp);
      }
    }
    if (!filteredScope.isEmpty()) {
      Map<Id, MT_MediaCampaign__c> mCampMap = new Map<Id, MT_MediaCampaign__c>();

      for (MT_MediaCampaign__c mc : (List<MT_MediaCampaign__c>) new MT_MediaCampaignSelector().getRecordsByOpportunityApprovalIds(filteredScope.keySet(), new Set<String>{
        'Name', 'MT_Status__c', 'MT_OpportunityApproval_ref__c'
      })) {
        if (mCampMap.containsKey(mc.MT_OpportunityApproval_ref__c)) {
          String err = MT_Labels.getInstance().ERR_Sync_MultipleChildCampaignValidation.replace('@Object', 'Opportunity Freigabe').replace('@name', mc.Name);
          filteredScope.get(mc.MT_OpportunityApproval_ref__c).addError(err);
        } else {
          mCampMap.put(mc.MT_OpportunityApproval_ref__c, mc);
        }
      }
      system.debug(mCampMap);
      for (P7S1_OpportunityApproval__c oppApp : filteredScope.values()) {
        system.debug(oppApp.Id);
        if (mCampMap.containsKey(oppApp.Id)) {

          if (MT_MediaCampaigns.isInApprovedState(mCampMap.get(oppApp.Id))) {
            system.debug('MC in ApprovedState');
            MT_SynchronisationModule.hasChanged(oppApp, this.oldScopeMap.get(oppApp.Id), true, MT_Labels.getInstance().ERR_Sync_Opportunity_Lock);
          }
          if (MT_MediaCampaigns.isInApprovalProcess(mCampMap.get(oppApp.Id))) {
            system.debug('MC in Approval PRocess');
            MT_SynchronisationModule.hasChanged(oppApp, this.oldScopeMap.get(oppApp.Id), true, MT_Labels.getInstance().ERR_Sync_MediaCampain_InApprovalLock);
          }
        }
      }
    }
    return this;
  }

  /*
  * Methode that synchronises values between OpportunityApproval and MediaTransparencyCampaign objects
  *
  * @returns  MT_OpportunityApprovals
  *           List<P7S1_OpportunityApproval__c> list of OpportunityApprovals
  *           Map<Id, P7S1_OpportunityApproval__c> maps OpportunityApproval ids to OpporunityApproval objects
  */
  public MT_OpportunityApprovals FieldSync_SyncFields() {
    if (MT_SynchronisationModule.SYNCFLAG_OpportunityApproval) {
      Map<Id, P7S1_OpportunityApproval__c> filteredScope = new Map<Id, P7S1_OpportunityApproval__c>();
      for (P7S1_OpportunityApproval__c oppApp : this.scope) {
        if (MT_SynchronisationModule.hasChanged(oppApp, this.oldScopeMap.get(oppApp.Id), false, null)) {
          filteredScope.put(oppApp.Id, oppApp);
        }
      }

      if (!filteredScope.isEmpty()) {
        List<MT_MediaCampaign__c> mcToUpdate = new List<MT_MediaCampaign__c>();
        Map<Id, MT_MediaCampaign__c> mCampMap = new Map<Id, MT_MediaCampaign__c>();
        Set<string> mcFields = new Set<String>{
          'MT_OpportunityApproval_ref__c', 'Name'
        };
        mcFields.addAll(MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC));
        for (MT_MediaCampaign__c mc : (List<MT_MediaCampaign__c>) new MT_MediaCampaignSelector().getRecordsByOpportunityApprovalIds(filteredScope.keySet(), mcFields)) {
          if (mCampMap.containsKey(mc.MT_OpportunityApproval_ref__c)) {
            String err = MT_Labels.getInstance().ERR_Sync_MultipleChildCampaignValidation.replace('@Object', 'Opportunity').replace('@name', mc.Name);
            filteredScope.get(mc.MT_OpportunityApproval_ref__c).addError(err);
          } else {
            mCampMap.put(mc.MT_OpportunityApproval_ref__c, mc);
          }
        }
        for (P7S1_OpportunityApproval__c oppApp : filteredScope.values()) {
          if (mCampMap.containsKey(oppApp.Id)) {
            MT_MediaCampaign__c mc = mCampMap.get(oppApp.Id);
            if (MT_SynchronisationModule.synchronise(mc, oppApp)) {
              mcToUpdate.add(mc);
            }
          }
        }
        MT_SynchronisationModule.SYNCFLAG_MediaCampaign = false;
        if (!mcToUpdate.isEmpty())
          update mcToUpdate;
      }
    }
    return this;
  }

  /*
  * Methode that creates a P7S1_OpportunityApproval__c object from an Opportunity object
  *
  * @param    P7S1_OpportunityApproval__c object
  * @returns  P7S1_OpportunityApproval__c object
  *           
  */
  public static P7S1_OpportunityApproval__c create(Opportunity opp) {
    if (Test.isRunningTest()) {
      return new P7S1_OpportunityApproval__c(
        P7S1_Opportunity__c = opp.Id,
        P7S1_BmvTv__c = 100000,
        P7S1_BmvTvCustomerIntegration__c = 30,
        P7S1_Mn3TvCustomerIntegration__c = 20,
        P7S1_TvSpotLengthCustomer__c = 10,
        P7S1_TvSpotLength__c = 30
      );
    } else {
      return new P7S1_OpportunityApproval__c(
        P7S1_Opportunity__c = opp.Id
      );
    }
  }
}