/**
 * Handles the quick creation process for a media campaign, based on an opportunity approval
 */
public with sharing class MT_CreateMediaCampaignController {
  private final P7S1_OpportunityApproval__c oppApp;
  private final ApexPages.StandardController stdController;

  public MT_MediaCampaign__c campaign { get; set; }
  public List<MT_MediaCampaignType__c> campaignTypes { get; set; }
  public Boolean isExternalCampaign { get; set; }
  public Boolean isInternalCampaign { get; set; }

  public Boolean hasError { get; set; }
  public String errorMessage { get; set; }
  public String proceedTarget { get; set; }

  /**
   * Initialize this controller extension.
   */
  public MT_CreateMediaCampaignController(ApexPages.StandardController stdContr) {
    this.stdController = stdContr;

    Set<String> oppAppFields = MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.OppApp);
    oppAppFields.add('OwnerId');
    oppAppFields.add('P7S1_Opportunity__c');
    oppAppFields.add('P7S1_ApprovalState__c');
    oppAppFields.add('RecordTypeId');
    oppAppFields.add('RecordType.Name');
    oppAppFields.add('MT_Asset_ref__c');
    oppAppFields.add('P7S1_internerPartner__c');

    this.oppApp = (P7S1_OpportunityApproval__c) (new MT_OpportunityApprovalSelector()).getRecordsByIds(new Set<Id>{
      this.stdController.getId()
    }, oppAppFields).get(0);
  }

  /**
   * Prepare the campaign for the opportunity approval. If it already exists, jump directly to it.
   */
  public PageReference prepareCampaign() {
    if (this.oppApp == null) {
      this.setErrorMessage(MT_Labels.getInstance().ERR_MediaCampaign_No_OppApp);
      return null;
    }

    List<MT_MediaCampaign__c> existingCampaigns = [SELECT Id FROM MT_MediaCampaign__c WHERE MT_OpportunityApproval_ref__c = :this.oppApp.Id LIMIT 1];

    if (!existingCampaigns.isEmpty()) {
      this.proceedTarget = new ApexPages.StandardController(existingCampaigns[0]).view().getUrl();
      return null;
    }

    if (this.oppApp.RecordTypeId == null) {
      this.setErrorMessage(MT_Labels.getInstance().ERR_MediaCampaign_No_OppAppRecordTypeId);
      return null;
    }

    Map<String, Id> campaignCategoryTypes = getCategoryIds(MT_MediaCampaign__c.sObjectType.getDescribe().getName());
    Map<String, Id> oppAppCategoryTypes = getCategoryIds(P7S1_OpportunityApproval__c.sObjectType.getDescribe().getName());

    this.isExternalCampaign = this.oppApp.RecordTypeId == oppAppCategoryTypes.get('external');
    this.isInternalCampaign = this.oppApp.RecordTypeId == oppAppCategoryTypes.get('internal');

    if (!this.isExternalCampaign && !this.isInternalCampaign) {
      this.setErrorMessage(MT_Labels.getInstance().ERR_MediaCampaign_No_OppAppRecordTypeIdAllowed + ' (' + this.oppApp.RecordType.Name + ')');
      return null;
    }

    MT_Constants constants = MT_Constants.getInstance();

    if (oppApp.MT_Asset_ref__c != null) {
      this.campaignTypes = [SELECT ID, Name FROM MT_MediaCampaignType__c WHERE MT_IsActive__c = true AND MT_Type__c = :(this.isExternalCampaign ? constants.MediaCampaignType_External : constants.MediaCampaignType_Internal) AND MT_Asset_ref__c = :oppApp.MT_Asset_ref__c];
    } else {
      this.campaignTypes = [SELECT ID, Name FROM MT_MediaCampaignType__c WHERE MT_IsActive__c = true AND MT_Type__c = :(this.isExternalCampaign ? constants.MediaCampaignType_External : constants.MediaCampaignType_Internal) AND MT_Asset_ref__r.Name = :oppApp.P7S1_internerPartner__c];
    }

    this.campaign = new MT_MediaCampaign__c(
      RecordTypeId = this.isExternalCampaign ? campaignCategoryTypes.get('external') : campaignCategoryTypes.get('internal'),
      MT_Opportunity_ref__c = this.oppApp.P7S1_Opportunity__c,
      MT_OpportunityApproval_ref__c = this.oppApp.Id
    );

    MT_SynchronisationModule.synchronise(this.campaign, this.oppApp);

    Set<String> oppFields = MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.Opp);
    Opportunity opp = (Opportunity) (new MT_OpportunitySelector()).getRecordsByIds(new Set<Id>{
      this.oppApp.P7S1_Opportunity__c
    }, oppFields).get(0);

    MT_SynchronisationModule.synchronise(this.campaign, opp);

    return null;
  }

  /**
   * Store the campaign and redirect to it.
   */
  public PageReference createCampaign() {
    try {
      insert this.campaign;
    } catch (Exception e) {
      this.setErrorMessage(e.getMessage());
      return null;
    }

    ApexPages.StandardController ctrl = new ApexPages.StandardController(this.campaign);
    this.proceedTarget = ctrl.view().getUrl();
    return null;
  }

  /**
   * Return the record type ids for the given object, mapping them to external and internal campaigns.
   */
  private static Map<String, Id> getCategoryIds(String obj) {
    MT_Constants constants = MT_Constants.getInstance();

    List<RecordType> rts = [SELECT Id, DeveloperName FROM RecordType WHERE SobjectType = :obj];

    Map<String, Id> result = new Map<String, Id>();

    for (RecordType rt : rts) {
      if (rt.DeveloperName.startsWith(constants.MediaCampaign_External_Prefix)) {
        if (result.containsKey('external')) {
          throw new MT_CreateMediaCampaignControllerException('The object ' + obj + ' contains multiple records types indicating an external campaign.');
        }

        result.put('external', rt.Id);
      } else if (rt.DeveloperName.startsWith(constants.MediaCampaign_Internal_Prefix)) {
        if (result.containsKey('internal')) {
          throw new MT_CreateMediaCampaignControllerException('The object ' + obj + ' contains multiple records types indicating an internal campaign.');
        }

        result.put('internal', rt.Id);
      }
    }

    if (result.size() != 2) {
      throw new MT_CreateMediaCampaignControllerException('The object ' + obj + ' does not contain exactly two record types for internal and external campaigns or these categories could not be mapped.');
    }

    return result;
  }

  private void setErrorMessage(String message) {
    this.hasError = true;
    this.errorMessage = message;

    if (this.oppApp == null) {
      PageReference proceedTo = new PageReference('/' + P7S1_OpportunityApproval__c.sObjectType.getDescribe().getKeyPrefix());
      this.proceedTarget = proceedTo.getUrl();
    } else {
      this.proceedTarget = '#close';
    }

  }

  /**
   * Used to indicate errors while processing.
   */
  public class MT_CreateMediaCampaignControllerException extends Exception {
  }
}