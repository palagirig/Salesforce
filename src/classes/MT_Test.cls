/**
 * Test utility for Media Transparency to
 * handle basic test stuff like creating
 * test data.
 *
 */
@isTest
public class MT_Test {
  @IsTest
  private static void selfTest() {
    Test.startTest();
    Init();
    Test.stopTest();

    // just validate that all DB operation went fine without any exception
  }

  public static void Init() {
    MT_MediaCampaign__c mc = initMediaCampaignMonthlyPlanPreparationTestData().get(0);

    MT_ProSaOrder__c pso = MT_ProSaOrders.create(mc, '123334');
    insert pso;

    MT_ForecastVersion__c fver = MT_MediaForecastVersions.create('Test Version');
    insert fver;

    MT_ForecastValue__c fv = MT_MediaForecastValues.create(mc.MT_MediaCampaignType_ref__r, fver);
    fv.MT_April__c = 1000;
    insert fv;

    MT_MediaFlight__c mf = MT_MediaFlights.create(
      Date.today().addMonths(-5),
      Date.today().addMonths(7),
    [SELECT Id FROM MT_MediaCampaignMonthlyPlan__c LIMIT 1]
    );
    insert mf;

    MT_AdvertisedMediaProduct__c amp = MT_AdvertisedMediaProducts.create(mc.MT_Opportunity_ref__r.Account, 'Test Product', '12345');
    insert amp;

    MT_MediaMotive__c mm = MT_MediaMotives.create(amp, 'Test Motive');
    mm.MT_AgencyProductNumber__c = '12345';
    insert mm;

    MT_MediaFlightMotiveAllocation__c mfma = MT_MediaFlightMotiveAllocations.create(
      mf,
      mm,
      amp);
    insert mfma;

  }

  /**
   * Prepares all test data structures that are required to create Media Campaigns.
   *
   * @return created and inserted test data with references filled
   */
  public static List<P7S1_OpportunityApproval__c> initMediaCampaignPreparationTestData() {
    List<P7S1_OpportunityApproval__c> oppApprovals = initOpportunityApprovalTestData();

    MT_MediaCampaignType__c mct = MT_MediaCampaignTypes.create('Test', true, oppApprovals.get(0).MT_Asset_ref__r);
    mct.MT_Type__c = MT_Constants.getInstance().MediaCampaignType_External;
    insert mct;

    return oppApprovals;
  }

  /**
   * Initializes all the required test data structure for campaign imports.
   *
   * @return created campaign import data with all references filled
   */
  public static List<MT_CampaignImportData__c> initCampaignImportTestData() {
    List<P7S1_OpportunityApproval__c> oppApprovals = initMediaCampaignPreparationTestData();

    List<MT_CampaignImportData__c> testData = createCampaignImportTestData(oppApprovals);
    insert testData;
    return testData;
  }

  /**
   * Creates campaign import records referencing the provided opportunity
   * approvals <code>oppApprovals</code>. The records are not inserted into
   * the database.
   *
   * @param oppApprovals list of opportunity approvals
   * @return list of created but not inserted campaign import data
   */
  public static List<MT_CampaignImportData__c> createCampaignImportTestData(List<P7S1_OpportunityApproval__c> oppApprovals) {
    List<MT_CampaignImportData__c> testData = new List<MT_CampaignImportData__c>();

    // FIXME increase to 30 once 1:n relationship between oppty approval and campaign is established with MT-413
    final Integer importDataCount = 2; // = 30;
    for (Integer i = 0; i < importDataCount; i++) {
      Integer oppAppIndex = Math.mod(i, oppApprovals.size());
      MT_CampaignImportData__c rec = MT_CampaignImportData.create(i, oppApprovals.get(oppAppIndex).P7S1_Opportunity__c);
      rec.MT_CampaignName__c = 'KRS test import campaign #' + i;
      testData.add(rec);
    }

    return testData;
  }

  /**
   * Prepares all test data structures that are required to create Monthly Plans.
   *
   * @return created and inserted test data with references filled
   */
  public static List<MT_MediaCampaign__c> initMediaCampaignMonthlyPlanPreparationTestData() {
    List<P7S1_OpportunityApproval__c> oppApprovals = initMediaCampaignPreparationTestData();

    P7S1_OpportunityApproval__c oppApp = oppApprovals.get(0);

    MT_MediaCampaignType__c mct = [
      SELECT Id
      FROM MT_MediaCampaignType__c
      WHERE MT_Type__c = :MT_Constants.getInstance().MediaCampaignType_External
      AND MT_IsActive__c = true
      AND MT_Asset_ref__c = :oppApp.MT_Asset_ref__c
      LIMIT 1
    ];

    MT_MediaCampaign__c mc = MT_MediaCampaigns.create(oppApp.P7S1_Opportunity__r, oppApp, mct);
    mc.MT_Opportunity_ref__r = oppApp.P7S1_Opportunity__r;
    mc.MT_OpportunityApproval_ref__r = oppApp;
    mc.MT_MediaCampaignType_ref__r = mct;
    mc.RecordTypeId = MT_MediaCampaigns.getRecordTypeIdForExternalCampaign();
    mc.MT_RunTimeTVStart__c = oppApp.MT_RunTimeTVStart__c;
    mc.MT_RunTimeTVEnd__c = oppApp.MT_RunTimeTVEnd__c;
    mc.MT_BmvTv__c = oppApp.P7S1_BmvTv__c; // WE NEED TO DEFINE THAT SPECIFICALLY AND MANUALLY IN TEST. Usually this value is prepopulated in standard UI. The trigger only handles null values but not zero values. For purpose of this test, it must be assigned manually
    mc.MT_HasMediaTV__c = true;
    mc.MT_KRSID__c = '12345';
    insert mc;

    return new List<MT_MediaCampaign__c>{ mc };
  }

  /**
   * Initializes all the required test data structure for campaign monthly plan imports.
   *
   * @returns created monthly plan import data with all references filled
   */
  public static List<MT_CampaignMonthlyPlanImportData__c> initCampaignMonthlyPlanImportTestData() {
    List<MT_MediaCampaign__c> campaigns = initMediaCampaignMonthlyPlanPreparationTestData();

    List<MT_CampaignMonthlyPlanImportData__c> testData = createCampaignMonthlyPlanImportData(campaigns);
    insert testData;
    return testData;
  }

  /**
   * Creates campaign monthly plan import records referencing the provided <code>campaigns</code>.
   * The records are not inserted into the database.
   *
   * @param campaigns list of campaigns
   * @return list of created but not inserted campaign monthly plan import data
   */
  public static List<MT_CampaignMonthlyPlanImportData__c> createCampaignMonthlyPlanImportData(List<MT_MediaCampaign__c> campaigns) {
    List<MT_CampaignMonthlyPlanImportData__c> testData = new List<MT_CampaignMonthlyPlanImportData__c>();

    for (MT_MediaCampaign__c campaign : campaigns) {
      final Integer noOfMonths = campaign.MT_RunTimeTVStart__c.monthsBetween(campaign.MT_RunTimeTVEnd__c);
      for (Integer i = 0; i < noOfMonths; i++) {
        MT_CampaignMonthlyPlanImportData__c rec = MT_CampaignMPImportData.create(
          Integer.valueOf(campaign.MT_KRSID__c),
          campaign.MT_RunTimeTVStart__c.addMonths(i).year(),
          campaign.MT_RunTimeTVStart__c.addMonths(i).month(),
          0, // revenueFix
          0, // amount1
          0, // amount2
          0, // amount3
          0, // amount4
          0, // bvmSponsoringComplete
          0, // bvmSpotComplete
          0  // dealProbabilitySpots
        );
        testData.add(rec);
      }
    }

    return testData;
  }

  /**
   * Initializes all the required test data structure down to Opportunity Approvals.
   *
   * @return created and inserted test data with references filled
   */
  public static List<P7S1_OpportunityApproval__c> initOpportunityApprovalTestData() {
    Account acc = new Account(
      Name = 'Test'
    );
    insert acc;

    List<Schema.PicklistEntry> oppStagePicklistEntries = Opportunity.StageName.getDescribe().getPicklistValues();

    Opportunity opp = new Opportunity(
      Name = 'TestOpp1',
      AccountId = acc.Id,
      Account = acc,
      StageName = oppStagePicklistEntries.get(0).getValue(),
      CloseDate = Date.today().addMonths(15),
      P7S1_HasMediaTV__c = true
    );
    Opportunity opp2 = new Opportunity(
      Name = 'TestOpp2',
      AccountId = acc.Id,
      Account = acc,
      StageName = oppStagePicklistEntries.get(0).getValue(),
      CloseDate = Date.today().addMonths(15),
      P7S1_HasMediaTV__c = true
    );

    insert new List<Opportunity> { opp, opp2 };

    P7S1_Unit__c un = MT_Units.create('D&A', 'Test Unit');
    insert un;

    P7S1_Asset__c ass = MT_Assets.create(un, 'New Asset');
    insert ass;

    P7S1_OpportunityApproval__c oppApp = new P7S1_OpportunityApproval__c(
      P7S1_Opportunity__c = opp.Id,
      P7S1_Opportunity__r = opp,
      Name = 'TestOppApp',
      P7S1_BmvTv__c = 100000,
      P7S1_BmvTvCustomerIntegration__c = 30,
      P7S1_Mn3TvCustomerIntegration__c = 20,
      P7S1_TvSpotLengthCustomer__c = 10,
      P7S1_TvSpotLength__c = 30,
      MT_RunTimeTVEnd__c = Date.today().addMonths(2),
      MT_RunTimeTVStart__c = Date.today().addMonths(-2),
      P7S1_internerPartner__c = ass.Name,
      MT_Asset_ref__c = ass.Id,
      MT_Asset_ref__r = ass
    );
    P7S1_OpportunityApproval__c oppApp2 = new P7S1_OpportunityApproval__c(
      P7S1_Opportunity__c = opp2.Id,
      P7S1_Opportunity__r = opp2,
      Name = 'TestOppApp2',
      P7S1_BmvTv__c = 100000,
      P7S1_BmvTvCustomerIntegration__c = 30,
      P7S1_Mn3TvCustomerIntegration__c = 20,
      P7S1_TvSpotLengthCustomer__c = 10,
      P7S1_TvSpotLength__c = 30,
      MT_RunTimeTVEnd__c = Date.today().addMonths(2),
      MT_RunTimeTVStart__c = Date.today().addMonths(-2),
      P7S1_internerPartner__c = ass.Name,
      MT_Asset_ref__c = ass.Id,
      MT_Asset_ref__r = ass
    );

    List<P7S1_OpportunityApproval__c> oppApps = new List<P7S1_OpportunityApproval__c> { oppApp, oppApp2 };
    insert oppApps;
    return oppApps;
  }

  /**
   * Provides mocks for unit testing. Extend this class
   * to enhance stubbing functionality.
   */
  public virtual class MockProvider implements System.StubProvider {
    /**
     * Maps the stubbed Object instance to a map of method
     * invocations (method name -> invocations).
     */
    protected Map<Object,Map<String,List<MT_Test.MethodCall>>> invocations = new Map<Object,Map<String,List<MT_Test.MethodCall>>>();


    public Object handleMethodCall(Object stubbedObject, String stubbedMethodName, Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
      if (!invocations.containsKey(stubbedObject)) {
        invocations.put(stubbedObject, new Map<String,List<MT_Test.MethodCall>>());
      }
      MT_Test.MethodCall mc = new MT_Test.MethodCall(stubbedObject, stubbedMethodName, returnType, listOfParamTypes, listOfParamNames, listOfArgs);
      if (!invocations.get(stubbedObject).containsKey(stubbedMethodName)) {
        invocations.get(stubbedObject).put(stubbedMethodName, new List<MT_Test.MethodCall>());
      }
      invocations.get(stubbedObject).get(stubbedMethodName).add(mc);

      mc.returnValue = getMethodCallReturnValue(stubbedObject, stubbedMethodName, returnType, listOfParamTypes, listOfParamNames, listOfArgs);
      return mc.returnValue;
    }

    /**
     * Returns the invocations by stubbed object and
     * method name.
     *
     * @param stubbedObject stubbed object
     * @param stubbedMethodName stubbed method name
     * @return List of recorded method calls
     */
    public List<MT_Test.MethodCall> getInvocations(Object stubbedObject, String stubbedMethodName) {
      if (invocations.containsKey(stubbedObject) && invocations.get(stubbedObject).containsKey(stubbedMethodName)) {
        return invocations.get(stubbedObject).get(stubbedMethodName);
      }
      return new List<MT_Test.MethodCall>();
    }


    /**
     * Determines the return value for a stubbed method call.
     * Returns <code>null</code>, overwrite when required.
     *
     * @param stubbedObject the stubbed object
     * @param stubbedMethodName stubbed method
     * @param returnType type of expected return value
     * @param listOfParamNames list of method param types
     * @param listOfParamNames method parameter names
     * @param listOfArgs provided method parameter values
     * @return always <code>null</code>
     */
    protected virtual Object getMethodCallReturnValue(Object stubbedObject, String stubbedMethodName, Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
      return null;
    }

    /**
     * Asserts that the method <code>stubbedMethodName</code>
     * has been called at least once on the <code>stubbedObject</code>.
     *
     * @param stubbedObject the stubbed object
     * @param stubbedMethodName stubbed method
     */
    public void assertMethodWasCalled(Object stubbedObject, String stubbedMethodName) {
      System.assertEquals(true, invocations.containsKey(stubbedObject), 'Stubbed object "' + stubbedObject + '" was never used');
      System.assertEquals(true, invocations.get(stubbedObject).containsKey(stubbedMethodName), 'method "' + stubbedMethodName + '" on object "' + stubbedObject + '" was never called');
    }

    /**
     * Asserts that the method <code>stubbedMethodName</code>
     * has never been called on the <code>stubbedObject</code>.
     *
     * @param stubbedObject the stubbed object
     * @param stubbedMethodName stubbed method
     */
    public void assertMethodWasNotCalled(Object stubbedObject, String stubbedMethodName) {
      if (invocations.containsKey(stubbedObject)) {
        System.assertEquals(false, invocations.get(stubbedObject).containsKey(stubbedMethodName), 'method "' + stubbedMethodName + '" on object "' + stubbedObject + '" was called');
      }
    }

    /**
     * Asserts that the method <code>stubbedMethodName</code>
     * has been called <code>numberOfCalls</code> times on the
     * <code>stubbedObject</code>.
     *
     * @param stubbedObject the stubbed object
     * @param stubbedMethodName stubbed method
     * @param numberOfCalls number of method calls
     */
    public void assertMethodWasCalled(Object stubbedObject, String stubbedMethodName, Integer numberOfCalls) {
      if (numberOfCalls == 0) {
        assertMethodWasNotCalled(stubbedMethodName, stubbedMethodName);
      } else {
        assertMethodWasCalled(stubbedObject, stubbedMethodName);
        System.assertEquals(numberOfCalls, invocations.get(stubbedObject).get(stubbedMethodName).size(), 'method "' + stubbedMethodName + '" on object "' + stubbedObject + '" was called invalid number of times');
      }
    }

    /**
     * Asserts that the method <code>call</code> was made at
     * least once.
     *
     * @param call method call
     */
    public void assertMethodWasCalled(MT_Test.MethodCall call) {
      assertMethodWasCalled(call.obj, call.methodName);
      for (MT_Test.MethodCall callTest : invocations.get(call.obj).get(call.methodName)) {
        if (callTest.equals(call)) {
          return;
        }
      }
      System.assertEquals(true, false, 'method "' + call.methodName + '" on object "' + call.obj + '" was never called with the provided parameters: ' + call);
    }
  }


  /**
   * Container for a mocked method call.
   */
  public class MethodCall {
    private Object obj;
    private String methodName;
    private Type returnType;
    private List<Type> paramTypes;
    private List<String> paramNames;
    private List<Object> paramValues;

    private Object returnValue;

    /**
     * Constructor.
     *
     * @param obj object on which call is made
     * @param methodName method name
     * @param returnType expected method return type
     * @param paramTypes method parameter types
     * @param paramNames method parameter names
     * @param paramValues providede method call parameter values
     */
    public MethodCall(Object obj, String methodName, Type returnType, List<Type> paramTypes, List<String> paramNames, List<Object> paramValues) {
      this.obj = obj;
      this.methodName = methodName;
      this.returnType = returnType;
      this.paramTypes = paramTypes;
      this.paramNames = paramNames;
      this.paramValues = paramValues;
    }

    public Boolean equals(Object obj) {
      MT_Test.MethodCall other = (MT_Test.MethodCall) obj;
      return this.obj.equals(other.obj) &&
        this.methodName.equals(other.methodName) &&
        this.returnType.equals(other.returnType) &&
        this.paramTypes.equals(other.paramTypes) &&
        //this.paramNames.equals(other.paramNames) &&
        this.paramValues.equals(other.paramValues);
      // do not compare return value, as this is only an internal reference
    }

    /**
     * Gets the return value of the executed method call.
     *
     * @return return value
     */
    public Object getReturnValue() {
      return this.returnValue;
    }
  }
}