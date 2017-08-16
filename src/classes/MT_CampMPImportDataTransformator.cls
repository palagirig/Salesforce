/**
 * Batch that transform the imported campaign monthly plan data from KRS
 * to Media campaign Monthly Plans in MT_MediaCampaignMonthlyPlan__c.
 *
 * @author GP
 */

public with sharing class MT_CampMPImportDataTransformator implements Database.Batchable<sObject>, Database.Stateful {

  @TestVisible public List<String> loggedErrors;
  @TestVisible public Integer updatedRecords;
  @TestVisible public Integer processedRecords;
  @TestVisible public Integer failedRecords;

	/**
   * Initialize this instance.
   */
  public MT_CampMPImportDataTransformator() {
    loggedErrors = new List<String>();
    updatedRecords = 0;
    processedRecords = 0;
    failedRecords = 0;
  }

  /**
   * Query the affected records for transformation
   *
   * @param bc The execution context
   *
   * @return Database.QueryLocator
   */
  public Database.QueryLocator start(Database.BatchableContext bc) {
    FieldSet batchFields = SObjectType.MT_CampaignMonthlyPlanImportData__c.FieldSets.MT_TransformationBatchFields;
    return new MT_CampaignMPImportDataSelector().queryLocatorForAll(MT_FieldSet.getFields(batchFields));
  }

  /**
   * Execute the actual transformation on a chunk of the records.
   *
   * @param bc The execution context
   * @param scope The records to transform
   */
  public void execute(Database.BatchableContext bc, List<MT_CampaignMonthlyPlanImportData__c> scope) {
    try {
      doExecute(scope);
    } catch (Exception e) {
      System.debug(LoggingLevel.ERROR, e);
      loggedErrors.add('Eine Ausnahme ist aufgetreten:\n' + e.getMessage());
      throw e;
    }
  }


  /**
   * Finish the process by sending the email notification to the user.
   *
   * @param bc The execution context
   *
   */
  public void finish(Database.BatchableContext info) {
    String errorList = '';
    if (loggedErrors != null && !loggedErrors.isEmpty()) {
      errorList = '- ' + String.join(loggedErrors, '\n- ') + '\n';
    }

    String body = String.format(System.Label.MT_MP_ImportDataTransformator_EMAIL_ResultBody, new List<String>{
      String.valueOf(processedRecords),
      String.valueOf(updatedRecords),
      String.valueOf(failedRecords),
      errorList
    });

    MT_SystemEmailFactory.getInstance().createNewSystemEmailFor(UserInfo.getUserId()).
      saveAsActivity(false).
      subject(System.Label.MT_MP_ImportDataTransformator_EMAIL_ResultSubject).
      plainTextBody(body).
      treatBodiesAsTemplate(false).
      sendEmail();
  }


  /**
   * Actual execution of imported data, will transform
   * the data and perform and upsert into the database.
   * The <code>importData</code> will be purged from
   * the database afterwards.
   * 
   * Importkey is the key concatenated string using KRSID + Year + Month from MT_CampaignMonthlyPlanImportData__c object, Looks like 1234_2017_08
   *
   * Errors will be silently ignored!
   *
   * @param importData list of imported campaign monthly plans
   */
  private void doExecute(List<MT_CampaignMonthlyPlanImportData__c> importData) {
    Map<String, MT_MediaCampaignMonthlyPlan__c> campaignMonthlyPlanMap = getMonthlyPlansForCampaigns(importData);
    List<MT_MediaCampaignMonthlyPlan__c> monthlyPlansToBeUpdated = new List<MT_MediaCampaignMonthlyPlan__c>();
    List<MT_CampaignMonthlyPlanImportData__c> processedMpImportRecToDelete = new List<MT_CampaignMonthlyPlanImportData__c>();
    processedRecords = importData.size();

    for (MT_CampaignMonthlyPlanImportData__c monthlyPlanImportRec : importData) {
      String importKey = String.valueOf(Integer.valueOf(monthlyPlanImportRec.MT_CampaignId__c)) + '_' + String.valueOf(Integer.valueOf(monthlyPlanImportRec.MT_Year__c)) + '_' + String.valueOf(Integer.valueOf(monthlyPlanImportRec.MT_Month__c));
      if (campaignMonthlyPlanMap != null && campaignMonthlyPlanMap.containsKey(importKey) && monthlyPlanImportRec.MT_CampaignId__c != null && monthlyPlanImportRec.MT_Year__c != null && monthlyPlanImportRec.MT_Month__c != null) {
        MT_MediaCampaignMonthlyPlan__c monthlyPlanRec = campaignMonthlyPlanMap.get(importKey);
        monthlyPlanRec.MT_BMVSponsoring__c = monthlyPlanImportRec.MT_BMVSponsoringComplete__c != null ? monthlyPlanImportRec.MT_BMVSponsoringComplete__c : 0 ;
        monthlyPlanRec.MT_BMVSpot__c = monthlyPlanImportRec.MT_BMVSpotComplete__c != null ? monthlyPlanImportRec.MT_BMVSpotComplete__c : 0 ;
        monthlyPlanRec.MT_FixRevenue__c = monthlyPlanImportRec.MT_RevenueFix__c != null ? monthlyPlanImportRec.MT_RevenueFix__c : 0 ;
        monthlyPlanRec.MT_VariableRevenue1_SoldAmount__c = monthlyPlanImportRec.MT_Amount1__c != null ? monthlyPlanImportRec.MT_Amount1__c : 0 ;
        monthlyPlanRec.MT_VariableRevenue2_SoldAmount__c = monthlyPlanImportRec.MT_Amount2__c != null ? monthlyPlanImportRec.MT_Amount2__c : 0 ;
        monthlyPlanRec.MT_VariableRevenue3_SoldAmount__c = monthlyPlanImportRec.MT_Amount3__c != null ? monthlyPlanImportRec.MT_Amount3__c : 0;
        monthlyPlanRec.MT_VariableRevenue4_SoldAmount__c = monthlyPlanImportRec.MT_Amount4__c != null ? monthlyPlanImportRec.MT_Amount4__c : 0;
        monthlyPlanRec.MT_Probability__c = monthlyPlanImportRec.MT_DealProbabilitySpots__c != null ? monthlyPlanImportRec.MT_DealProbabilitySpots__c : 0 ;

        monthlyPlansToBeUpdated.add(monthlyPlanRec);
      } else {
        //Below will be moved to Error report object in an upcoming user story
        loggedErrors.add(System.Label.MT_MP_ImportDataTransformator_MonthlyPlan_NotFound_Error + importKey);
        failedRecords++;

      }
      processedMpImportRecToDelete.add(monthlyPlanImportRec);
    }

    if (!monthlyPlansToBeUpdated.isEmpty()) {
      updatedRecords += monthlyPlansToBeUpdated.size();
      Update monthlyPlansToBeUpdated;
    }

    if (!processedMpImportRecToDelete.isEmpty()) {
      Delete processedMpImportRecToDelete;
    }

  }

   /**
   * Retrieves a map of the existing campaign monthly plans to be updated
   * identified by their key, which is the concatenated string using
   * KRSID + Year + Month from MT_MediaCampaignMonthlyPlan__c object, looks
   * like 1234_2017_08.
   *
   * @param importData imported campaign monthly plan records
   * @return Map of monthlyPlanKey(krsid_year_month) to Campaign monthly plans
   */
  private Map<String, MT_MediaCampaignMonthlyPlan__c> getMonthlyPlansForCampaigns(List<MT_CampaignMonthlyPlanImportData__c> importData) {
    Set<String> krsIds = new Set<String>();
    Map<String, MT_MediaCampaignMonthlyPlan__c> campaignMpMap = new Map<String, MT_MediaCampaignMonthlyPlan__c>();
    for (MT_CampaignMonthlyPlanImportData__c importDataRec : importData) {
      if (importDataRec.MT_CampaignId__c != null) {
        krsIds.add(String.valueOf(Integer.valueOf(importDataRec.MT_CampaignId__c)));
      }
    }

    FieldSet batchFields = SObjectType.MT_MediaCampaignMonthlyPlan__c.FieldSets.MT_TransformationBatchFields;

    for (MT_MediaCampaignMonthlyPlan__c campaignMonthlyPlan : (List<MT_MediaCampaignMonthlyPlan__c>) new MT_MediaBuildingBlockMonthlyPlanSelector().getRecordsByKrsIds(krsIds, MT_FieldSet.getFields(batchFields))) {
      if (campaignMonthlyPlan.MT_MediaCampaign_ref__r.MT_KRSID__c != null && campaignMonthlyPlan.MT_MediaCampaign_ref__r.MT_KRSID__c != '' && campaignMonthlyPlan.MT_PlanningDate__c != null) {
        String monthlyPlanKey;
        monthlyPlanKey = campaignMonthlyPlan.MT_MediaCampaign_ref__r.MT_KRSID__c + '_' + String.valueOf(campaignMonthlyPlan.MT_PlanningDate__c.year()) + '_' + String.valueOf(campaignMonthlyPlan.MT_PlanningDate__c.month());
        campaignMpMap.put(monthlyPlanKey, campaignMonthlyPlan);
      }
    }

    return campaignMpMap;
  }

}