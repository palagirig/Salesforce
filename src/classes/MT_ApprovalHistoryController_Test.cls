@isTest
private class MT_ApprovalHistoryController_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  testmethod static void constructor() {
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    Test.startTest();

    oppApp.P7S1_ApprovalState__c = MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Submitted;
    update oppApp;

    oppApp.P7S1_ApprovalState__c = MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Approved;
    update oppApp;

    MT_MediaCampaign__c mc = [Select ID, MT_RunTimeTVEnd__c from MT_MediaCampaign__c limit 1];

    mc.MT_RunTimeTVEnd__c = mc.MT_RunTimeTVEnd__c.addMonths(2);
    update mc;
    system.debug('Approval Process Module start');
    MT_ApprovalProcessModule.startApprovalProcess(oppApp.Id, mc.Id);

    MT_ApprovalHistoryController ctrl = new MT_ApprovalHistoryController(new ApexPages.StandardController(oppApp));

    Test.stopTest();
  }
}