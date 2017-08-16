/**
 * Domain class for MT_MediaCampaign object
 *
 * History
 * -------
 * Date       AUTHOR            DETAIL
 * 02.12.2016 Duc Nguyen Tien   Initial architecture & development US:203
 * 18.04.2017 Sven Kretschmann  Code documentation
 **/
public with sharing class MT_MediaCampaigns {
  /** Constant with delayed initialization, thus not marked as final */
  private static Id MT_MEDIACAMPAIGN_RECTYPEID_INTERNAL;
  /** Constant with delayed initialization, thus not marked as final */
  private static Id MT_MEDIACAMPAIGN_RECTYPEID_EXTERNAL;

  private List<MT_MediaCampaign__c > scope;
  private Map<Id, MT_MediaCampaign__c> oldScopeMap;

  public static Boolean ACTIVE_ValidateStatus = true;

  /**
   * Initialize this handler with a scope.
   *
   * @param List<MT_MediaCampaign__c> scope The affected campaigns to manage.
   */
  public MT_MediaCampaigns(List<MT_MediaCampaign__c> scope) {
    this.scope = scope;
  }

  /**
   * Initialize this handler with a scope (expecting a trigger context with new / updated opportunities and optionally
   * a map with the old versions).
   *
   * @param List<MT_MediaCampaign__c>     scope     The affected campaigns to manage.
   * @param Map<Id, MT_MediaCampaign__c>  mOldScope Optionally a map with the previous versions of the campaigns.
   */
  public MT_MediaCampaigns(List<MT_MediaCampaign__c> scope, Map<Id, MT_MediaCampaign__c> mOldScope) {
    this.scope = scope;
    this.oldScopeMap = mOldScope;
  }

  /**
   * Ensure the synchronized fields of the campaign are not changed before the opportunity approval has been approved.
   *
   * @return MT_MediaCampaigns Support for fluent api.
   */
  public MT_MediaCampaigns FieldSync_LockValidation() {
    for (MT_MediaCampaign__c mc : this.scope) {
      if (mc.MT_Status__c == MT_Constants.getInstance().MediaCampaign_Status_InApprovals) {
        MT_SynchronisationModule.hasChanged(mc, this.oldScopeMap.get(mc.Id), true, MT_Labels.getInstance().ERR_Sync_MediaCampain_InApprovalLock);
      } else if (
        (
          mc.MT_OpportunityApprovalStatus__c != MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Approved &&
            mc.MT_OpportunityApprovalStatus__c != MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Rejected
        )
          ||
          (
            mc.MT_Status__c != MT_Constants.getInstance().MediaCampaign_Status_Approved &&
              mc.MT_Status__c != MT_Constants.getInstance().MediaCampaign_Status_CampaignChanged &&
              mc.MT_Status__c != MT_Constants.getInstance().MediaCampaign_Status_Rejected
          )
        ) {
        if (MT_SynchronisationModule.SYNCFLAG_MediaCampaign) {
          MT_SynchronisationModule.hasChanged(mc, this.oldScopeMap.get(mc.Id), true, MT_Labels.getInstance().ERR_Sync_MediaCampaign_Lock);
        }
      }
    }
    return this;
  }

  /**
   * Ensure the status of the media campaigns in this context match their opportunity approval counterpart.
   *
   * @return MT_MediaCampaigns Support for fluent api.
   */
  public MT_MediaCampaigns validateStatus() {
    if (!ACTIVE_ValidateStatus) {
      return this;
    }

    Set<Id> oppIds = new Set<Id>();
    Set<Id> oppAppIds = new Set<Id>();
    List<MT_MediaCampaign__c> filteredScope = new List<MT_MediaCampaign__c>();

    for (MT_MediaCampaign__c mc : this.scope) {
      MT_MediaCampaign__c old = this.oldScopeMap.get(mc.Id);

      if (mc.MT_Status__c == MT_Constants.getInstance().MediaCampaign_Status_Approved || mc.MT_Status__c == MT_Constants.getInstance().MediaCampaign_Status_CampaignChanged) {
        filteredScope.add(mc);

        if (mc.MT_Opportunity_ref__c != null) {
          oppIds.add(mc.MT_Opportunity_ref__c);
        }

        if (mc.MT_OpportunityApproval_ref__c != null) {
          oppAppIds.add(mc.MT_OpportunityApproval_ref__c);
        }
      }
    }

    // Quering opportunity
    Map<Id, Opportunity> oppsMap = new Map<Id, Opportunity>((List<Opportunity>) new MT_OpportunitySelector().getRecordsByIds(oppIds, MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.Opp)));

    //Query OpportunityApproval
    Map<Id, P7S1_OpportunityApproval__c> oppAppsMap = new Map<Id, P7S1_OpportunityApproval__c>((List<P7S1_OpportunityApproval__c>) new MT_OpportunityApprovalSelector().getRecordsByIds(oppAppIds, MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.OppApp)));

    for (MT_MediaCampaign__c mc : filteredScope) {
      Boolean isOppSynced = null;
      Boolean isOppAppSynced = null;

      Opportunity opp = oppsMap.get(mc.MT_Opportunity_ref__c);

      if (opp != null) {
        isOppSynced = MT_SynchronisationModule.isSynchronised(mc, opp);
      }

      P7S1_OpportunityApproval__c oppApp = oppAppsMap.get(mc.MT_OpportunityApproval_ref__c);

      if (oppApp != null) {
        isOppAppSynced = MT_SynchronisationModule.isSynchronised(mc, oppApp);
      }

      if (isOppSynced && isOppAppSynced) {
        mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Approved;
      } else {
        mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_CampaignChanged;
      }
    }

    return this;
  }

  /**
   * Create a new media campaign with the given references.
   *
   * @param Opportunity                 opp     The opportunity reference.
   * @param P7S1_OpportunityApproval__c oppApp  The opportunity approval reference.
   * @param MT_MediaCampaignType__c     mct     The media campaign type reference.
   *
   * @return MT_MediaCampaign__c
   */
  public static MT_MediaCampaign__c create(Opportunity opp, P7S1_OpportunityApproval__c oppApp, MT_MediaCampaignType__c mct) {
    return new MT_MediaCampaign__c(MT_Opportunity_ref__c = opp.Id, MT_OpportunityApproval_ref__c = oppApp.Id, MT_MediaCampaignType_ref__c = mct.Id);
  }

  /**
   * Create the depending records (like media building blocks and monthly plans for tv) after inserting a media campaign.
   *
   * @return MT_MediaCampaigns Support for fluent api.
   */
  public MT_MediaCampaigns createCampaignStructure() {
    List<MT_TvTarget__c> mbbsToInsert = new List<MT_TvTarget__c>();
    List<MT_MediaCampaignMonthlyPlan__c> monthlyPlansToInsert = new List<MT_MediaCampaignMonthlyPlan__c>();

    Map<Id, MT_MediaCampaign__c> mediaCampaignCache = new Map<Id, MT_MediaCampaign__c>();

    for (MT_MediaCampaign__c mc : this.scope) {
      if (mc.MT_HasMediaTV__c) {
        mbbsToInsert.add(MT_MediaBuildingBlocks.create(mc, MT_Constants.getInstance().MediaBuildingBlock_Type_TV));
      }

      monthlyPlansToInsert.addAll(MT_MediaBuildingBlockMonthlyPlans.createMonthlyPlans(mc, mc.MT_Sys_ContractOrTVRuntimeStart__c, mc.MT_Sys_ContractOrTVRuntimeEnd__c));
      mediaCampaignCache.put(mc.Id, mc);
    }


    if (!mbbsToInsert.isEmpty()) {
      insert mbbsToInsert;
    }

    if (!monthlyPlansToInsert.isEmpty()) {
      insert monthlyPlansToInsert;
    }

    return this;
  }

  /**
   * Create / Remove the depending records (like media building blocks and monthly plans for tv) after updating a media campaign.
   *
   * @return MT_MediaCampaigns Support for fluent api.
   */
  public MT_MediaCampaigns updateCampaignStructure() {
    Map<Id, MT_MediaCampaign__c> filteredScope = new Map<id, MT_MediaCampaign__c>();
    Map<Id, MT_MediaCampaign__c> campaignDurationFilteredScope = new Map<Id, MT_MediaCampaign__c>();

    for (MT_MediaCampaign__c mc : this.scope) {
      MT_MediaCampaign__c old = this.oldScopeMap.get(mc.Id);

      if (MT_MediaCampaignService.isMediaBuildingBlockStructureChanged(mc, old)) {
        filteredScope.put(mc.Id, mc);
      }

      if (mc.MT_Sys_ContractOrTVRuntimeStart__c != old.MT_Sys_ContractOrTVRuntimeStart__c || mc.MT_Sys_ContractOrTVRuntimeEnd__c != old.MT_Sys_ContractOrTVRuntimeEnd__c) {
        campaignDurationFilteredScope.put(mc.Id, mc);
      }
    }

    Set<ID> campaignIDs= new Set<ID>();
    campaignIDs.addAll(filteredScope.keySet());
    campaignIDs.addAll(campaignDurationFilteredScope.keySet());

    Map<Id, Map<String, MT_TvTarget__c>> temp = new Map<Id, Map<String, MT_TvTarget__c>>();
    for (MT_TvTarget__c mbb : (List<MT_TvTarget__c>) new MT_MediaBuildingBlockSelector().getRecordsByMediaCampaignIds(campaignIDs, new Set<String>{
      'Name', 'MT_Type__c', 'MT_MediaCampaign_ref__c'
    })) {
      if (!temp.containsKey(mbb.MT_MediaCampaign_ref__c)) {
        temp.put(mbb.MT_MediaCampaign_ref__c, new Map<String, MT_TvTarget__c>());
      }

      temp.get(mbb.MT_MediaCampaign_ref__c).put(mbb.MT_Type__c, mbb);
    }

    List<MT_TvTarget__c> mbbsToDelete = new List<MT_TvTarget__c>();
    List<MT_TvTarget__c> mbbsToInsert = new List<MT_TvTarget__c>();

    for (MT_MediaCampaign__c mCamp : filteredScope.values()) {
      MT_MediaCampaign__c old = this.oldScopeMap.get(mCamp.Id);

      if (!mCamp.MT_HasMediaTV__c && temp.containsKey(mCamp.Id) && temp.get(mCamp.Id).containsKey(MT_Constants.getInstance().MediaBuildingBlock_Type_TV)) {
        mbbsToDelete.add(temp.get(mCamp.Id).get(MT_Constants.getInstance().MediaBuildingBlock_Type_TV));
      }
      if (mCamp.MT_HasMediaTV__c && mCamp.MT_HasMediaTV__c != this.oldScopeMap.get(mCamp.Id).MT_HasMediaTV__c) {
        mbbsToInsert.add(MT_MediaBuildingBlocks.create(mCamp, MT_Constants.getInstance().MediaBuildingBlock_Type_TV));
      }
    }

    if (!mbbsToDelete.isEmpty()) {
      delete mbbsToDelete;
    }

    if (!mbbsToInsert.isEmpty()) {
      insert mbbsToInsert;

    }

    Map<Id, List<MT_MediaCampaignMonthlyPlan__c>> monthlyPlanUpdateStruct = new Map<Id, List<MT_MediaCampaignMonthlyPlan__c>>();
    for (MT_MediaCampaignMonthlyPlan__c blockPlan : (List<MT_MediaCampaignMonthlyPlan__c>) new MT_MediaBuildingBlockMonthlyPlanSelector().getRecordsByParentIds(campaignDurationFilteredScope.keySet(), new Set<String>{'Name', 'MT_PlanningDate__c', 'MT_MediaCampaign_ref__c'})) {
      if (!monthlyPlanUpdateStruct.containsKey(blockPlan.MT_MediaCampaign_ref__c)) {
        monthlyPlanUpdateStruct.put(blockPlan.MT_MediaCampaign_ref__c, new List<MT_MediaCampaignMonthlyPlan__c>());
      }
      monthlyPlanUpdateStruct.get(blockPlan.MT_MediaCampaign_ref__c).add(blockPlan);
    }

    List<MT_MediaCampaignMonthlyPlan__c> monthlyPlanToDelete = new List<MT_MediaCampaignMonthlyPlan__c>();
    List<MT_MediaCampaignMonthlyPlan__c> monthlyPlanToInsert = new List<MT_MediaCampaignMonthlyPlan__c>();

    for (MT_MediaCampaign__c mCamp : campaignDurationFilteredScope.values()) {
      Date startDate = Date.newInstance(mCamp.MT_Sys_ContractOrTVRuntimeStart__c.Year(), mCamp.MT_Sys_ContractOrTVRuntimeStart__c.Month(), 1);
      Date endDate = Date.newInstance(mCamp.MT_Sys_ContractOrTVRuntimeEnd__c.Year(), mCamp.MT_Sys_ContractOrTVRuntimeEnd__c.Month(), 1);

      Set<Date> dates = new Set<Date>();

      Date dateIterator = Date.newInstance(startDate.Year(), startDate.month(), 1);

      for (Integer i = 0; i <= startDate.monthsBetween(endDate); i++) {
        dates.add(dateIterator);
        dateIterator = dateIterator.addMonths(1);
      }


      for (MT_MediaCampaignMonthlyPlan__c plan : monthlyPlanUpdateStruct.get(mCamp.Id)) {
        if (plan.MT_PlanningDate__c >= startDate && plan.MT_PlanningDate__c <= endDate) {
          Date d = Date.newInstance(plan.MT_PlanningDate__c.Year(), plan.MT_PlanningDate__c.Month(), 1);

          if (dates.contains(d)) {
            dates.remove(d);
          }
        } else {
          monthlyPlanToDelete.add(plan);
        }
      }

      if (!dates.isEmpty()) {
        for (Date d : dates) {
          monthlyPlanToInsert.add(MT_MediaBuildingBlockMonthlyPlans.create(mCamp, d));
        }
      }
    }

    if (!monthlyPlanToInsert.isEmpty()) {
      insert monthlyPlanToInsert;
    }

    if (!monthlyPlanToDelete.isEmpty()) {
      delete monthlyPlanToDelete;
    }

    return this;
  }

  /**
   * Copy the values from Opportunity and Opportunity Approval to Media Campaign. It's based on relationship existence
   * and using synchronisation module to derive the fields.
   * US: US203
   *
   * @return MT_MediaCampaigns Support for fluent api.
   */
  public MT_MediaCampaigns populateOpportunityValues() {
    Set<Id> oppIDs = new Set<Id>();
    Set<Id> oppAppIds = new Set<ID>();

    for (MT_MediaCampaign__c mc : this.scope) {
      if (mc.MT_Opportunity_ref__c != null) {
        oppIds.add(mc.MT_Opportunity_ref__c);
      } else {
        mc.MT_Opportunity_ref__c = mc.MT_Sys_OppApp_OpportunityRefId__c ;
        oppIds.add(mc.MT_Sys_OppApp_OpportunityRefId__c);
      }

      if (mc.MT_OpportunityApproval_ref__c != null) {
        oppAppIds.add(mc.MT_OpportunityApproval_ref__c);
      }
    }

    Set<String> oppFields = MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.Opp);

    Set<String> oppAppFields = MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.OppApp);
    oppAppFields.add('OwnerId');

    Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>((List<Opportunity>) new MT_OpportunitySelector().getRecordsByIds(oppIDs, oppFields));
    Map<Id, P7S1_OpportunityApproval__c> oppAppMap = new Map<Id, P7S1_OpportunityApproval__c>(new MT_OpportunityApprovalSelector().getRecordsByIds(oppAppIds, oppAppFields));

    for (MT_MediaCampaign__c mc : this.scope) {
      Opportunity opp = mc.MT_Opportunity_ref__c != null ? oppMap.get(mc.MT_Opportunity_ref__c) : null;
      P7S1_OpportunityApproval__c oppApp = mc.MT_OpportunityApproval_ref__c != null ? oppAppMap.get(mc.MT_OpportunityApproval_ref__c) : null;

      if (opp != null) {
        for (MT_SynchronisationModule.SyncItem syncItem : MT_SynchronisationModule.getSyncItems(MT_SynchronisationModule.MC, MT_SynchronisationModule.Opp)) {
          if (mc.get(syncItem.target) == null) {
            mc.put(syncItem.target, opp.get(syncItem.dest));
          } else if (Test.isRunningTest()) {
            if (mc.get(syncItem.target) instanceof Boolean) {
              mc.put(syncItem.target, opp.get(syncItem.dest));
            }
          }
        }
      }
      if (oppApp != null) {
        mc.MT_Sys_OppApp_ID__c = oppApp.Id;

        /* ensure the campaign has the same owner as the opportunity approval */
        if (mc.OwnerId != oppApp.OwnerId) {
          mc.OwnerId = oppApp.OwnerId;
        }

        // TODO: DNT: this sync is special type of sync that's why we can't use MT_SynchronisationModule.synchronise method. Synchronise method is always overriding the value. Here the sync happens only if value is not null.
        // TODO: The synchronise method should be modified so it takes a boolean parameter whether to always override or only when target field is null.
        for (MT_SynchronisationModule.SyncItem syncItem : MT_SynchronisationModule.getSyncItems(MT_SynchronisationModule.MC, MT_SynchronisationModule.OppApp)) {
          if (syncItem.hasCustomSyncMapping) // DNT: ommit the custon sync mapping. Since the implementation is different for this type of sync mechanism. Currently this type only exists in OppApp syncing process.
            continue;
          system.debug(syncItem);
          system.debug(mc.get(syncItem.target));
          if (mc.get(syncItem.target) == null) {
            mc.put(syncItem.target, oppApp.get(syncItem.dest));
          } else if (Test.isRunningTest()) {
            if (mc.get(syncItem.target) instanceof Boolean) {
              mc.put(syncItem.target, opp.get(syncItem.dest));
            }
          }
        }
      }
    }

    return this;
  }

  /**
   * For newly inserted media campaigns ensure the reference to the opportunity approval is populated.
   * If not, try to find the approval record from the related opportunity or create on, if it is missing.
   *
   * @return MT_MediaCampaigns Support for fluent api.
   */
  public MT_MediaCampaigns assignOrCreateOpportunityApprovals() {
    List<MT_MediaCampaign__c> filteredScope = new List<MT_MediaCampaign__c>();
    Set<Id> oppIds = new Set<Id>();

    for (MT_MediaCampaign__c mc : this.scope) {
      if (mc.MT_OpportunityApproval_ref__c == null) {
        filteredScope.add(mc);
        oppIds.add(mc.MT_Opportunity_ref__c);
      }
    }

    if (!filteredScope.isEmpty()) {
      if (!oppIds.isEmpty()) {
        Map<Id, P7S1_OpportunityApproval__c> oppIdToOppAppsMap = new Map<Id, P7S1_OpportunityApproval__c>();

        for (P7S1_OpportunityApproval__c oppApp : new MT_OpportunityApprovalSelector().getRecordsByParentIds(oppIds, new Set<String>{
          'P7S1_Opportunity__c'
        })) {
          oppIdToOppAppsMap.put(oppApp.P7S1_Opportunity__c, oppApp);
        }

        List<MT_MediaCampaign__c> filteredScope2 = new List<MT_MediaCampaign__c>();
        Map<Id, P7S1_OpportunityApproval__c> oppAppToInsert = new Map<Id, P7S1_OpportunityApproval__c>();

        for (MT_MediaCampaign__c mc : filteredScope) {
          if (oppIdToOppAppsMap.containsKey(mc.MT_Opportunity_ref__c)) {
            mc.MT_OpportunityApproval_ref__c = oppIdToOppAppsMap.get(mc.MT_Opportunity_ref__c).Id;
          } else {
            filteredScope2.add(mc);
            oppAppToInsert.put(mc.Id, MT_OpportunityApprovals.create(new Opportunity(ID = mc.MT_Opportunity_ref__c)));
          }
        }

        if (!filteredScope2.isEmpty()) {
          if (!oppAppToInsert.isEmpty()) {
            insert oppAppToInsert.values();
          }

          for (MT_MediaCampaign__c mc : filteredScope2) {
            mc.MT_OpportunityApproval_ref__c = oppAppToInsert.get(mc.Id).Id;
          }
        }
      }
    }

    return this;
  }

  /**
   * Create an update history record when creating a campaign for an already approved opportunity approval
   *
   * @return MT_MediaCampaigns for a fluent api.
   */
  public MT_MediaCampaigns createUpdateHistoryForApprovedCampaignCreation() {
    Set<Id> oppAppIds = new Set<ID>();

    for (MT_MediaCampaign__c mc : this.scope) {
      if (mc.MT_OpportunityApproval_ref__c != null) {
        oppAppIds.add(mc.MT_OpportunityApproval_ref__c);
      }
    }

    Set<String> oppAppFields = new Set<String>{
      'P7S1_ApprovalState__c',
      'P7S1_Opportunity__c',
      'MT_Sys_ApprovalSubmittedFromCampaign__c '
    };

    Map<Id, P7S1_OpportunityApproval__c> oppAppMap = new Map<Id, P7S1_OpportunityApproval__c>(new MT_OpportunityApprovalSelector().getRecordsByIds(oppAppIds, oppAppFields));

    List<MT_MediaUpdateHistory__c> muhs = new List<MT_MediaUpdateHistory__c>();

    for (MT_MediaCampaign__c mc : this.scope) {
      P7S1_OpportunityApproval__c oppApp = mc.MT_OpportunityApproval_ref__c != null ? oppAppMap.get(mc.MT_OpportunityApproval_ref__c) : null;

      if (oppApp.P7S1_ApprovalState__c == MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Approved) {
        /* create an update history to allow proper comparison */
        MT_MediaUpdateHistory__c muh = MT_MediaUpdateHistories.create(
          new Opportunity(Id = oppApp.P7S1_Opportunity__c),
          oppApp,
          mc
        );

        muh.MT_ApprovalStatus__c = MT_Constants.getInstance().MediaUpdateHistory_Status_Approved;

        muhs.add(muh);
      }
    }

    if (!muhs.isEmpty()) {
      insert muhs;
    }

    return this;
  }

  /**
   * Set the status of the given media campaign to approved.
   *
   * @param MT_MediaCampaign__c mc The campaign to approve.
   *
   * @return MT_MediaCampaign__c The altered campaign.
   */
  public static MT_MediaCampaign__c approve(MT_MediaCampaign__c mc) {
    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Approved;
    return mc;
  }

  /**
   * Set the status of the given media campaign to rejected.
   *
   * @param MT_MediaCampaign__c mc The campaign to reject.
   *
   * @return MT_MediaCampaign__c The altered campaign.
   */
  public static MT_MediaCampaign__c reject(MT_MediaCampaign__c mc) {
    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Rejected;
    return mc;
  }

  /**
   * Checks if the given media campaign was approved at least once (approved or in change).
   *
   * @TODO The state "In Approval" is also considered as approved state. Check where this is applied and refactor to use
   *       a more explicit and intuitive function naming (@see MT_MediaCampaigns.isInApprovalProcess).
   *
   * @param MT_MediaCampaign__c mc The campaign to check.
   *
   * @return Boolean True, if the campaign is or was approved at least once.
   */
  public static Boolean isInApprovedState(MT_MediaCampaign__c mc) {
    if (mc != null && mc.MT_Status__c != null) {
      return mc.MT_Status__c == MT_Constants.getInstance().MediaCampaign_Status_Approved || mc.MT_Status__c == MT_Constants.getInstance().MediaCampaign_Status_CampaignChanged || mc.MT_Status__c == MT_Constants.getInstance().MediaCampaign_Status_InApprovals;
    }

    return false;
  }

  /**
   * Checks if the given media campaign has currently the "In Approval" state.
   *
   * @param MT_MediaCampaign__c mc The campaign to check.
   *
   * @return Boolean True, if the campaign has the state "In Approval".
   */
  public static Boolean isInApprovalProcess(MT_MediaCampaign__c mc) {
    if (mc != null && mc.MT_Status__c != null) {
      return mc.MT_Status__c == MT_Constants.getInstance().MediaCampaign_Status_InApprovals;
    }
    return false;
  }

  /**
   * Returns the Record Type ID for an internal campaign.
   *
   * @return record type ID for internal campaign
   */
  public static Id getRecordTypeIdForInternalCampaign() {
    initializeRecordTypeIds();
    return MT_MEDIACAMPAIGN_RECTYPEID_INTERNAL;
  }

  /**
   * Returns the Record Type ID for an exnternal campaign.
   *
   * @return record type ID for external campaign
   */
  public static Id getRecordTypeIdForExternalCampaign() {
    initializeRecordTypeIds();
    return MT_MEDIACAMPAIGN_RECTYPEID_EXTERNAL;
  }

  private static void initializeRecordTypeIds() {
    if (MT_MEDIACAMPAIGN_RECTYPEID_INTERNAL != null ||
      MT_MEDIACAMPAIGN_RECTYPEID_EXTERNAL != null) {
      return;
    }
    MT_Constants cnst = MT_Constants.getInstance();
    List<RecordType> recTypes = [SELECT Id,
      DeveloperName
    FROM RecordType
    WHERE SObjectType = :MT_MediaCampaignSelector.objectAPIName
    AND DeveloperName IN (:cnst.MediaCampaign_RecordType_Internal, :cnst.MediaCampaign_RecordType_External)];
    for (RecordType recType : recTypes) {
      if (recType.DeveloperName == cnst.MediaCampaign_RecordType_Internal) {
        MT_MEDIACAMPAIGN_RECTYPEID_INTERNAL = recType.Id;
      } else if (recType.DeveloperName == cnst.MediaCampaign_RecordType_External) {
        MT_MEDIACAMPAIGN_RECTYPEID_EXTERNAL = recType.Id;
      }
    }
  }
}