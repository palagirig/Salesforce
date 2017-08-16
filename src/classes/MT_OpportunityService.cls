/************************************************************************************************************
Name:  		MT_OpportunityService
======================================================
Purpose: 	Service class for Opportunity object
======================================================
History
-------
Date		AUTHOR						DETAIL
12.12.2016	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
global class MT_OpportunityService {
  global static List<Opportunity> getRecordsByIds(Set<ID> oppIds, Set<String> fields) {
    return new MT_OpportunitySelector().getRecordsByIds(oppIds, fields);
  }
}