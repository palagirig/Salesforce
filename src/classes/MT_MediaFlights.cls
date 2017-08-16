/************************************************************************************************************
Name:      MT_MediaFlights
======================================================
Purpose:   Domain class for MT_MediaFlight__c object
======================================================
History
-------
Date    AUTHOR            DETAIL
16.03.2017  Falco Aulitzky              Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaFlights {
  private List<MT_MediaFlight__c> scope;

  public MT_MediaFlights(List<MT_MediaFlight__c> scope) {
    this.scope = scope;
  }

  public static MT_MediaFlight__c create(Date startDate, Date endDate, MT_MediaCampaignMonthlyPlan__c buildingBlock) {
    return new MT_MediaFlight__c(
      MT_StartDate__c = startDate,
      MT_EndDate__c = endDate,
      MT_MediaBuildingBlockMonthlyPlan_ref__c = buildingBlock.Id
    );
  }

  public class MT_MediaFlightsException extends Exception {
  }
}