@isTest
private class MT_MediaCampaigns_Test {

  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_MediaCampaigns cls = new MT_MediaCampaigns(new List<MT_MediaCampaign__c>());
    MT_MediaCampaigns cls2 = new MT_MediaCampaigns(new List<MT_MediaCampaign__c>(), new Map<Id, MT_MediaCampaign__c>());
    Test.stopTest();
  }

  @isTest static void approve() {
    Test.startTest();
    MT_MediaCampaign__c mc = MT_MediaCampaigns.approve(new MT_MediaCampaign__c());
    system.assertEquals(MT_Constants.getInstance().MediaCampaign_Status_Approved, mc.MT_Status__c);
    Test.stopTest();
  }

  @isTest static void reject() {
    Test.startTest();
    MT_MediaCampaign__c mc = MT_MediaCampaigns.reject(new MT_MediaCampaign__c());
    system.assertEquals(MT_Constants.getInstance().MediaCampaign_Status_Rejected, mc.MT_Status__c);
    Test.stopTest();
  }

  @isTest static void isInApprovedState() {
    Test.startTest();
    MT_MediaCampaign__c mc = new MT_MediaCampaign__c();

    Schema.DescribeFieldResult fieldResult = MT_MediaCampaign__c.MT_Status__c.getDescribe();
    List<Schema.PicklistEntry> ples = fieldResult.getPicklistValues();

    for (Schema.PicklistEntry ple : ples) {
      mc.MT_Status__c = ple.getValue();
      if (ple.getValue() == MT_Constants.getInstance().MediaCampaign_Status_Approved
        || ple.getValue() == MT_Constants.getInstance().MediaCampaign_Status_CampaignChanged
        || ple.getValue() == MT_Constants.getInstance().MediaCampaign_Status_InApprovals
        ) {
        system.assertEquals(true, MT_MediaCampaigns.isInApprovedState(mc));
      } else {
        system.assertEquals(false, MT_MediaCampaigns.isInApprovedState(mc));
      }
    }
    Test.stopTest();
  }

  @isTest static void isInApprovalProcess() {
    Test.startTest();
    MT_MediaCampaign__c mc = new MT_MediaCampaign__c();

    Schema.DescribeFieldResult fieldResult = MT_MediaCampaign__c.MT_Status__c.getDescribe();
    List<Schema.PicklistEntry> ples = fieldResult.getPicklistValues();

    for (Schema.PicklistEntry ple : ples) {
      mc.MT_Status__c = ple.getValue();
      if (ple.getValue() == MT_Constants.getInstance().MediaCampaign_Status_InApprovals) {
        system.assertEquals(true, MT_MediaCampaigns.isInApprovalProcess(mc));
      } else {
        system.assertEquals(false, MT_MediaCampaigns.isInApprovalProcess(mc));
      }
    }
    Test.stopTest();
  }

  @isTest static void FieldSync_LockValidation() {
    if (!MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC).contains('MT_RunTimeTVStart__c')) {
      system.assert(false, 'The tested field of MC is not in Synchronisation Module. Test method will not test the code properly!');
    }
    if (!MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC).contains('MT_RunTimeTVEnd__c')) {
      system.assert(false, 'The tested field of MC is not in Synchronisation Module. Test method will not test the code properly!');
    }

    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    Test.startTest();

    MT_MediaCampaign__c mc = [SELECT Id, MT_RunTimeTVStart__c, MT_RunTimeTVEnd__c, MT_Status__c FROM MT_MediaCampaign__c LIMIT 1];

    List<MT_MediaCampaign__c> newList = new List<MT_MediaCampaign__c>{
      mc
    };

    MT_MediaCampaign__c oldMC = mc.clone(true, true, true, true);

    Map<Id, MT_MediaCampaign__c> oldMap = new Map<Id, MT_MediaCampaign__c>{
      mc.Id => oldMC
    };

    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_InApprovals;
    mc.MT_RunTimeTVStart__c = Date.today().addMonths(-3);
    mc.MT_RunTimeTVEnd__c = Date.today().addMonths(8);
    MT_MediaCampaigns mcDomain = new MT_MediaCampaigns(newList, oldMap);

    try {
      mcDomain.FieldSync_LockValidation();
      System.assert(false, 'Field sync lock should have triggered an error.');
    } catch (Exception e) {
      Boolean containsError = e.getMessage().contains(MT_Labels.getInstance().ERR_Sync_MediaCampain_InApprovalLock);
      System.Assert(containsError, 'Error should be thrown but was not');
    }
    Test.stopTest();
  }

  @isTest static void testFieldSyncLockValidationForRejectedCampaign() {
    if (!MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC).contains('MT_RunTimeTVStart__c')) {
      system.assert(false, 'The tested field of MC is not in Synchronisation Module. Test method will not test the code properly!');
    }
    if (!MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC).contains('MT_RunTimeTVEnd__c')) {
      system.assert(false, 'The tested field of MC is not in Synchronisation Module. Test method will not test the code properly!');
    }

    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    oppApp.P7S1_ApprovalState__c = MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Rejected;
    update oppApp;

    Test.startTest();

    MT_MediaCampaign__c mc = [SELECT Id, MT_RunTimeTVStart__c, MT_RunTimeTVEnd__c, MT_Status__c FROM MT_MediaCampaign__c LIMIT 1];

    List<MT_MediaCampaign__c> newList = new List<MT_MediaCampaign__c>{
      mc
    };

    MT_MediaCampaign__c oldMC = mc.clone(true, true, true, true);

    Map<Id, MT_MediaCampaign__c> oldMap = new Map<Id, MT_MediaCampaign__c>{
      mc.Id => oldMC
    };

    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Draft;
    mc.MT_RunTimeTVStart__c = Date.today().addMonths(-5);
    mc.MT_RunTimeTVEnd__c = Date.today().addMonths(8);

    MT_MediaCampaigns mcDomain = new MT_MediaCampaigns(newList, oldMap);

    try {
      mcDomain.FieldSync_LockValidation();
      System.assert(false, 'Field sync lock should have triggered an error.');
    } catch (Exception e) {
      Boolean containsError = e.getMessage().contains(MT_Labels.getInstance().ERR_Sync_MediaCampaign_Lock);
      System.assert(containsError, 'Error should be thrown but was not');
    }
    Test.stopTest();
  }

  @isTest static void assignOrCreateOpportunityApprovals_Case1() {
    //Testing the case where OppApp is not assigned explicitly, but Opp has OppApp assigned to it.
    Test.startTest();
    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    P7S1_OpportunityApproval__c oppApp = [Select ID, P7S1_BmvTv__c from P7S1_OpportunityApproval__c where P7S1_Opportunity__c = :opp.Id limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, oppApp);

    MT_MediaCampaign__c assertMC = [Select ID, MT_OpportunityApproval_ref__c from MT_MediaCampaign__c];

    system.assertNotEquals(null, assertMC.MT_OpportunityApproval_ref__c, 'Opp App was not assigned');

    Test.stopTest();
  }

  @isTest static void assignOrCreateOpportunityApprovals_Case2() {
    //Testing the case where OppApp is not assigned explicitly and Opp has no OppApp assigned to it.
    Test.startTest();
    Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];

    system.assertNotEquals(null, opp, 'Could not find proper opp for testing');

    MT_MediaCampaign__c assertMC = [Select ID, MT_OpportunityApproval_ref__c from MT_MediaCampaign__c];

    system.assertNotEquals(null, assertMC.MT_OpportunityApproval_ref__c);
    Test.stopTest();
  }

  @isTest static void testGetTargetFieldsAndGetDestFields() {
    Test.startTest();
    Opportunity opp = [SELECT Id FROM Opportunity LIMIT 1];

    system.assertNotEquals(null, opp, 'Could not find proper opp for testing');

    MT_MediaCampaign__c assertMC = [Select ID, MT_OpportunityApproval_ref__c from MT_MediaCampaign__c];

    system.assertNotEquals(null, assertMC.MT_OpportunityApproval_ref__c);
    system.assertEquals(false, (MT_SynchronisationModule.getTargetFields(MT_SynchronisationModule.MC, MT_SynchronisationModule.Opp)).contains('MT_RunTimeTVEnd__c'));
    system.assertEquals(false, (MT_SynchronisationModule.getDestFields(MT_SynchronisationModule.Opp, MT_SynchronisationModule.MC)).contains('MT_RunTimeTVEnd__c'));

    Test.stopTest();
  }

  @isTest static void testAddErrorMethod() {
    if (!MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC).contains('MT_RunTimeTVStart__c')) {
      system.assert(false, 'The tested field of MC is not in Synchronisation Module. Test method will not test the code properly!');
    }
    if (!MT_SynchronisationModule.getSyncFields(MT_SynchronisationModule.MC).contains('MT_RunTimeTVEnd__c')) {
      system.assert(false, 'The tested field of MC is not in Synchronisation Module. Test method will not test the code properly!');
    }

    Opportunity opp = [Select Id from Opportunity limit 1]; // If no opp is returned it will throw an error. testSetup method must be adjusted
    P7S1_OpportunityApproval__c oppApp = [Select ID from P7S1_OpportunityApproval__c limit 1]; // If no oppApp is returned it will throw an error. testSetup method must be adjusted
    system.assertNotEquals(null, opp);
    system.assertNotEquals(null, oppApp);

    oppApp.P7S1_ApprovalState__c = MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Rejected;
    update oppApp;

    Test.startTest();

    MT_MediaCampaign__c mc = [Select ID, MT_OpportunityApproval_ref__c, MT_HasMediaDigital__c, MT_VariableRevenue1_RevenuePerUnit__c, MT_Status__c from MT_MediaCampaign__c];

    // changeing values
    List<MT_MediaCampaign__c> newList = new List<MT_MediaCampaign__c>{
      mc
    };

    MT_MediaCampaign__c oldMC = mc.clone(true, true, true, true);

    Map<Id, MT_MediaCampaign__c> oldMap = new Map<Id, MT_MediaCampaign__c>{
      mc.Id => oldMC
    };

    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Draft;
    mc.MT_HasMediaDigital__c = true;

    MT_MediaCampaigns mcDomain = new MT_MediaCampaigns(newList, oldMap);

    try {
      mcDomain.FieldSync_LockValidation();
      System.assert(false, 'Field sync lock should have triggered an error.');
    } catch (Exception e) {
      Boolean containsError = e.getMessage().contains(MT_Labels.getInstance().ERR_Sync_MediaCampaign_Lock);
      System.assert(containsError, 'Error should be thrown but was not');
    }

    // new value
    newList.clear();
    newList.add(mc);

    oldMC = mc.clone(true, true, true, true);

    oldMap.clear();
    oldMap.put(mc.Id, oldMC);

    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Draft;
    mc.MT_HasMediaDooH__c = true;

    mcDomain = new MT_MediaCampaigns(newList, oldMap);

    try {
      mcDomain.FieldSync_LockValidation();
      System.assert(false, 'Field sync lock should have triggered an error.');
    } catch (Exception e) {
      Boolean containsError = e.getMessage().contains(MT_Labels.getInstance().ERR_Sync_MediaCampaign_Lock);
      System.assert(containsError, 'Error should be thrown but was not');
    }

    // new value
    newList.clear();
    newList.add(mc);

    oldMC = mc.clone(true, true, true, true);

    oldMap.clear();
    oldMap.put(mc.Id, oldMC);

    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Draft;
    mc.MT_HasMediaTV__c = true;

    mcDomain = new MT_MediaCampaigns(newList, oldMap);

    try {
      mcDomain.FieldSync_LockValidation();
      System.assert(false, 'Field sync lock should have triggered an error.');
    } catch (Exception e) {
      Boolean containsError = e.getMessage().contains(MT_Labels.getInstance().ERR_Sync_MediaCampaign_Lock);
      System.assert(containsError, 'Error should be thrown but was not');
    }

    // new value
    newList.clear();
    newList.add(mc);

    oldMC = mc.clone(true, true, true, true);

    oldMap.clear();
    oldMap.put(mc.Id, oldMC);

    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Draft;
    mc.MT_BmvTv__c = 1000;

    mcDomain = new MT_MediaCampaigns(newList, oldMap);

    try {
      mcDomain.FieldSync_LockValidation();
      System.assert(false, 'Field sync lock should have triggered an error.');
    } catch (Exception e) {
      Boolean containsError = e.getMessage().contains(MT_Labels.getInstance().ERR_Sync_MediaCampaign_Lock);
      System.assert(containsError, 'Error should be thrown but was not');
    }

    // new value
    newList.clear();
    newList.add(mc);

    oldMC = mc.clone(true, true, true, true);

    oldMap.clear();
    oldMap.put(mc.Id, oldMC);

    mc.MT_Status__c = MT_Constants.getInstance().MediaCampaign_Status_Draft;
    mc.MT_VariableRevenue1_RevenuePerUnit__c = 1000;

    mcDomain = new MT_MediaCampaigns(newList, oldMap);

    try {
      mcDomain.FieldSync_LockValidation();
      System.assert(false, 'Field sync lock should have triggered an error.');
    } catch (Exception e) {
      Boolean containsError = e.getMessage().contains(MT_Labels.getInstance().ERR_Sync_MediaCampaign_Lock);
      System.assert(containsError, 'Error should be thrown but was not');
    }

    Test.stopTest();
  }

  @IsTest
  private static void testGetRecordTypeIdForInternalCampaign() {
    Test.startTest();
    Id recTypeId = MT_MediaCampaigns.getRecordTypeIdForInternalCampaign();
    Test.stopTest();

    System.assertNotEquals(null, recTypeId, 'Record type ID was not retrieved');
  }

  @IsTest
  private static void testGetRecordTypeIdForExternalCampaign() {
    Test.startTest();
    Id recTypeId = MT_MediaCampaigns.getRecordTypeIdForExternalCampaign();
    Test.stopTest();

    System.assertNotEquals(null, recTypeId, 'Record type ID was not retrieved');
  }
}