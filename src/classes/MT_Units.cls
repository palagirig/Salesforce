/************************************************************************************************************
Name:  		MT_Units
======================================================
Purpose: 	Domain class for P7S1_Unit__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
08.03.2017	Falco Aulitzky	            Initial architecture & development
*************************************************************************************************************/

public with sharing class MT_Units {
  private List<P7S1_Unit__c> scope;

  public MT_Units(List<P7S1_Unit__c> scope) {
    this.scope = scope;
  }

  public static P7S1_Unit__c create(String segment, String name) {
    return new P7S1_Unit__c(
      P7S1_Segment__c = segment,
      Name = name);
  }

  public class MT_UnitsException extends Exception {
  }
}