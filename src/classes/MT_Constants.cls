/**
 * Constants store for Media Trasperancy App.
 *
 * History
 * -------
 * Date       AUTHOR            DETAIL
 * 17.11.2016 Duc Nguyen Tien   Initial architecture & development
 * 18.04.2017 Sven Kretschmann  Code documentation
 **/
public class MT_Constants {
  private static MT_Constants instance = null;

  /**
   * Private constructor to prevent multiple instances of this class in one runtime context.
   */
  private MT_Constants() {
  }

  /**
   * Fetch the one and only instance of this class (initialize if required).
   *
   * @return MT_Constants The singleton instance.
   */
  public static MT_Constants getInstance() {
    if (instance == null) {
      instance = new MT_Constants();
    }

    return instance;
  }

  /**
   * Ensure all members are initialized prior to serialization. This is required for JSON encoding this instance for the
   * remoteAction config api.
   *
   * @see MT_ConfigController.getConstants()
   *
   * @return MT_Constants Support for fluent api.
   */
  public MT_Constants prepareForSerialization() {
    String cont;
    cont = Media_Flight_RecordType_Sponsoring;
    cont = Media_Flight_RecordType_Spot;
    return this;
  }

  public String Media_Flight_RecordType_Spot { set; get {if (Media_Flight_RecordType_Spot == null) Media_Flight_RecordType_Spot = 'Spot'; return Media_Flight_RecordType_Spot;} }
  public String Media_Flight_RecordType_Sponsoring { set; get {if (Media_Flight_RecordType_Sponsoring == null) Media_Flight_RecordType_Sponsoring = 'Sponsoring'; return Media_Flight_RecordType_Sponsoring;} }

  public String MediaBuildingBlock_Type_DooH = 'DooH';
  public String MediaBuildingBlock_Type_TV = 'TV';
  public String MediaBuildingBlock_Type_Digital = 'Digital';

  public String Opportunity_Status_ENG = 'Closed and lost';
  public String Opportunity_Status_GER = 'Geschlossen und verloren';

  public String OpportunityApproval_ApprovalStatus_Approved = 'Genehmigt'; // Currently only used in backend
  public String OpportunityApproval_ApprovalStatus_Rejected = 'Abgelehnt'; // Currently only used in backend
  public String OpportunityApproval_ApprovalStatus_Submitted = 'Eingereicht';

  public String OpportunityApproval_ApprovalProcess_ExternalCampaignChanged = 'MT_OppApp_ChangeExternalApproval';
  public String OpportunityApproval_ApprovalProcess_InternalCampaignChanged = 'MT_OppApp_ChangeInternalApproval';

  public String MediaUpdateHistory_Status_Approved = 'Approved'; // Currently only used in backend
  public String MediaUpdateHistory_Status_Rejected = 'Rejected'; // Currently only used in backend
  public String MediaUpdateHistory_Status_Submitted = 'Submitted'; // Currently only used in backend

  public String MediaCampaign_Status_Approved = 'Campaign approved';
  public String MediaCampaign_Status_Rejected = 'Cancelled';
  public String MediaCampaign_Status_Draft = 'Draft';
  public String MediaCampaign_Status_CampaignChanged = 'Campaign changed';
  public String MediaCampaign_Status_InApprovals = 'In Approvals';

  public String MediaCampaign_Approval_Comment = 'Submitting request for approval.';

  public String MediaCampaign_RecordType_Internal = 'MT_InternalMediaCampaign';
  public String MediaCampaign_RecordType_External = 'MT_ExternalMediaCampaign';

  public String MediaMotive_Type_Main = 'Main';
  public String MediaMotive_Type_Reminder = 'Reminder';

  public String MediaCampaign_External_Prefix = 'MT_External';
  public String MediaCampaign_Internal_Prefix = 'MT_Internal';

  public String MediaCampaignType_External = 'External';
  public String MediaCampaignType_Internal = 'Internal';

  public String YieldConsiderationPeriods_0Months = '0 Monate';
  public String YieldConsiderationPeriods_3Months = '3 Monate';
  public String YieldConsiderationPeriods_6Months = '6 Monate';
  public String YieldConsiderationPeriods_12Months = '12 Monate';
  public String YieldConsiderationPeriods_Runtime = 'Gesamtlaufzeit';
}