global class MT_ApprovalProcessModule {
  webservice static String startApprovalProcess(String strOppAppId, String strCampId) {
    MT_Constants constants = MT_Constants.getInstance();

    ID oppAppId = strOppAppId;
    ID campId = strCampId;

    P7S1_OpportunityApproval__c oppApp = (P7S1_OpportunityApproval__c) (new MT_OpportunityApprovalSelector()).getRecordsByIds(new Set<Id>{
      strOppAppId
    }, new Set<String>{
      'P7S1_ApprovalState__c', 'MT_Sys_ApprovalSubmittedFromCampaign__c'
    }).get(0);

    MT_MediaCampaign__c mc;

    Approval.ProcessSubmitRequest psr = new Approval.ProcessSubmitRequest();
    psr.setComments(constants.MediaCampaign_Approval_Comment);
    psr.setSubmitterId(UserInfo.getUserId());
    psr.setObjectId(oppAppId);

    if (oppApp.P7S1_ApprovalState__c == constants.OpportunityApproval_ApprovalStatus_Approved) {
      oppApp.MT_Sys_ApprovalSubmittedFromCampaign__c = true;
      update oppApp;

      mc = (MT_MediaCampaign__c) (new MT_MediaCampaignSelector()).getRecordsByIds(new Set<Id>{
        strCampId
      }, new Set<String>{
        'RecordType.DeveloperName', 'MT_Responsible_IM_Agent__c'
      }).get(0);

      if (mc.RecordType.DeveloperName == constants.MediaCampaign_RecordType_Internal) {
        if (mc.MT_Responsible_IM_Agent__c != null) {
          psr.setNextApproverIds(new List<Id>{
            mc.MT_Responsible_IM_Agent__c
          });

          psr.setProcessDefinitionNameOrId(constants.OpportunityApproval_ApprovalProcess_InternalCampaignChanged);
        }
      } else {
        psr.setProcessDefinitionNameOrId(constants.OpportunityApproval_ApprovalProcess_ExternalCampaignChanged);
      }

      if (String.isBlank(psr.getProcessDefinitionNameOrId())) {
        return MT_Labels.getInstance().MSG_ApprovalModule_EntryFailure;
      }
    }

    Approval.ProcessResult result;
    try {
      result = Approval.process(psr);
    } catch (DmlException e) {
      return MT_Labels.getInstance().MSG_ApprovalModule_Failure.replace('@error', e.getMessage());
    }

    if (result.isSuccess()) {
      if (mc != null) {
        mc.MT_Status__c = constants.MediaCampaign_Status_InApprovals;
        update mc;
      }

      if (oppApp.MT_Sys_ApprovalSubmittedFromCampaign__c) {
        oppApp.MT_Sys_ApprovalSubmittedFromCampaign__c = false;
        update oppApp;
      }

      return MT_Labels.getInstance().MSG_ApprovalModule_Success;
    } else {
      String errors = '';

      for (Database.Error error : result.getErrors()) {
        if (!String.isBlank(errors)) {
          errors += '; ';
        }

        errors += error.getMessage();
      }

      return MT_Labels.getInstance().MSG_ApprovalModule_Failure.replace('@error', errors);
    }
  }
}