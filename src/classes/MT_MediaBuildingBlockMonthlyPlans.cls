/************************************************************************************************************
Name:       MT_MediaBuildingBlockMonthlyPlans
======================================================
Purpose:    Domain class for MT_MediaBuildingBlockMonthlyPlan__c object
======================================================
History
-------
Date        AUTHOR                      DETAIL
07.12.2016  Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaBuildingBlockMonthlyPlans {
  private List<MT_MediaCampaignMonthlyPlan__c> scope;

  public MT_MediaBuildingBlockMonthlyPlans(List<MT_MediaCampaignMonthlyPlan__c> scope) {
    this.scope = scope;
  }

  public static List<MT_MediaCampaignMonthlyPlan__c> createMonthlyPlans(MT_MediaCampaign__c mc, Date startDate, Date endDate) {
    List<MT_MediaCampaignMonthlyPlan__c> ret = new List<MT_MediaCampaignMonthlyPlan__c>();

    Date iteratorDate = Date.newInstance(startDate.year(), startDate.month(), 1);
    Date cacheEnd = Date.newInstance(endDate.year(), endDate.month(), 1);

    while (iteratorDate <= cacheEnd) {
      system.debug('iteratorDate: ' + iteratorDate + ' cacheEnd: ' + cacheEnd);

      ret.add(MT_MediaBuildingBlockMonthlyPlans.create(mc, iteratorDate));
      iteratorDate = iteratorDate.addMonths(1);
    }
    return ret;
  }
  public static MT_MediaCampaignMonthlyPlan__c create(MT_MediaCampaign__c mc, Date planningDate) {
    return new MT_MediaCampaignMonthlyPlan__c(
      MT_MediaCampaign_ref__c = mc.Id,
      MT_PlanningDate__c = planningDate
    );

  }
}