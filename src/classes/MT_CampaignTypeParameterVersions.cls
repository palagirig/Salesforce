/**
 * Domain class for CampaignTypeParameterVersion object
 *
 * History
 * -------
 * Date       AUTHOR            DETAIL
 * 04.05.2017 Falco Aulitzky    Initial architecture & development
 **/
public with sharing class MT_CampaignTypeParameterVersions {
  private List<MT_CampaignTypeParameterVersion__c> scope;

  public MT_CampaignTypeParameterVersions(List<MT_CampaignTypeParameterVersion__c> scope) {
    this.scope = scope;
  }

  public static MT_CampaignTypeParameterVersion__c create(MT_MediaCampaignType__c camType, Date validFrom) {
    return new MT_CampaignTypeParameterVersion__c(
      MT_MediaCampaignType_ref__c = camType.Id,
      MT_ValidFrom__c = validFrom);
  }

  public class MT_CampaignTypeParameterVersionsException extends Exception {
  }
}