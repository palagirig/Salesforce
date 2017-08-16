/************************************************************************************************************
Name:  		MT_MediaMotives
======================================================
Purpose: 	Domain class for MT_MediaMotive__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
17.02.2017	Falco Aulitzky	            Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaMotives {
  private List<MT_MediaMotive__c> scope;

  public MT_MediaMotives(List<MT_MediaMotive__c> scope) {
    this.scope = scope;
  }

  public static MT_MediaMotive__c create(MT_AdvertisedMediaProduct__c product, String name) {
    return new MT_MediaMotive__c(
      MT_AdvertisedMediaProduct_ref__c = product.Id,
      Name = name);
  }

  public class MT_MediaMotivesException extends Exception {
  }
}