public with sharing class MT_ApprovalHistoryController {

  private final P7S1_OpportunityApproval__c oppApp;
  public MT_MediaUpdateHistory__c submitted { get; set; }
  public MT_MediaUpdateHistory__c approved { get; set; }

  public Boolean isSubmittedEmpty { get; set; }
  public Boolean isApprovedEmpty { get; set; }

  public List<String> oppFields { get; set; }
  public List<String> oppAppFields { get; set; }
  public List<String> campFields { get; set; }

  // The extension constructor initializes the private member
  // variable mysObject by using the getRecord method from the standard
  // controller.
  public MT_ApprovalHistoryController(ApexPages.StandardController stdController) {
    this.oppApp = (P7S1_OpportunityApproval__c) stdController.getRecord();

    Id oppAppId = this.oppApp.Id;

    this.oppFields = new List<String>(MT_SynchronisationModule.getTargetFields(MT_SynchronisationModule.MUH, MT_SynchronisationModule.Opp));
    this.oppAppFields = new List<String>(MT_SynchronisationModule.getTargetFields(MT_SynchronisationModule.MUH, MT_SynchronisationModule.OppApp));
    this.campFields = new List<String>(MT_SynchronisationModule.getTargetFields(MT_SynchronisationModule.MUH, MT_SynchronisationModule.MC));

    Set<String> muhQueryFields = new Set<String>();
    muhQueryFields.addAll(this.oppFields);
    muhQueryFields.addAll(this.oppAppFields);
    muhQueryFields.addAll(this.campFields);
    muhQueryFields.add('MT_ApprovalStatus__c');
    List<MT_MediaUpdateHistory__c> submittedList = new MT_MediaUpdateHistorySelector().getSubmittedRecordsByOpportunityApprovalRefId(new Set<ID>{
      oppAppId
    }, muhQueryFields);
    List<MT_MediaUpdateHistory__c> approvedList = new MT_MediaUpdateHistorySelector().getApprovedRecordsByOpportunityApprovalRefId(new Set<ID>{
      oppAppId
    }, muhQueryFields);
    system.debug(submittedList);
    system.debug(approvedList);
    this.isSubmittedEmpty = submittedList.isEmpty();
    this.isApprovedEmpty = approvedList.isEmpty();

    if (!this.isApprovedEmpty)
      this.approved = approvedList.get(0);
    if (!this.isSubmittedEmpty)
      this.submitted = submittedList.get(0);
    system.debug(submitted);
    system.debug(approved);
  }
}