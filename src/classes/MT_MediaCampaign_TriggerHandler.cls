public class MT_MediaCampaign_TriggerHandler extends TriggerController {

  public MT_MediaCampaign_TriggerHandler(Boolean isAfter, Boolean isBefore, Boolean isDelete, Boolean isInsert, Boolean isUndelete, Boolean isUpdate,
    List<sObject> lstNewItems, Map<Id, sObject> mapNewItems, List<sObject> lstOldItems, Map<Id, sObject> mapOldItems) {
    super(isAfter, isBefore, isDelete, isInsert, isUndelete, isUpdate, lstNewItems, mapNewItems, lstOldItems, mapOldItems);
  }

  public override void runBeforeInsert() {
    new MT_MediaCampaigns((list<MT_MediaCampaign__c>) lstNewItems)
      .assignOrCreateOpportunityApprovals()
      .populateOpportunityValues();
  }

  public override void runAfterInsert() {
    new MT_MediaCampaigns((list<MT_MediaCampaign__c>) lstNewItems)
      .createCampaignStructure()
      .createUpdateHistoryForApprovedCampaignCreation();
  }

  public override void runAfterUpdate() {
    new MT_MediaCampaigns((list<MT_MediaCampaign__c>) lstNewItems, (Map<Id, MT_MediaCampaign__c>) mapOldItems)
      .updateCampaignStructure();
  }

  public override void runBeforeUpdate() {
    new MT_MediaCampaigns((list<MT_MediaCampaign__c>) lstNewItems, (Map<Id, MT_MediaCampaign__c>) mapOldItems)
      .FieldSync_LockValidation()
      .validateStatus();
  }
}