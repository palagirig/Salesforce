/**
 * Domain class for MT_CampaignMonthlyPlanImportData__c object.
 *
 * @author GP
 */
public with sharing class MT_CampaignMPImportData {

  /**
   * Create a new record with the provided external keys
   * and internal references.
   *
   * @param krsId ID of KRS campaign
   * @param year of KRS campaign
   * @param month of KRS campaign
   * @param revenueFix of KRS campaign
   * @param amount1 of KRS campaign
   * @param amount2 of KRS campaign
   * @param amount3 of KRS campaign
   * @param amount4 of KRS campaign
   * @param bmvSponsoringComplete of KRS campaign
   * @param bmvSpotComplete of KRS campaign
   * @param dealProbabilitySpots of KRS campaign
   * 
   * @return new record
   */
  public static MT_CampaignMonthlyPlanImportData__c create( Integer krsId, Integer planYear, Integer planMonth, decimal revenueFix, 
                                                            Integer amount1, Integer amount2, Integer amount3, Integer amount4, 
                                                            decimal bmvSponsoringComplete, decimal bmvSpotComplete, decimal dealProbabilitySpots) {
    return new MT_CampaignMonthlyPlanImportData__c( MT_CampaignId__c=krsId, MT_Year__c=planYear, MT_Month__c=planMonth, MT_RevenueFix__c=revenueFix, 
                                                    MT_Amount1__c=amount1, MT_Amount2__c=amount2, MT_Amount3__c=amount3, MT_Amount4__c=amount4, 
                                                    MT_BMVSponsoringComplete__c=bmvSponsoringComplete, MT_BMVSpotComplete__c=bmvSpotComplete, MT_DealProbabilitySpots__c=dealProbabilitySpots);
  }
}