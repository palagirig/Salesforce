/**
 * Selector class for P7S1_OpportunityApproval__c object
 *
 * History
 * -------
 * Date       AUTHOR            DETAIL
 * 05.12.2016 Duc Nguyen Tien   Initial architecture & development
 * 20.04.2017 Falco Aulitzky    Code documentation
 **/

public with sharing class MT_OpportunityApprovalSelector extends MT_Selector {
  public static final String objectAPIName = P7S1_OpportunityApproval__c.SobjectType.getDescribe().getName();

  /*
  * Methode that queries fields of a given object from the database and provides them to the system
  *
  * @param    Set<Id> recordIds ids of OpportunityApproval objects
  *           List<String> fields that shall be queried from the OpportunityApproval object
  * @returns  List<P7S1_OpportunityApproval__c> list of OpportunityApproval objects
  *
  */
  public List<P7S1_OpportunityApproval__c> getRecordsByIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where Id in ' + constructInClauseString(recordIds);
    return Database.query(query);
  }

  /*
  * Methode that queries fields of a given object from the database and provides them to the system
  *
  * @param    Set<Id> recordIds ids of Opportunity objects
  *           List<String> fields that shall be queried from the OpportunityApproval object
  * @returns  List<P7S1_OpportunityApproval__c> list of OpportunityApproval objects
  *
  */
  public List<P7S1_OpportunityApproval__c> getRecordsByParentIds(Set<Id> recordIds, Set<String> fields) {
    if (recordIds.isEmpty())
      return new List<SObject>();
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + objectAPIName + ' where P7S1_Opportunity__c in ' + constructInClauseString(recordIds);
    return Database.query(query);
  }
}