public with sharing Class MT_OpptyFreig_MCampApprovalHandler {

  public static boolean submitOpptyFreigabeApprovals(Map<Id, String>OppRecIdsToSubmit) {

    boolean isSuccess = false;

    set<Id> uniqueApprovalIds = new set<Id>();

    List<Approval.ProcessSubmitRequest> requests = new List<Approval.ProcessSubmitRequest>();

    for (Id oppId: OppRecIdsToSubmit.keyset()) {

      Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
      req1.setComments('Submitting Opportunity Freigabe request change for approvals');
      req1.setObjectId(oppId);
      req1.setProcessDefinitionNameOrId('MT_Media_Board_Approvals');
      req1.setSubmitterId(OppRecIdsToSubmit.get(oppId));
      requests.add(req1);
    }

    Approval.ProcessResult[] processResults = null;
    Approval.ProcessResult result = null;
    try {
      processResults = Approval.process(requests, true);
      isSuccess = true;

    } catch (System.DmlException e) {
      System.debug('Exception Is ' + e.getMessage());
    }
    return isSuccess;
  }
}