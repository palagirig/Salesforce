/**
 * Batch that transform the imported campaign data from KRS
 * to Media Transparency campaigns in MT_Campaign__c.
 *
 * Note: This class is without sharing as it has to see
 * all data.
 *
 * @author Fabio Andree Scheurel (MaibornWolff GmbH)
 */

public without sharing class MT_CampaignImportDataTransformator implements Database.Batchable<sObject> {


  public Database.QueryLocator start(Database.BatchableContext bc) {
    FieldSet batchFields = SObjectType.MT_CampaignImportData__c.FieldSets.MT_TransformationBatchFields;
    return new MT_CampaignImportDataSelector().queryLocatorForAll(MT_FieldSet.getFields(batchFields));
  }


  public void execute(Database.BatchableContext bc, List<MT_CampaignImportData__c> scope) {
    try {
      doExecute(scope);
    } catch (Exception e) {
      System.debug(LoggingLevel.ERROR, e);
      //loggedErrors.add('Eine Ausnahme ist aufgetreten:\n' + e.getMessage());
      throw e;
    }
  }


  public void finish(Database.BatchableContext info) {
  }


  /**
   * Actual execution of imported data, will transform
   * the data and perform and upsert into the database.
   * The <code>importData</code> will be purged from
   * the database afterwards.
   *
   * Errors will be silently ignored!
   *
   * @param importData list of imported campaigns
   */
  private void doExecute(List<MT_CampaignImportData__c> importData) {
    Map<String,MT_MediaCampaign__c> campaignMap = getCampaignMapForReferencedCampaigns(importData);

    Map<Id,List<MT_MediaCampaign__c>> opptyIdToNewCampaignsMap = new Map<Id,List<MT_MediaCampaign__c>>();
    for (MT_CampaignImportData__c importDataRec : importData) {
      if (importDataRec.MT_CampaignId__c != null) {
        String krsId = String.valueOf(Integer.valueOf(importDataRec.MT_CampaignId__c));
        MT_MediaCampaign__c campaign = campaignMap.get(krsId);
        if (campaign == null) {
          campaign = MT_MediaCampaigns.create(
            new Opportunity(Id = importDataRec.MT_OpportunitySalesforceId__c),
            new P7S1_OpportunityApproval__c(),
            new MT_MediaCampaignType__c());
          campaign.MT_KRSID__c = krsId;
          campaign.RecordTypeId = MT_MediaCampaigns.getRecordTypeIdForExternalCampaign();
          campaign.MT_BmvTv__c = 1; // FIXME fill with import value once received from KRS with MT-679
          campaignMap.put(krsId, campaign);
          if (!opptyIdToNewCampaignsMap.containsKey(importDataRec.MT_OpportunitySalesforceId__c)) {
            opptyIdToNewCampaignsMap.put(importDataRec.MT_OpportunitySalesforceId__c, new List<MT_MediaCampaign__c>());
          }
          opptyIdToNewCampaignsMap.get(importDataRec.MT_OpportunitySalesforceId__c).add(campaign);
        }
        updateCampaign(campaign, importDataRec);
      }
    }


    enrichNewCampaignsWithOpportunityApprovalReference(opptyIdToNewCampaignsMap);

    System.debug(LoggingLevel.DEBUG, '### Transforming ' + importData.size() + ' imported records into media transparency campaigns.');
    List<Database.UpsertResult> results = Database.upsert(campaignMap.values(), false);
    System.debug(LoggingLevel.DEBUG, JSON.serializePretty(results));

    delete importData;
  }


  /**
   * Retrieves a map of the existing campaigns from the database,
   * identified by the KRS ID.
   *
   * @param importData imported campaign records
   * @return Map of KRS ID to Campaign
   */
  private Map<String,MT_MediaCampaign__c> getCampaignMapForReferencedCampaigns(List<MT_CampaignImportData__c> importData) {
    Set<String> krsIds = new Set<String>();
    for (MT_CampaignImportData__c importDataRec : importData) {
      if (importDataRec.MT_CampaignId__c != null) {
        krsIds.add(String.valueOf(Integer.valueOf(importDataRec.MT_CampaignId__c)));
      }
    }

    Map<String,MT_MediaCampaign__c> campaignMap = new Map<String,MT_MediaCampaign__c>();
    Set<String> mediaCampaignFields = new Set<String> {
      MT_MediaCampaign__c.Id.getDescribe().getName(),
      MT_MediaCampaign__c.Name.getDescribe().getName(),
      MT_MediaCampaign__c.MT_KRSID__c.getDescribe().getName(),
      MT_MediaCampaign__c.MT_Opportunity_ref__c.getDescribe().getName(),
      MT_MediaCampaign__c.MT_OpportunityApproval_ref__c.getDescribe().getName()
    };
    for (MT_MediaCampaign__c campaign : (List<MT_MediaCampaign__c>) new MT_MediaCampaignSelector().getRecordsByKrsIds(krsIds, mediaCampaignFields)) {
      campaignMap.put(campaign.MT_KRSId__c, campaign);
    }
    return campaignMap;
  }


  /**
   * Updates the <campaign> with the imported values from
   * <code>importCampaign</code>.
   *
   * @param campaign Campaign to updated
   * @param importCampaign values to use for update
   */
  private void updateCampaign(MT_MediaCampaign__c campaign, MT_CampaignImportData__c importCampaign) {
    campaign.Name = importCampaign.MT_CampaignName__c != null ? importCampaign.MT_CampaignName__c.left(MT_MediaCampaign__c.Name.getDescribe().getLength()) : null;
  }


  /**
   * Adds the Opportunity Approval reference (i.e. the ID) to
   * the provided Media Campaigns.
   * If the opportunity does not exist or does not have an
   * opportunity approval assigned, the campaign will not be
   * updated. If there are multiple approvals per opportunity
   * any of these will be taken.
   *
   * @param opptyIdToNewCampaignsMap Map of Opportunity ID to a
   * list of campaigns that are assigned to this opportunity
   */
  private void enrichNewCampaignsWithOpportunityApprovalReference(Map<Id,List<MT_MediaCampaign__c>> opptyIdToNewCampaignsMap) {
    Set<String> oppApprovalFields = new Set<String> {
      P7S1_OpportunityApproval__c.Id.getDescribe().getName(),
      P7S1_OpportunityApproval__c.P7S1_Opportunity__c.getDescribe().getName(),
      // BEGIN TEMPORARY WORKAROUND
      P7S1_OpportunityApproval__c.MT_Asset_ref__c.getDescribe().getName()
      // END TEMPORARY WORKAROUND
    };

    // BEGIN TEMPORARY WORKAROUND
    Set<Id> assetIds = new Set<Id>();
    // END TEMPORARY WORKAROUND
    for (P7S1_OpportunityApproval__c approval : new MT_OpportunityApprovalSelector().getRecordsByParentIds(opptyIdToNewCampaignsMap.keySet(), oppApprovalFields)) {
      if (opptyIdToNewCampaignsMap.containsKey(approval.P7S1_Opportunity__c)) {
        // BEGIN TEMPORARY WORKAROUND
        assetIds.add(approval.MT_Asset_ref__c);
        // END TEMPORARY WORKAROUND
        for (MT_MediaCampaign__c campaign : opptyIdToNewCampaignsMap.get(approval.P7S1_Opportunity__c)) {
          campaign.MT_OpportunityApproval_ref__c = approval.Id;
          campaign.MT_OpportunityApproval_ref__r = approval;
        }
      }
    }

    // BEGIN TEMPORARY WORKAROUND: Set campaign type based on opportunity approval until we get it from KRS
    Set<String> campaignTypeFields = new Set<String> {
      MT_MediaCampaignType__c.Id.getDescribe().getName(),
      MT_MediaCampaignType__c.MT_Type__c.getDescribe().getName(),
      MT_MediaCampaignType__c.MT_IsActive__c.getDescribe().getName(),
      MT_MediaCampaignType__c.MT_Asset_ref__c.getDescribe().getName()
    };
    Map<Id,Id> assetIdToMediaCampaignTypeIdMap = new Map<Id,Id>();
    for (MT_MediaCampaignType__c mct : (List<MT_MediaCampaignType__c>) new MT_MediaCampaignTypeSelector().getRecordsByAssetIds(assetIds, campaignTypeFields)) {
      if (mct.MT_Type__c == 'External' && mct.MT_IsActive__c == true) {
        assetIdToMediaCampaignTypeIdMap.put(mct.MT_Asset_ref__c, mct.Id);
      }
    }
    for (List<MT_MediaCampaign__c> campaigns : opptyIdToNewCampaignsMap.values()) {
      for (MT_MediaCampaign__c campaign : campaigns) {
        campaign.MT_MediaCampaignType_ref__c = assetIdToMediaCampaignTypeIdMap.get(campaign.MT_OpportunityApproval_ref__r.MT_Asset_ref__c);
      }
    }
    // END TEMPRORARY WORKAROUND
  }
}