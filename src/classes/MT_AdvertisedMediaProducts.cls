/************************************************************************************************************
Name:  		MT_AdvertisedMediaProducts
======================================================
Purpose: 	Domain class for MT_AdvertisedMediaProduct__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
16.02.2017	Falco Aulitzky	            Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_AdvertisedMediaProducts {
  private List<MT_AdvertisedMediaProduct__c> scope;

  public MT_AdvertisedMediaProducts(List<MT_AdvertisedMediaProduct__c> scope) {
    this.scope = scope;
  }

  public static MT_AdvertisedMediaProduct__c create(Account acc, String name, String productNumber) {
    return new MT_AdvertisedMediaProduct__c(
      MT_Account_ref__c = acc.id,
      Name = name,
      MT_ProductNumber__c = productNumber);
  }

  public class MT_AdvertisedMediaProductsException extends Exception {
  }
}