/*****************************************************************************
Name:      MT_MediaCampaignTypes
======================================================
Purpose:   Domain class for MT_MediaCampaignType__c object
======================================================
History
-------
Date        AUTHOR                      DETAIL
08.02.2017  Duc Nguyen Tien             Initial architecture & development
*****************************************************************************/

public with sharing class MT_MediaCampaignTypes {
  private List<MT_MediaCampaignType__c > scope;
  private Map<Id, MT_MediaCampaignType__c> oldScopeMap;

  public MT_MediaCampaignTypes(List<MT_MediaCampaignType__c> scope) {
    this.scope = scope;
  }
  public MT_MediaCampaignTypes(List<MT_MediaCampaignType__c> scope, Map<Id, MT_MediaCampaignType__c> mOldScope) {
    this.scope = scope;
    this.oldScopeMap = mOldScope;
  }
  public static MT_MediaCampaignType__c create(String name, Boolean isActive, P7S1_Asset__c asset) {
    return new MT_MediaCampaignType__c(Name = name, MT_Asset_ref__c = asset.Id, MT_IsActive__c = isActive);
  }

}