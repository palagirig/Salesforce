/**
 * Domain class for MT_CampaignImportData object.
 *
 * @author Fabio Andree Scheurel (MaibornWolff GmbH)
 */
public with sharing class MT_CampaignImportData {

  /**
   * Create a new record with the provided external keys
   * and internal references.
   *
   * @param krsId ID of KRS campaign
   * @param opportunityId Salesforce ID of opportunity that the
   * record is related to
   * @return new record
   */
  public static MT_CampaignImportData__c create(Integer krsId, Id opportunityId) {
    return new MT_CampaignImportData__c(MT_CampaignId__c = krsId, MT_OpportunitySalesforceId__c = opportunityId);
  }
}