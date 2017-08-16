/**
 * Unit test for <code>MT_CampaignMPImportData</code> domain class.
 *
 * @author GP
 */
@IsTest
private class MT_CampaignMPImportData_Test {
  @IsTest
  private static void testCreate() {
    Integer krsId = 42;
    Integer planYear = 2017; 
    Integer planMonth = 08; 
    decimal revenueFix = 9999;
    Integer amount1 = 991; 
    Integer amount2 = 992;
    Integer amount3 = 993;
    Integer amount4 = 994;
    decimal bmvSponsoringComplete = 9991;
    decimal bmvSpotComplete = 9992; 
    decimal dealProbabilitySpots = 85;

    Test.startTest();
    MT_CampaignMonthlyPlanImportData__c mpImportRec = MT_CampaignMPImportData.create( krsId, planYear, planMonth, revenueFix, 
                                                            								amount1, amount2, amount3, amount4, 
                                                            								bmvSponsoringComplete, bmvSpotComplete, dealProbabilitySpots);
    Test.stopTest();

    System.assertNotEquals(null, mpImportRec, 'No record was created');
    System.assertEquals(krsId, mpImportRec.MT_CampaignId__c, 'KRS ID is not set on new record');
    System.assertEquals(planYear, mpImportRec.MT_Year__c, 'Year is not set on new record');
    System.assertEquals(planMonth, mpImportRec.MT_Month__c, 'Month is not set on new record');
    System.assertEquals(revenueFix, mpImportRec.MT_RevenueFix__c, 'Revenue Fix is not set on new record');
    System.assertEquals(amount1, mpImportRec.MT_Amount1__c, 'Amount1 is not set on new record');
    System.assertEquals(amount2, mpImportRec.MT_Amount2__c, 'Amount2 is not set on new record');
    System.assertEquals(amount3, mpImportRec.MT_Amount3__c, 'Amount3 is not set on new record');
    System.assertEquals(amount4, mpImportRec.MT_Amount4__c, 'Amount4 is not set on new record');
    System.assertEquals(bmvSponsoringComplete, mpImportRec.MT_BMVSponsoringComplete__c, 'BMV Sponsoring Complete is not set on new record');
    System.assertEquals(bmvSpotComplete, mpImportRec.MT_BMVSpotComplete__c, 'BMV Spot Complete is not set on new record');
    System.assertEquals(dealProbabilitySpots, mpImportRec.MT_DealProbabilitySpots__c, 'Deal Probability Spots is not set on new record');
  }
}
