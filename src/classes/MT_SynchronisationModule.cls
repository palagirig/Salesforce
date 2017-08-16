/**
 * Configure shared field maps between opportunity, opportunity approval, media campaign and media update history.
 * Compare or synchronize two records of each of these objects
 *
 * History
 * -------
 * Date        AUTHOR                      DETAIL
 *    12.2016  Duc Nguyen Tien             Initial architecture & development
 * 16.01.2017  Duc Nguyen Tien             Refactoring
 * 18.04.2017  Sven Kretschmann            Technical documentation
 */
public with sharing class MT_SynchronisationModule {
  public static boolean SYNCFLAG_Opportunity = true;
  public static boolean SYNCFLAG_MediaCampaign = true;
  public static boolean SYNCFLAG_OpportunityApproval = true;

  public static boolean ACTIVE_HASCHANGED_Opportunity = true;
  public static boolean ACTIVE_HASCHANGED_OpportunityApproval = true;
  public static boolean ACTIVE_HASCHANGED_MediaCampaign = true;

  public static string MediaCampaign_ContractStartDate = 'MT_ContractStartdate__c';
  public static string MediaCampaign_ContractEndDate = 'MT_ContractEnddate__c';
  public static string MediaCampaign_RuntimeTVStart = 'MT_RunTimeTVStart__c';
  public static string MediaCampaign_RuntimeTVEnd = 'MT_RunTimeTVEnd__c';
  public static string MediaCampaign_HasMediaDigital = 'MT_HasMediaDigital__c';
  public static string MediaCampaign_HasMediaDooH = 'MT_HasMediaDooH__c';
  public static string MediaCampaign_HasMediaTV = 'MT_HasMediaTV__c';
  public static string MediaCampaign_Status = 'MT_Status__c';
  public static string MediaCampaign_BmvTV = 'MT_BmvTv__c';
  public static string MediaCampaign_BmvDigital = 'MT_BmvDigital__c';
  public static string MediaCampaign_BmvDooH = 'MT_BMVDooH__c';
  public static string MediaCampaign_BmvTvCustomerIntegration = 'MT_BmvTvCustomerIntegration__c';
  public static string MediaCampaign_TvSpotLength = 'MT_TvSpotLength__c';
  public static string MediaCampaign_TvSpotLengthCustomer = 'MT_TvSpotLengthCustomer__c';
  public static string MediaCampaign_FixRevenueType = 'MT_FixRevenue_Type__c';
  public static string MediaCampaign_FixRevenueMonthlyPayment = 'MT_FixRevenue_MonthlyPayment__c';
  public static string MediaCampaign_Mn3TvCustomerIntegration = 'MT_Mn3TvCustomerIntegration__c';
  public static string MediaCampaign_FillUp = 'MT_FillUp__c';
  public static string MediaCampaign_GrossBarterVolume = 'MT_GrossBarterVolume__c';
  public static string MediaCampaign_NetBarterVolume = 'MT_NetBarterVolume__c';
  public static string MediaCampaign_ExitParticipation = 'MT_ExitParticipation__c';
  public static string MediaCampaign_EquityBookValue = 'MT_EigenerBuchwertinEUR__c';
  public static string MediaCampaign_CashPayment = 'MT_CashZahlung__c';
  public static string MediaCampaign_VariableRevenue1_RevenuePerUnit = 'MT_VariableRevenue1_RevenuePerUnit__c';
  public static string MediaCampaign_VariableRevenue2_RevenuePerUnit = 'MT_VariableRevenue2_RevenuePerUnit__c';
  public static string MediaCampaign_VariableRevenue3_RevenuePerUnit = 'MT_VariableRevenue3_RevenuePerUnit__c';
  public static string MediaCampaign_VariableRevenue4_RevenuePerUnit = 'MT_VariableRevenue4_RevenuePerUnit__c';
  public static string MediaCampaign_VariableRevenue5_RevenuePerUnit = 'MT_VariableRevenue5_RevenuePerUnit__c';
  public static string MediaCampaign_VariableRevenue1_SoldUnit = 'MT_VariableRevenue1_SoldUnit__c';
  public static string MediaCampaign_VariableRevenue2_SoldUnit = 'MT_VariableRevenue2_SoldUnit__c';
  public static string MediaCampaign_VariableRevenue3_SoldUnit = 'MT_VariableRevenue3_SoldUnit__c';
  public static string MediaCampaign_VariableRevenue4_SoldUnit = 'MT_VariableRevenue4_SoldUnit__c';
  public static string MediaCampaign_VariableRevenue5_SoldUnit = 'MT_VariableRevenue5_SoldUnit__c';
  public static string MediaCampaign_VariableRevenue1_SoldAmount = 'MT_VariableRevenue1_SoldAmount__c';
  public static string MediaCampaign_VariableRevenue2_SoldAmount = 'MT_VariableRevenue2_SoldAmount__c';
  public static string MediaCampaign_VariableRevenue3_SoldAmount = 'MT_VariableRevenue3_SoldAmount__c';
  public static string MediaCampaign_VariableRevenue4_SoldAmount = 'MT_VariableRevenue4_SoldAmount__c';
  public static string MediaCampaign_VariableRevenue5_SoldAmount = 'MT_VariableRevenue5_SoldAmount__c';
  public static string MediaCampaign_VariableRevenue1_SoldProduct = 'MT_VariableRevenue1_SoldProduct__c';
  public static string MediaCampaign_VariableRevenue2_SoldProduct = 'MT_VariableRevenue2_SoldProduct__c';
  public static string MediaCampaign_VariableRevenue3_SoldProduct = 'MT_VariableRevenue3_SoldProduct__c';
  public static string MediaCampaign_VariableRevenue4_SoldProduct = 'MT_VariableRevenue4_SoldProduct__c';
  public static string MediaCampaign_VariableRevenue5_SoldProduct = 'MT_VariableRevenue5_SoldProduct__c';

  public static string OpportunityApproval_ApprovalState = 'P7S1_ApprovalState__c';
  public static string OpportunityApproval_BmvTV = 'P7S1_BmvTv__c';
  public static string OpportunityApproval_BmvDigital = 'P7S1_BmvDigital__c';
  public static string OpportunityApproval_BmvDooH = 'P7S1_BMVDooH__c';
  public static string OpportunityApproval_BmvTvCustomerIntegration = 'P7S1_BmvTvCustomerIntegration__c';
  public static string OpportunityApproval_ContractStartDate = 'MT_ContractStartdate__c';
  public static string OpportunityApproval_ContractEndDate = 'MT_ContractEnddate__c';
  public static string OpportunityApproval_RuntimeTVStart = 'MT_RunTimeTVStart__c';
  public static string OpportunityApproval_RuntimeTVEnd = 'MT_RunTimeTVEnd__c';
  public static string OpportunityApproval_TvSpotLength = 'P7S1_TvSpotLength__c';
  public static string OpportunityApproval_TvSpotLengthCustomer = 'P7S1_TvSpotLengthCustomer__c';
  public static string OpportunityApproval_FixRevenueType = 'MT_FixRevenue_Type__c';
  public static string OpportunityApproval_FixRevenueMonthlyPayment = 'MT_FixRevenue_MonthlyPayment__c';
  public static string OpportunityApproval_Mn3TvCustomerIntegration = 'P7S1_Mn3TvCustomerIntegration__c';
  public static string OpportunityApproval_FillUp = 'P7S1_FillUp__c';
  public static string OpportunityApproval_GrossBarterVolume = 'P7S1_GrossBarterVolume__c';
  public static string OpportunityApproval_NetBarterVolume = 'P7S1_NetBarterVolume__c';
  public static string OpportunityApproval_ExitParticipation = 'P7S1_ExitParticipation__c';
  public static string OpportunityApproval_EquityBookValue = 'P7S1_EigenerBuchwertinEUR__c';
  public static string OpportunityApproval_CashPayment = 'P7S1_CashZahlung__c';
  public static string OpportunityApproval_VariableRevenue1_RevenuePerUnit = 'MT_VariableRevenue1_RevenuePerUnit__c';
  public static string OpportunityApproval_VariableRevenue2_RevenuePerUnit = 'MT_VariableRevenue2_RevenuePerUnit__c';
  public static string OpportunityApproval_VariableRevenue3_RevenuePerUnit = 'MT_VariableRevenue3_RevenuePerUnit__c';
  public static string OpportunityApproval_VariableRevenue4_RevenuePerUnit = 'MT_VariableRevenue4_RevenuePerUnit__c';
  public static string OpportunityApproval_VariableRevenue5_RevenuePerUnit = 'MT_VariableRevenue5_RevenuePerUnit__c';
  public static string OpportunityApproval_VariableRevenue1_SoldUnit = 'MT_VariableRevenue1_SoldUnit__c';
  public static string OpportunityApproval_VariableRevenue2_SoldUnit = 'MT_VariableRevenue2_SoldUnit__c';
  public static string OpportunityApproval_VariableRevenue3_SoldUnit = 'MT_VariableRevenue3_SoldUnit__c';
  public static string OpportunityApproval_VariableRevenue4_SoldUnit = 'MT_VariableRevenue4_SoldUnit__c';
  public static string OpportunityApproval_VariableRevenue5_SoldUnit = 'MT_VariableRevenue5_SoldUnit__c';
  public static string OpportunityApproval_VariableRevenue1_SoldAmount = 'MT_VariableRevenue1_SoldAmount__c';
  public static string OpportunityApproval_VariableRevenue2_SoldAmount = 'MT_VariableRevenue2_SoldAmount__c';
  public static string OpportunityApproval_VariableRevenue3_SoldAmount = 'MT_VariableRevenue3_SoldAmount__c';
  public static string OpportunityApproval_VariableRevenue4_SoldAmount = 'MT_VariableRevenue4_SoldAmount__c';
  public static string OpportunityApproval_VariableRevenue5_SoldAmount = 'MT_VariableRevenue5_SoldAmount__c';
  public static string OpportunityApproval_VariableRevenue1_SoldProduct = 'MT_VariableRevenue1_SoldProduct__c';
  public static string OpportunityApproval_VariableRevenue2_SoldProduct = 'MT_VariableRevenue2_SoldProduct__c';
  public static string OpportunityApproval_VariableRevenue3_SoldProduct = 'MT_VariableRevenue3_SoldProduct__c';
  public static string OpportunityApproval_VariableRevenue4_SoldProduct = 'MT_VariableRevenue4_SoldProduct__c';
  public static string OpportunityApproval_VariableRevenue5_SoldProduct = 'MT_VariableRevenue5_SoldProduct__c';

  public static String MediaUpdateHistory_Opp_HasMediaDigital = 'MT_Opp_P7S1_HasMediaDigital__c';
  public static String MediaUpdateHistory_Opp_HasMediaDOOH = 'MT_Opp_Som_DooH7Screen__c';
  public static String MediaUpdateHistory_Opp_HasMediaTV = 'MT_Opp_P7S1_HasMediaTV__c';

  public static String MediaUpdateHistory_OppApp_BmvTV = 'MT_OppApp_P7S1_BmvTV__c';
  public static String MediaUpdateHistory_OppApp_BmvDigital = 'MT_OppApp_BmvDigital__c';
  public static String MediaUpdateHistory_OppApp_BmvDooH = 'MT_OppApp_BmvDooH__c';
  public static String MediaUpdateHistory_OppApp_BmvTvCustomerIntegration = 'MT_OppApp_BmvTvCustomerIntegration__c';
  public static String MediaUpdateHistory_OppApp_ContractStartDate = 'MT_OppApp_ContractStartdate__c';
  public static String MediaUpdateHistory_OppApp_ContractEndDate = 'MT_OppApp_ContractEnddate__c';
  public static String MediaUpdateHistory_OppApp_RuntimeTVStart = 'MT_OppApp_RunTimeTVStart__c';
  public static String MediaUpdateHistory_OppApp_RuntimeTVEnd = 'MT_OppApp_RunTimeTVEnd__c';
  public static String MediaUpdateHistory_OppApp_TvSpotLength = 'MT_OppApp_TvSpotLength__c';
  public static String MediaUpdateHistory_OppApp_TvSpotLengthCustomer = 'MT_OppApp_TvSpotLengthCustomer__c';
  public static String MediaUpdateHistory_OppApp_FixRevenueType = 'MT_OppApp_FixRevenue_Type__c';
  public static String MediaUpdateHistory_OppApp_FixRevenueMonthlyPayment = 'MT_OppApp_FixRevenue_MonthlyPayment__c';
  public static String MediaUpdateHistory_OppApp_Mn3TvCustomerIntegration = 'MT_OppApp_Mn3TvCustomerIntegration__c';
  public static String MediaUpdateHistory_OppApp_FillUp = 'MT_OppApp_FillUp__c';
  public static String MediaUpdateHistory_OppApp_GrossBarterVolume = 'MT_OppApp_GrossBarterVolume__c';
  public static String MediaUpdateHistory_OppApp_NetBarterVolume = 'MT_OppApp_NetBarterVolume__c';
  public static String MediaUpdateHistory_OppApp_ExitParticipation = 'MT_OppApp_ExitParticipation__c';
  public static string MediaUpdateHistory_OppApp_EquityBookValue = 'MT_OppApp_EigenerBuchwertinEUR__c';
  public static string MediaUpdateHistory_OppApp_CashPayment = 'MT_OppApp_CashZahlung__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue1_RevenuePerUnit = 'MT_OppApp_VariableRevenue1_RevPerUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue2_RevenuePerUnit = 'MT_OppApp_VariableRevenue2_RevPerUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue3_RevenuePerUnit = 'MT_OppApp_VariableRevenue3_RevPerUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue4_RevenuePerUnit = 'MT_OppApp_VariableRevenue4_RevPerUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue5_RevenuePerUnit = 'MT_OppApp_VariableRevenue5_RevPerUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue1_SoldUnit = 'MT_OppApp_VariableRevenue1_SoldUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue2_SoldUnit = 'MT_OppApp_VariableRevenue2_SoldUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue3_SoldUnit = 'MT_OppApp_VariableRevenue3_SoldUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue4_SoldUnit = 'MT_OppApp_VariableRevenue4_SoldUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue5_SoldUnit = 'MT_OppApp_VariableRevenue5_SoldUnit__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue1_SoldAmount = 'MT_OppApp_VariableRevenue1_SoldAmount__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue2_SoldAmount = 'MT_OppApp_VariableRevenue2_SoldAmount__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue3_SoldAmount = 'MT_OppApp_VariableRevenue3_SoldAmount__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue4_SoldAmount = 'MT_OppApp_VariableRevenue4_SoldAmount__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue5_SoldAmount = 'MT_OppApp_VariableRevenue5_SoldAmount__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue1_SoldProduct = 'MT_OppApp_VariableRevenue1_SoldProduct__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue2_SoldProduct = 'MT_OppApp_VariableRevenue2_SoldProduct__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue3_SoldProduct = 'MT_OppApp_VariableRevenue3_SoldProduct__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue4_SoldProduct = 'MT_OppApp_VariableRevenue4_SoldProduct__c';
  public static string MediaUpdateHistory_OppApp_VariableRevenue5_SoldProduct = 'MT_OppApp_VariableRevenue5_SoldProduct__c';

  public static String MediaUpdateHistory_MCamp_ContractStartDate = 'MT_MCamp_ContractStartdate__c';
  public static String MediaUpdateHistory_MCamp_ContractEndDate = 'MT_MCamp_ContractEnddate__c';
  public static String MediaUpdateHistory_MCamp_RuntimeTVStart = 'MT_MCamp_RunTimeTVStart__c';
  public static String MediaUpdateHistory_MCamp_RuntimeTVEnd = 'MT_MCamp_RunTimeTVEnd__c';
  public static String MediaUpdateHistory_MCamp_BmvTV = 'MT_MCamp_BmvTV__c';
  public static String MediaUpdateHistory_MCamp_BmvDigital = 'MT_MCamp_BmvDigital__c';
  public static String MediaUpdateHistory_MCamp_BmvDooH = 'MT_MCamp_BmvDooH__c';
  public static String MediaUpdateHistory_MCamp_BmvTvCustomerIntegration = 'MT_MCamp_BmvTvCustomerIntegration__c';
  public static String MediaUpdateHistory_MCamp_TvSpotLength = 'MT_MCamp_TvSpotLength__c';
  public static String MediaUpdateHistory_MCamp_TvSpotLengthCustomer = 'MT_MCamp_TvSpotLengthCustomer__c';
  public static String MediaUpdateHistory_MCamp_FixRevenueType = 'MT_MCamp_FixRevenue_Type__c';
  public static String MediaUpdateHistory_MCamp_FixRevenueMonthlyPayment = 'MT_MCamp_FixRevenue_MonthlyPayment__c';
  public static String MediaUpdateHistory_MCamp_Mn3TvCustomerIntegration = 'MT_MCamp_Mn3TvCustomerIntegration__c';
  public static String MediaUpdateHistory_MCamp_FillUp = 'MT_MCamp_FillUp__c';
  public static String MediaUpdateHistory_MCamp_GrossBarterVolume = 'MT_MCamp_GrossBarterVolume__c';
  public static String MediaUpdateHistory_MCamp_NetBarterVolume = 'MT_MCamp_NetBarterVolume__c';
  public static String MediaUpdateHistory_MCamp_ExitParticipation = 'MT_MCamp_ExitParticipation__c';
  public static string MediaUpdateHistory_MCamp_EquityBookValue = 'MT_MCamp_EigenerBuchwertinEUR__c';
  public static string MediaUpdateHistory_MCamp_CashPayment = 'MT_MCamp_CashZahlung__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue1_RevenuePerUnit = 'MT_MCamp_VariableRevenue1_RevenuePerUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue2_RevenuePerUnit = 'MT_MCamp_VariableRevenue2_RevenuePerUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue3_RevenuePerUnit = 'MT_MCamp_VariableRevenue3_RevenuePerUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue4_RevenuePerUnit = 'MT_MCamp_VariableRevenue4_RevenuePerUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue5_RevenuePerUnit = 'MT_MCamp_VariableRevenue5_RevenuePerUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue1_SoldUnit = 'MT_MCamp_VariableRevenue1_SoldUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue2_SoldUnit = 'MT_MCamp_VariableRevenue2_SoldUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue3_SoldUnit = 'MT_MCamp_VariableRevenue3_SoldUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue4_SoldUnit = 'MT_MCamp_VariableRevenue4_SoldUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue5_SoldUnit = 'MT_MCamp_VariableRevenue5_SoldUnit__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue1_SoldAmount = 'MT_MCamp_VariableRevenue1_SoldAmount__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue2_SoldAmount = 'MT_MCamp_VariableRevenue2_SoldAmount__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue3_SoldAmount = 'MT_MCamp_VariableRevenue3_SoldAmount__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue4_SoldAmount = 'MT_MCamp_VariableRevenue4_SoldAmount__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue5_SoldAmount = 'MT_MCamp_VariableRevenue5_SoldAmount__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue1_SoldProduct = 'MT_MCamp_VariableRevenue1_SoldProduct__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue2_SoldProduct = 'MT_MCamp_VariableRevenue2_SoldProduct__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue3_SoldProduct = 'MT_MCamp_VariableRevenue3_SoldProduct__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue4_SoldProduct = 'MT_MCamp_VariableRevenue4_SoldProduct__c';
  public static string MediaUpdateHistory_MCamp_VariableRevenue5_SoldProduct = 'MT_MCamp_VariableRevenue5_SoldProduct__c';

  public static String Opportunity_HasMediaDigital = 'P7S1_HasMediaDigital__c';
  public static String Opportunity_HasMediaDOOH = 'Som_DooH7Screen__c';
  public static String Opportunity_HasMediaTV = 'P7S1_HasMediaTV__c';

  public static String Opp = String.valueOf(Opportunity.getSObjectType());
  public static String MC = String.valueOf(MT_MediaCampaign__c.getSObjectType());
  public static String MUH = String.valueOf(MT_MediaUpdateHistory__c.getSObjectType());
  public static String OppApp = String.valueOf(P7S1_OpportunityApproval__c.getSObjectType());

  public static Map<String, Conf> mainConf;
  public static Map<String, Set<String>> allFieldConf;

  /**
   * Initialize the module with the fields to check.
   */
  static {
    mainConf = new Map<String, Conf>();
    allFieldConf = new Map<String, Set<String>>();

    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_BmvTV, OppApp, OpportunityApproval_BmvTV, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_BmvDigital, OppApp, OpportunityApproval_BmvDigital, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_BmvDooH, OppApp, OpportunityApproval_BmvDooH, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_BmvTvCustomerIntegration, OppApp, OpportunityApproval_BmvTvCustomerIntegration, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_ContractStartDate, OppApp, OpportunityApproval_ContractStartDate, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_ContractEndDate, OppApp, OpportunityApproval_ContractEndDate, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_RuntimeTVStart, OppApp, OpportunityApproval_RuntimeTVStart, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_RuntimeTVEnd, OppApp, OpportunityApproval_RuntimeTVEnd, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_TvSpotLength, OppApp, OpportunityApproval_TvSpotLength, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_TvSpotLengthCustomer, OppApp, OpportunityApproval_TvSpotLengthCustomer, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_FixRevenueType, OppApp, OpportunityApproval_FixRevenueType, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_FixRevenueMonthlyPayment, OppApp, OpportunityApproval_FixRevenueMonthlyPayment, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_Mn3TvCustomerIntegration, OppApp, OpportunityApproval_Mn3TvCustomerIntegration, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_FillUp, OppApp, OpportunityApproval_FillUp, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_GrossBarterVolume, OppApp, OpportunityApproval_GrossBarterVolume, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_NetBarterVolume, OppApp, OpportunityApproval_NetBarterVolume, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_ExitParticipation, OppApp, OpportunityApproval_ExitParticipation, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_EquityBookValue, OppApp, OpportunityApproval_EquityBookValue, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_CashPayment, OppApp, OpportunityApproval_CashPayment, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue1_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue1_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue2_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue2_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue3_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue3_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue4_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue4_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue5_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue5_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue1_SoldUnit, OppApp, OpportunityApproval_VariableRevenue1_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue2_SoldUnit, OppApp, OpportunityApproval_VariableRevenue2_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue3_SoldUnit, OppApp, OpportunityApproval_VariableRevenue3_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue4_SoldUnit, OppApp, OpportunityApproval_VariableRevenue4_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue5_SoldUnit, OppApp, OpportunityApproval_VariableRevenue5_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue1_SoldAmount, OppApp, OpportunityApproval_VariableRevenue1_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue2_SoldAmount, OppApp, OpportunityApproval_VariableRevenue2_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue3_SoldAmount, OppApp, OpportunityApproval_VariableRevenue3_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue4_SoldAmount, OppApp, OpportunityApproval_VariableRevenue4_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue5_SoldAmount, OppApp, OpportunityApproval_VariableRevenue5_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue1_SoldProduct, OppApp, OpportunityApproval_VariableRevenue1_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue2_SoldProduct, OppApp, OpportunityApproval_VariableRevenue2_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue3_SoldProduct, OppApp, OpportunityApproval_VariableRevenue3_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue4_SoldProduct, OppApp, OpportunityApproval_VariableRevenue4_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_VariableRevenue5_SoldProduct, OppApp, OpportunityApproval_VariableRevenue5_SoldProduct, true));

    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_Status, OppApp, OpportunityApproval_ApprovalState, new Map<String, String>{
      MT_Constants.getInstance().OpportunityApproval_ApprovalStatus_Approved => MT_Constants.getInstance().MediaCampaign_Status_Approved,
      null => MT_Constants.getInstance().MediaCampaign_Status_Draft
    }
    ));

//    system.debug(mainConf);
//    system.debug(allFieldConf);

    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_HasMediaDigital, Opp, Opportunity_HasMediaDigital, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_HasMediaDooH, Opp, Opportunity_HasMediaDOOH, true));
    addSyncItemConf(new SyncItemConf(MC, MediaCampaign_HasMediaTV, Opp, Opportunity_HasMediaTV, true));

    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_Opp_HasMediaDigital, Opp, Opportunity_HasMediaDigital, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_Opp_HasMediaDOOH, Opp, Opportunity_HasMediaDOOH, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_Opp_HasMediaTV, Opp, Opportunity_HasMediaTV, true));

    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_BmvTV, OppApp, OpportunityApproval_BmvTV, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_BmvDigital, OppApp, OpportunityApproval_BmvDigital, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_BmvDooH, OppApp, OpportunityApproval_BmvDooH, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_BmvTvCustomerIntegration, OppApp, OpportunityApproval_BmvTvCustomerIntegration, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_ContractStartDate, OppApp, OpportunityApproval_ContractStartDate, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_ContractEndDate, OppApp, OpportunityApproval_ContractEndDate, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_RuntimeTVStart, OppApp, OpportunityApproval_RuntimeTVStart, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_RuntimeTVEnd, OppApp, OpportunityApproval_RuntimeTVEnd, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_TvSpotLength, OppApp, OpportunityApproval_TvSpotLength, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_TvSpotLengthCustomer, OppApp, OpportunityApproval_TvSpotLengthCustomer, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_FixRevenueType, OppApp, OpportunityApproval_FixRevenueType, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_FixRevenueMonthlyPayment, OppApp, OpportunityApproval_FixRevenueMonthlyPayment, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_Mn3TvCustomerIntegration, OppApp, OpportunityApproval_Mn3TvCustomerIntegration, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_FillUp, OppApp, OpportunityApproval_FillUp, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_GrossBarterVolume, OppApp, OpportunityApproval_GrossBarterVolume, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_NetBarterVolume, OppApp, OpportunityApproval_NetBarterVolume, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_ExitParticipation, OppApp, OpportunityApproval_ExitParticipation, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_EquityBookValue, OppApp, OpportunityApproval_EquityBookValue, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_CashPayment, OppApp, OpportunityApproval_CashPayment, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue1_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue1_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue2_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue2_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue3_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue3_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue4_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue4_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue5_RevenuePerUnit, OppApp, OpportunityApproval_VariableRevenue5_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue1_SoldUnit, OppApp, OpportunityApproval_VariableRevenue1_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue2_SoldUnit, OppApp, OpportunityApproval_VariableRevenue2_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue3_SoldUnit, OppApp, OpportunityApproval_VariableRevenue3_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue4_SoldUnit, OppApp, OpportunityApproval_VariableRevenue4_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue5_SoldUnit, OppApp, OpportunityApproval_VariableRevenue5_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue1_SoldAmount, OppApp, OpportunityApproval_VariableRevenue1_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue2_SoldAmount, OppApp, OpportunityApproval_VariableRevenue2_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue3_SoldAmount, OppApp, OpportunityApproval_VariableRevenue3_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue4_SoldAmount, OppApp, OpportunityApproval_VariableRevenue4_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue5_SoldAmount, OppApp, OpportunityApproval_VariableRevenue5_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue1_SoldProduct, OppApp, OpportunityApproval_VariableRevenue1_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue2_SoldProduct, OppApp, OpportunityApproval_VariableRevenue2_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue3_SoldProduct, OppApp, OpportunityApproval_VariableRevenue3_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue4_SoldProduct, OppApp, OpportunityApproval_VariableRevenue4_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_OppApp_VariableRevenue5_SoldProduct, OppApp, OpportunityApproval_VariableRevenue5_SoldProduct, true));

    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_ContractStartDate, MC, MediaCampaign_ContractStartDate, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_ContractEndDate, MC, MediaCampaign_ContractEndDate, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_RuntimeTVStart, MC, MediaCampaign_RuntimeTVStart, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_RuntimeTVEnd, MC, MediaCampaign_RuntimeTVEnd, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_BmvTV, MC, MediaCampaign_BmvTV, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_BmvDigital, MC, MediaCampaign_BmvDigital, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_BmvDooH, MC, MediaCampaign_BmvDooH, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_BmvTvCustomerIntegration, MC, MediaCampaign_BmvTvCustomerIntegration, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_TvSpotLength, MC, MediaCampaign_TvSpotLength, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_TvSpotLengthCustomer, MC, MediaCampaign_TvSpotLengthCustomer, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_FixRevenueType, MC, MediaCampaign_FixRevenueType, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_FixRevenueMonthlyPayment, MC, MediaCampaign_FixRevenueMonthlyPayment, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_Mn3TvCustomerIntegration, MC, MediaCampaign_Mn3TvCustomerIntegration, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_FillUp, MC, MediaCampaign_FillUp, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_GrossBarterVolume, MC, MediaCampaign_GrossBarterVolume, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_NetBarterVolume, MC, MediaCampaign_NetBarterVolume, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_ExitParticipation, MC, MediaCampaign_ExitParticipation, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_EquityBookValue, MC, MediaCampaign_EquityBookValue, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_CashPayment, MC, MediaCampaign_CashPayment, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue1_RevenuePerUnit, MC, MediaCampaign_VariableRevenue1_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue2_RevenuePerUnit, MC, MediaCampaign_VariableRevenue2_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue3_RevenuePerUnit, MC, MediaCampaign_VariableRevenue3_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue4_RevenuePerUnit, MC, MediaCampaign_VariableRevenue4_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue5_RevenuePerUnit, MC, MediaCampaign_VariableRevenue5_RevenuePerUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue1_SoldUnit, MC, MediaCampaign_VariableRevenue1_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue2_SoldUnit, MC, MediaCampaign_VariableRevenue2_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue3_SoldUnit, MC, MediaCampaign_VariableRevenue3_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue4_SoldUnit, MC, MediaCampaign_VariableRevenue4_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue5_SoldUnit, MC, MediaCampaign_VariableRevenue5_SoldUnit, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue1_SoldAmount, MC, MediaCampaign_VariableRevenue1_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue2_SoldAmount, MC, MediaCampaign_VariableRevenue2_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue3_SoldAmount, MC, MediaCampaign_VariableRevenue3_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue4_SoldAmount, MC, MediaCampaign_VariableRevenue4_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue5_SoldAmount, MC, MediaCampaign_VariableRevenue5_SoldAmount, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue1_SoldProduct, MC, MediaCampaign_VariableRevenue1_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue2_SoldProduct, MC, MediaCampaign_VariableRevenue2_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue3_SoldProduct, MC, MediaCampaign_VariableRevenue3_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue4_SoldProduct, MC, MediaCampaign_VariableRevenue4_SoldProduct, true));
    addSyncItemConf(new SyncItemConf(MUH, MediaUpdateHistory_MCamp_VariableRevenue5_SoldProduct, MC, MediaCampaign_VariableRevenue5_SoldProduct, true));
  }

  /**
   * Compare versions of a record if any of the shared fields has changed.
   *
   * @param sObject newObj    The new version of the record.
   * @param sObject oldObj    The old version of the record.
   * @param Boolean addError  Whether to add an error for the changed field or just return a boolean.
   * @param String  errorMsg  The errorMsg to put onto the changed field.
   *
   * @return Boolean Whether any of the shared fields differs between the two versions.
   */
  public static Boolean hasChanged(sObject newObj, sObject oldObj, Boolean addError, String errorMsg) {
    if (String.valueOf(newObj.getSobjectType()) == Opp && !ACTIVE_HASCHANGED_Opportunity) {
      return false;
    }

    if (String.valueOf(newObj.getSobjectType()) == OppApp && !ACTIVE_HASCHANGED_OpportunityApproval) {
      return false;
    }

    if (String.valueOf(newObj.getSobjectType()) == MC && !ACTIVE_HASCHANGED_MediaCampaign) {
      return false;
    }

    if (addError) {
      Boolean hasChanged = false;

      for (String syncField : getSyncFields(String.valueOf(newObj.getSobjectType()))) {
//        system.debug(syncField);

        if (newObj.get(syncField) != oldObj.get(syncField)) {
          MT_SynchronisationModule.addError(newObj, syncField, errorMsg);
          hasChanged = true;
        }
      }

//      system.debug(hasChanged);

      return hasChanged;
    } else {
      for (String syncField : getSyncFields(String.valueOf(newObj.getSobjectType()))) {
        if (newObj.get(syncField) != oldObj.get(syncField)) {
          return true;
        }
      }
      return false;
    }
  }

  /**
   * Update the shared fields of {target} with the values of the respective fields from {dest}.
   *
   * @param sObject target  The record to synchronize.
   * @param sObject dest    The origin record providing the source values.
   *
   * @return Boolean Returns true if any of the shared fields was differing and updated.
   */
  public static Boolean synchronise(sObject target, sObject dest) {
    String targetStr = String.valueOf(target.getSobjectType());
    String destStr = String.valueOf(dest.getSobjectType());
    Boolean isChanged = false;

    for (SyncItem si : getSyncItems(targetStr, destStr)) {
      if (si.hasCustomSyncMapping) {
        String targetVal = String.valueOf(target.get(si.target));
        String destVal = String.valueOf(dest.get(si.dest));

        if (si.customSyncMapping.containsKey(destVal) && targetVal != si.customSyncMapping.get(destVal)) {
          target.put(si.target, si.customSyncMapping.get(destVal));
          isChanged = true;
        } else if (si.customSyncMapping.containsKey(null) && targetVal != si.customSyncMapping.get(null)) {
          target.put(si.target, si.customSyncMapping.get(null));
          isChanged = true;
        }
      } else {
        if (target.get(si.target) != dest.get(si.dest)) {
          target.put(si.target, dest.get(si.dest));
          isChanged = true;
        }
      }
    }
    return isChanged;
  }

  /**
   * Compares two records if the shared fields are in sync.
   *
   * @param sObject target  The target record.
   * @param sObject dest    The origin record.
   *
   * @return Boolean Returns the shared fields of both records are equal.
   */
  public static Boolean isSynchronised(sObject target, sObject dest) {
    String targetStr = String.valueOf(target.getSobjectType());
    String destStr = String.valueOf(dest.getSobjectType());

    for (SyncItem si : getSyncItems(targetStr, destStr)) {
      if (si.hasCustomSyncMapping) {
        continue;
      }

      if (target.get(si.target) != dest.get(si.dest)) {
        return false;
      }
    }

    return true;
  }

  /**
   * Adds a new sync field map configuration.
   *
   * @param SyncItemConf conf The configuration to add.
   */
  public static void addSyncItemConf(SyncItemConf conf) {
    String key = conf.objTarget + '_' + conf.objDest;

    if (!conf.hasCustomSyncMapping) {
      if (!allFieldConf.containsKey(conf.objTarget)) {
        allFieldConf.put(conf.objTarget, new Set<String>());
      }

      allFieldConf.get(conf.objTarget).add(conf.target);

      if (!allFieldConf.containsKey(conf.objDest)) {
        allFieldConf.put(conf.objDest, new Set<String>());
      }

      allFieldConf.get(conf.objDest).add(conf.dest);
    }

    if (!mainConf.containsKey(key)) {
      mainConf.put(key, new Conf());
    }

    mainConf.get(key).addSyncItem(conf.getTargetSyncItem());

    if (conf.twoWay) {
      String key2 = conf.objDest + '_' + conf.objTarget;

      if (!mainConf.containsKey(key2)) {
        mainConf.put(key2, new Conf());
      }

      mainConf.get(key2).addSyncItem(conf.getDestSyncItem());
    }
  }

  /**
   * Returns all shared fields of the given object.
   *
   * @param String obj The name of the object to return the shared fields for.
   *
   * @return Set<String> The shared fields.
   */
  public static Set<String> getSyncFields(String obj) {
    return allFieldConf.get(obj);
  }

  /**
   * Returns the configured field mappings for the given target and destination combination.
   *
   * @param String target       The target object.
   * @param String destination  The origin object.
   *
   * @return Set<SyncItem> The configured field mappings.
   */
  public static Set<SyncItem> getSyncItems(String target, String destination) {
    if (!mainConf.containsKey(target + '_' + destination)) {
      return new Set<SyncItem>();
    }

    return mainConf.get(target + '_' + destination).items;
  }

  /**
   * Returns the configured target fields for the given target and destination combination.
   *
   * @param String target       The target object.
   * @param String destination  The origin object.
   *
   * @return Set<String> The configured fields.
   */
  public static Set<String> getTargetFields(String target, String destination) {
    if (!mainConf.containsKey(target + '_' + destination)) {
      return new Set<String>();
    }

    return mainConf.get(target + '_' + destination).targetFields;
  }

  /**
   * Returns the configured origin fields for the given target and destination combination.
   *
   * @param String target       The target object.
   * @param String destination  The origin object.
   *
   * @return Set<String> The configured fields.
   */
  public static Set<String> getDestFields(String target, String destination) {
    if (!mainConf.containsKey(target + '_' + destination)) {
      return new Set<String>();
    }

    return mainConf.get(target + '_' + destination).destFields;
  }

  /**
   * Holds the target and origin field mappings for each combination of origin and target object.
   */
  public class Conf {
    public Set<String> targetFields = new Set<String>();
    public Set<String> destFields = new Set<String>();
    public Set<SyncItem> items = new Set<SyncItem>();

    /**
     * Adds a new field mapping to this configuration.
     *
     * @param SyncItem syncItem The field mapping.
     */
    public void addSyncItem(SyncItem syncItem) {
      if (!items.contains(syncItem)) {
        this.items.add(syncItem);
      }

      this.targetFields.add(syncItem.target);
      this.destFields.add(syncItem.dest);
    }
  }

  /**
   * Holds a field mapping between an origin and a destination field.
   */
  public class SyncItem {
    public String target;
    public String dest;
    public Map<String, String> customSyncMapping;

    /**
     * Initialize this field mapping with a target and origin field.
     *
     * @param String target The target field.
     * @param String dest   The origin field.
     */
    public SyncItem(String target, String dest) {
      this.target = target;
      this.dest = dest;
    }

    /**
     * Initialize this field mapping with a target and origin field and additionally a custom value mapping.
     *
     * @param String              target            The target field.
     * @param String              dest              The origin field.
     * @param Map<String, String> customSyncMapping The custom value mapping.
     */
    public SyncItem(String target, String dest, Map<String, String> customSyncMapping) {
      this(target, dest);

      this.customSyncMapping = customSyncMapping;
    }

    /**
     * Returns true if this field mapping has a custom value mapping.
     */
    public Boolean hasCustomSyncMapping { get {return customSyncMapping != null;} }
  }

  /**
   * Configures a field mapping between two fields of different objects.
   */
  public class SyncItemConf {
    public String target = null;
    public String objTarget = null;
    public String dest = null;
    public String objDest = null;
    public Boolean twoWay = null;
    public Map<String, String> customSyncMapping = null;
    public Boolean hasCustomSyncMapping { get {return customSyncMapping != null;} }

    /**
     * Initialize this configuration.
     *
     * @param String  objTarget The name of the target object.
     * @param String  target    The name of the target field.
     * @param String  objDest   The name of the origin object.
     * @param String  dest      The name of the origin field.
     * @param Boolean twoWay    True if the synchronization can be done in both ways.
     */
    public SyncItemConf(String objTarget, String target, String objDest, String dest, Boolean twoWay) {
      this.target = target;
      this.dest = dest;
      this.objTarget = objTarget;
      this.objDest = objDest;
      this.twoWay = twoWay;
    }

    /**
     * Initialize this configuration.
     *
     * @param String              objTarget         The name of the target object.
     * @param String              target            The name of the target field.
     * @param String              objDest           The name of the origin object.
     * @param String              dest              The name of the origin field.
     * @param Boolean             twoWay            True if the synchronization can be done in both ways.
     * @param Map<String, String> customSyncMapping A custom value mapping.
     */
    public SyncItemConf(String objTarget, String target, String objDest, String dest, Map<String, String> customSyncMapping) {
      this.target = target;
      this.dest = dest;
      this.objTarget = objTarget;
      this.objDest = objDest;
      this.twoWay = false;
      this.customSyncMapping = customSyncMapping;
    }

    /**
     * Returns a field mapping definition for the target side.
     *
     * @return SyncItem The sync item.
     */
    public SyncItem getTargetSyncItem() {
      return new SyncItem(this.target, this.dest, this.customSyncMapping);
    }

    /**
     * Returns a field mapping definition for the origin side.
     *
     * @return SyncItem The sync item.
     */
    public SyncItem getDestSyncItem() {
      return new SyncItem(this.dest, this.target, this.customSyncMapping);
    }
  }

  /**
   * Add an error message to the given field.
   *
   * @param sObject obj   The record to receive the error message.
   * @param String  field The field to put the error message onto.
   */
  public static void addError(sObject obj, String field, String error) {
    if (obj.getSObjectType() == MT_MediaCampaign__c.getSObjectType()) {
      MT_MediaCampaign__c castedObj = (MT_MediaCampaign__c) obj;

      if (field == MediaCampaign_ContractStartDate) {
        castedObj.MT_ContractStartdate__c.addError(error);
      } else if (field == MediaCampaign_ContractEndDate) {
        castedObj.MT_ContractEnddate__c.addError(error);
      } else if (field == MediaCampaign_RuntimeTVStart) {
        castedObj.MT_RunTimeTVStart__c.addError(error);
      } else if (field == MediaCampaign_RuntimeTVEnd) {
        castedObj.MT_RunTimeTVEnd__c.addError(error);
      } else if (field == MediaCampaign_HasMediaDigital) {
        castedObj.MT_HasMediaDigital__c.addError(error);
      } else if (field == MediaCampaign_HasMediaDooH) {
        castedObj.MT_HasMediaDooH__c.addError(error);
      } else if (field == MediaCampaign_HasMediaTV) {
        castedObj.MT_HasMediaTV__c.addError(error);
      } else if (field == MediaCampaign_BmvTV) {
        castedObj.MT_BmvTv__c.addError(error);
      } else if (field == MediaCampaign_BmvDigital) {
        castedObj.MT_BmvDigital__c.addError(error);
      } else if (field == MediaCampaign_BmvDooH) {
        castedObj.MT_BMVDooH__c.addError(error);
      } else if (field == MediaCampaign_BmvTvCustomerIntegration) {
        castedObj.MT_BmvTvCustomerIntegration__c.addError(error);
      } else if (field == MediaCampaign_TvSpotLength) {
        castedObj.MT_TvSpotLength__c.addError(error);
      } else if (field == MediaCampaign_TvSpotLengthCustomer) {
        castedObj.MT_TvSpotLengthCustomer__c.addError(error);
      } else if (field == MediaCampaign_FixRevenueType) {
        castedObj.MT_FixRevenue_Type__c.addError(error);
      } else if (field == MediaCampaign_FixRevenueMonthlyPayment) {
        castedObj.MT_FixRevenue_MonthlyPayment__c.addError(error);
      } else if (field == MediaCampaign_Mn3TvCustomerIntegration) {
        castedObj.MT_Mn3TvCustomerIntegration__c.addError(error);
      } else if (field == MediaCampaign_FillUp) {
        castedObj.MT_FillUp__c.addError(error);
      } else if (field == MediaCampaign_GrossBarterVolume) {
        castedObj.MT_GrossBarterVolume__c.addError(error);
      } else if (field == MediaCampaign_NetBarterVolume) {
        castedObj.MT_NetBarterVolume__c.addError(error);
      } else if (field == MediaCampaign_ExitParticipation) {
        castedObj.MT_ExitParticipation__c.addError(error);
      } else if (field == MediaCampaign_EquityBookValue) {
        castedObj.MT_EigenerBuchwertinEUR__c.addError(error);
      } else if (field == MediaCampaign_CashPayment) {
        castedObj.MT_CashZahlung__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue1_RevenuePerUnit) {
        castedObj.MT_VariableRevenue1_RevenuePerUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue2_RevenuePerUnit) {
        castedObj.MT_VariableRevenue2_RevenuePerUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue3_RevenuePerUnit) {
        castedObj.MT_VariableRevenue3_RevenuePerUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue4_RevenuePerUnit) {
        castedObj.MT_VariableRevenue4_RevenuePerUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue5_RevenuePerUnit) {
        castedObj.MT_VariableRevenue5_RevenuePerUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue1_SoldUnit) {
        castedObj.MT_VariableRevenue1_SoldUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue2_SoldUnit) {
        castedObj.MT_VariableRevenue2_SoldUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue3_SoldUnit) {
        castedObj.MT_VariableRevenue3_SoldUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue4_SoldUnit) {
        castedObj.MT_VariableRevenue4_SoldUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue5_SoldUnit) {
        castedObj.MT_VariableRevenue5_SoldUnit__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue1_SoldAmount) {
        castedObj.MT_VariableRevenue1_SoldAmount__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue2_SoldAmount) {
        castedObj.MT_VariableRevenue2_SoldAmount__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue3_SoldAmount) {
        castedObj.MT_VariableRevenue3_SoldAmount__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue4_SoldAmount) {
        castedObj.MT_VariableRevenue4_SoldAmount__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue5_SoldAmount) {
        castedObj.MT_VariableRevenue5_SoldAmount__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue1_SoldProduct) {
        castedObj.MT_VariableRevenue1_SoldProduct__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue2_SoldProduct) {
        castedObj.MT_VariableRevenue2_SoldProduct__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue3_SoldProduct) {
        castedObj.MT_VariableRevenue3_SoldProduct__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue4_SoldProduct) {
        castedObj.MT_VariableRevenue4_SoldProduct__c.addError(error);
      } else if (field == MediaCampaign_VariableRevenue5_SoldProduct) {
        castedObj.MT_VariableRevenue5_SoldProduct__c.addError(error);
      } else {
        error = 'Unhandled field (' + field + '): ' + error;
        castedObj.addError(error);
      }
    } else if (obj.getSObjectType() == Opportunity.getSObjectType()) {
      Opportunity castedObj = (Opportunity) obj;

      if (field == Opportunity_HasMediaDigital) {
        castedObj.P7S1_HasMediaDigital__c.addError(error);
      } else if (field == Opportunity_HasMediaDOOH) {
        castedObj.Som_DooH7Screen__c.addError(error);
      } else if (field == Opportunity_HasMediaTV) {
        castedObj.P7S1_HasMediaTV__c.addError(error);
      } else {
        error = 'Unhandled field (' + field + '): ' + error;
        castedObj.addError(error);
      }
    } else if (obj.getSObjectType() == P7S1_OpportunityApproval__c.getSObjectType()) {
      P7S1_OpportunityApproval__c castedObj = (P7S1_OpportunityApproval__c) obj;

      if (field == OpportunityApproval_BmvTV) {
        castedObj.P7S1_BmvTv__c.addError(error);
      } else if (field == OpportunityApproval_BmvDigital) {
        castedObj.P7S1_BmvDigital__c.addError(error);
      } else if (field == OpportunityApproval_BmvDooH) {
        castedObj.P7S1_BMVDooH__c.addError(error);
      } else if (field == OpportunityApproval_BmvTvCustomerIntegration) {
        castedObj.P7S1_BmvTvCustomerIntegration__c.addError(error);
      } else if (field == OpportunityApproval_ContractStartDate) {
        castedObj.MT_ContractStartdate__c.addError(error);
      } else if (field == OpportunityApproval_ContractEndDate) {
        castedObj.MT_ContractEnddate__c.addError(error);
      } else if (field == OpportunityApproval_RuntimeTVStart) {
        castedObj.MT_RunTimeTVStart__c.addError(error);
      } else if (field == OpportunityApproval_RuntimeTVEnd) {
        castedObj.MT_RunTimeTVEnd__c.addError(error);
      } else if (field == OpportunityApproval_TvSpotLength) {
        castedObj.P7S1_TvSpotLength__c.addError(error);
      } else if (field == OpportunityApproval_TvSpotLengthCustomer) {
        castedObj.P7S1_TvSpotLengthCustomer__c.addError(error);
      } else if (field == OpportunityApproval_FixRevenueType) {
        castedObj.MT_FixRevenue_Type__c.addError(error);
      } else if (field == OpportunityApproval_FixRevenueMonthlyPayment) {
        castedObj.MT_FixRevenue_MonthlyPayment__c.addError(error);
      } else if (field == OpportunityApproval_Mn3TvCustomerIntegration) {
        castedObj.P7S1_Mn3TvCustomerIntegration__c.addError(error);
      } else if (field == OpportunityApproval_FillUp) {
        castedObj.P7S1_FillUp__c.addError(error);
      } else if (field == OpportunityApproval_GrossBarterVolume) {
        castedObj.P7S1_GrossBarterVolume__c.addError(error);
      } else if (field == OpportunityApproval_NetBarterVolume) {
        castedObj.P7S1_NetBarterVolume__c.addError(error);
      } else if (field == OpportunityApproval_ExitParticipation) {
        castedObj.P7S1_ExitParticipation__c.addError(error);
      } else if (field == OpportunityApproval_EquityBookValue) {
        castedObj.P7S1_EigenerBuchwertinEUR__c.addError(error);
      } else if (field == OpportunityApproval_CashPayment) {
        castedObj.P7S1_CashZahlung__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue1_RevenuePerUnit) {
        castedObj.MT_VariableRevenue1_RevenuePerUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue2_RevenuePerUnit) {
        castedObj.MT_VariableRevenue2_RevenuePerUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue3_RevenuePerUnit) {
        castedObj.MT_VariableRevenue3_RevenuePerUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue4_RevenuePerUnit) {
        castedObj.MT_VariableRevenue4_RevenuePerUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue5_RevenuePerUnit) {
        castedObj.MT_VariableRevenue5_RevenuePerUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue1_SoldUnit) {
        castedObj.MT_VariableRevenue1_SoldUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue2_SoldUnit) {
        castedObj.MT_VariableRevenue2_SoldUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue3_SoldUnit) {
        castedObj.MT_VariableRevenue3_SoldUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue4_SoldUnit) {
        castedObj.MT_VariableRevenue4_SoldUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue5_SoldUnit) {
        castedObj.MT_VariableRevenue5_SoldUnit__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue1_SoldAmount) {
        castedObj.MT_VariableRevenue1_SoldAmount__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue2_SoldAmount) {
        castedObj.MT_VariableRevenue2_SoldAmount__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue3_SoldAmount) {
        castedObj.MT_VariableRevenue3_SoldAmount__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue4_SoldAmount) {
        castedObj.MT_VariableRevenue4_SoldAmount__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue5_SoldAmount) {
        castedObj.MT_VariableRevenue5_SoldAmount__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue1_SoldProduct) {
        castedObj.MT_VariableRevenue1_SoldProduct__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue2_SoldProduct) {
        castedObj.MT_VariableRevenue2_SoldProduct__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue3_SoldProduct) {
        castedObj.MT_VariableRevenue3_SoldProduct__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue4_SoldProduct) {
        castedObj.MT_VariableRevenue4_SoldProduct__c.addError(error);
      } else if (field == OpportunityApproval_VariableRevenue5_SoldProduct) {
        castedObj.MT_VariableRevenue5_SoldProduct__c.addError(error);
      } else {
        error = 'Unhandled field (' + field + '): ' + error;
        castedObj.addError(error);
      }
    } else {
      error = 'Unhandled Object Type (' + obj.getSObjectType() + ') for field (' + field + '): ' + error;
      obj.addError(error);
    }

    /* we need to throw this exception, as otherwise we couldn't assert the error in any way */
    if (Test.isRunningTest()) {
      throw new MT_SynchronisationModuleException(error);
    }
  }

  /**
   * Holds exception information that may occur during synchronization (used for testing purposes).
   */
  public class MT_SynchronisationModuleException extends Exception {
  }
}