/************************************************************************************************************
Name:     MT_ProSaOrderService
======================================================
Purpose:  Service class for MT_ProSaOrder__c object
======================================================
History
-------
Date        AUTHOR            DETAIL
???         ???               Initial architecture & development
15.03.2017  Falco Aulitzky    Align to other Services
*************************************************************************************************************/
global with sharing class MT_ProSaOrderService {
  private static Set<String> contextFields;

  global static List<MT_ProSaOrder__c> getProSaOrdersByMediaCampaignIds(Set<ID> campIds) {
    if (campIds.isEmpty()) {
      return new List<MT_ProSaOrder__c>();
    }

    return new MT_ProSaOrderSelector().getRecordsByMediaCampaignIds(
      campIds,
      MT_ProSaOrderService.getContextFields()
    );
  }

  global static List<MT_ProSaOrder__c> getProSaOrdersByMediaCampaignIds(Set<ID> campIds, Set<String> fields) {
    if (campIds.isEmpty()) {
      return new List<MT_ProSaOrder__c>();
    }

    return new MT_ProSaOrderSelector().getRecordsByMediaCampaignIds(
      campIds,
      fields
    );
  }

  private static Set<String> getContextFields() {
    if (contextFields == null) {
      contextFields = MT_FieldSet.getFields(SObjectType.MT_ProSaOrder__c.FieldSets.MT_ContextFields);
    }

    return contextFields;
  }
}