/************************************************************************************************************
Name:  		MT_MediaUpdateHistorySelector
======================================================
Purpose: 	Selector class for MT_MediaUpdateHistory__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
05.12.2016	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaUpdateHistorySelector extends MT_Selector {
  public static final String objectAPIName = MT_MediaUpdateHistory__c.SobjectType.getDescribe().getName();
  public List<MT_MediaUpdateHistory__c> getApprovedRecordsByOpportunityApprovalRefId(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_OpportunityApproval_ref__c in ' + constructInClauseString(recordIds) + ' and MT_ApprovalStatus__c =\'' + MT_Constants.getInstance().MediaUpdateHistory_Status_Approved + '\' order by CreatedDate desc';
    system.debug(query);
    return Database.query(query);
  }
  public List<MT_MediaUpdateHistory__c> getSubmittedRecordsByOpportunityApprovalRefId(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where MT_OpportunityApproval_ref__c in ' + constructInClauseString(recordIds) + ' and MT_ApprovalStatus__c =\'' + MT_Constants.getInstance().MediaUpdateHistory_Status_Submitted + '\' order by CreatedDate desc';
    system.debug(query);
    return Database.query(query);
  }
}