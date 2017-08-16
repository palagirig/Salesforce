/**
 * Domain class for Opportunity object
 *
 * History
 * -------
 * Date		    AUTHOR						DETAIL
 * 17.11.2016	Duc Nguyen Tien   Initial architecture & development
 * 18.04.2017 Sven Kretschmann  Code documentation
 * 10.05.2017 Falco Aulitzky    New Method "SetCampaignStatusAccordingly"
 **/
public class MT_Opportunities {
  private List<Opportunity> scope;
  private Map<Id, Opportunity> oldScopeMap;

  /**
   * Initialize this handler with a scope (expecting a trigger context with new / updated opportunities and optionally
   * a map with the old versions).
   *
   * @param List<Opportunity>   scope       The affected opportunities to manage.
   * @param Map<Id, Opportunit> oldScopeMap Optionally a map with the previous versions of the opportunities.
   */
  public MT_Opportunities(List<Opportunity> scope, Map<Id, Opportunity> oldScopeMap) {
    this.scope = scope;
    this.oldScopeMap = oldScopeMap;
  }

  /**
   * Ensure the synchronized fields of the opportunity are not changed after it has been approved.
   *
   * @return MT_Opportunities Support for fluent api.
   */
  public MT_Opportunities FieldSync_LockValidation() {
    Map<Id, Opportunity> filteredScope = new Map<Id, Opportunity>();

    for (Opportunity opp : this.scope) {
      Opportunity oldOpp = this.oldScopeMap.get(opp.Id);

      if (MT_SynchronisationModule.hasChanged(opp, oldOpp, false, null)) {
        filteredScope.put(opp.Id, opp);
      }
    }

    if (!filteredScope.isEmpty()) {
      Map<Id, MT_MediaCampaign__c> mCampMap = new Map<Id, MT_MediaCampaign__c>();

      for (MT_MediaCampaign__c mc : (List<MT_MediaCampaign__c>) new MT_MediaCampaignSelector().getRecordsByOpportunityIds(filteredScope.keySet(), new Set<String>{
        'Name', 'MT_Status__c', 'MT_Opportunity_ref__c'
      })) {
        if (mCampMap.containsKey(mc.MT_Opportunity_ref__c)) {
          String err = MT_Labels.getInstance().ERR_Sync_MultipleChildCampaignValidation.replace('@Object', 'Opportunity').replace('@name', mc.Name);
          filteredScope.get(mc.MT_Opportunity_ref__c).addError(err);
        } else {
          mCampMap.put(mc.MT_Opportunity_ref__c, mc);
        }
      }

      for (Opportunity opp : filteredScope.values()) {
        if (mCampMap.containsKey(opp.Id)) {
          if (MT_MediaCampaigns.isInApprovedState(mCampMap.get(opp.Id))) {
            MT_SynchronisationModule.hasChanged(opp, this.oldScopeMap.get(opp.Id), true, MT_Labels.getInstance().ERR_Sync_Opportunity_Lock);
          }

          if (MT_MediaCampaigns.isInApprovalProcess(mCampMap.get(opp.Id))) {
            MT_SynchronisationModule.hasChanged(opp, this.oldScopeMap.get(opp.Id), true, MT_Labels.getInstance().ERR_Sync_MediaCampain_InApprovalLock);
          }
        }
      }
    }

    return this;
  }

  public MT_Opportunities SetCampaignStatusAccordingly() {
    Map<Id, Opportunity> filteredScope = new Map<Id, Opportunity>();
    List<MT_MediaCampaign__c> mcToUpdate = new List<MT_MediaCampaign__c>();
    for (Opportunity opp : this.scope) {
      if (opp.StageName == MT_Constants.getInstance().Opportunity_Status_ENG || opp.StageName == MT_Constants.getInstance().Opportunity_Status_GER) {
        filteredScope.put(opp.Id, opp);
      }
    }

    Set<string> mcFields = new Set<String>{
      'MT_Opportunity_ref__c', 'MT_Status__c'
    };

    for (MT_MediaCampaign__c mc : (List<MT_MediaCampaign__c>) new MT_MediaCampaignSelector().getRecordsByOpportunityIds(filteredScope.keySet(), mcFields)) {
      mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Rejected;
      mcToUpdate.add(mc);
    }

    if (!mcToUpdate.isEmpty()) {
      update mcToUpdate;
    }

    return this;
  }

  /**
   * Synchronize the updated opportunities with its media campaigns.
   *
   * @return MT_Opportunities Support for fluent api.
   */
  public MT_Opportunities FieldSync_SyncFields() {
    if (MT_SynchronisationModule.SYNCFLAG_Opportunity) {
      Map<Id, Opportunity> filteredScope = new Map<Id, Opportunity>();

      for (Opportunity opp : this.scope) {
        Opportunity oldOpp = this.oldScopeMap.get(opp.Id);

        if (MT_SynchronisationModule.hasChanged(opp, this.oldScopeMap.get(opp.Id), false, null)) {
          filteredScope.put(opp.Id, opp);
        }
      }

      if (!filteredScope.isEmpty()) {
        List<MT_MediaCampaign__c> mcToUpdate = new List<MT_MediaCampaign__c>();
        Map<Id, MT_MediaCampaign__c> mCampMap = new Map<Id, MT_MediaCampaign__c>();
        Set<string> mcFields = new Set<String>{
          'MT_Opportunity_ref__c', 'Name'
        };
        mcFields.addAll(MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC));

        for (MT_MediaCampaign__c mc : (List<MT_MediaCampaign__c>) new MT_MediaCampaignSelector().getRecordsByOpportunityIds(filteredScope.keySet(), mcFields)) {
          if (mCampMap.containsKey(mc.MT_Opportunity_ref__c)) {
            String err = MT_Labels.getInstance().ERR_Sync_MultipleChildCampaignValidation.replace('@Object', 'Opportunity').replace('@name', mc.Name);
            filteredScope.get(mc.MT_Opportunity_ref__c).addError(err);
          } else {
            mCampMap.put(mc.MT_Opportunity_ref__c, mc);
          }
        }

        for (Opportunity opp : filteredScope.values()) {
          if (mCampMap.containsKey(opp.Id)) {
            MT_MediaCampaign__c mc = mCampMap.get(opp.Id);

            if (MT_SynchronisationModule.synchronise(mc, opp)) {
              mcToUpdate.add(mc);
            }
          }
        }

        MT_SynchronisationModule.SYNCFLAG_MediaCampaign = false;

        if (!mcToUpdate.isEmpty()) {
          update mcToUpdate;
        }
      }
    }

    return this;
  }
}