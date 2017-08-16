/************************************************************************************************************
Name:  		MT_Assets
======================================================
Purpose: 	Domain class for P7S1_Asset__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
08.03.2017	Falco Aulitzky	            Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_Assets {
  private List<P7S1_Asset__c> scope;

  public MT_Assets(List<P7S1_Asset__c> scope) {
    this.scope = scope;
  }

  public static P7S1_Asset__c create(P7S1_Unit__c unit, String name) {
    return new P7S1_Asset__c(
      P7S1_Unit__c = unit.Id,
      Name = name);
  }

  public class MT_AssetsException extends Exception {
  }
}