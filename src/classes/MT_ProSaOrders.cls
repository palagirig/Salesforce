/************************************************************************************************************
Name:  		MT_ProSaOrders
======================================================
Purpose: 	Domain class for MT_ProSaOrder__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
15.03.2017	Falco Aulitzky	            Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_ProSaOrders {
  private List<MT_ProSaOrder__c> scope;

  public MT_ProSaOrders(List<MT_ProSaOrder__c> scope) {
    this.scope = scope;
  }

  public static MT_ProSaOrder__c create(MT_MediaCampaign__c mediaCampaign, String orderNumber) {
    return new MT_ProSaOrder__c(
      MT_MediaCampaign_ref__c = mediaCampaign.Id,
      MT_OrderNumber__c = orderNumber);
  }

  public class MT_ProSaOrdersException extends Exception {
  }
}