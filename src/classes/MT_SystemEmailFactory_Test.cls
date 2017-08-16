/**
 * Test class for System Email Factory.
 */
@IsTest
public class MT_SystemEmailFactory_Test {
  public final static String MT_SYSTEMEMAILFACTORY_CREATE_MAIL_METHOD = 'createNewSystemEmailFor';

  @IsTest
  private static void testConstructor() {
    try {
      new MT_SystemEmailFactory();
      System.assertEquals(false, true, 'A direct constructor call is not allowed, but was possible.');
    } catch (MT_SystemEmailFactory.MT_SystemEmailFactoryException ex) {}
  }

  @IsTest
  private static void testGetInstance() {
    Test.startTest();
    MT_SystemEmailFactory factory = MT_SystemEmailFactory.getInstance();
    Test.stopTest();

    System.assertNotEquals(null, factory, 'Instance call should not return null');
  }

  @IsTest
  private static void testGetInstanceSecondInvocation() {
    MT_SystemEmailFactory factory1 = MT_SystemEmailFactory.getInstance();

    Test.startTest();
    MT_SystemEmailFactory factory2 = MT_SystemEmailFactory.getInstance();
    Test.stopTest();

    System.assertNotEquals(null, factory2, 'Instance call should not return null');
    System.assert(factory1 == factory2, 'Second call should not return a new instance, but reuse the existing singleton one.');
  }

  @IsTest
  private static void testCreateNewSystemEmailForRecipients() {
    MT_SystemEmailFactory factory = MT_SystemEmailFactory.getInstance();

    List<String> recipients = new List<String>{'test1@example.com', 'test2@example.com'};

    Test.startTest();
    MT_SystemEmail mail = factory.createNewSystemEmailFor(recipients);
    Test.stopTest();

    System.assertNotEquals(null, mail, 'null instance');
    System.assertEquals(recipients, mail.toAddresses, 'recipients not provided to mail instance');
  }

  @IsTest
  private static void testCreateNewSystemEmailForTargetObject() {
    MT_SystemEmailFactory factory = MT_SystemEmailFactory.getInstance();

    Id targetId = UserInfo.getUserId();

    Test.startTest();
    MT_SystemEmail mail = factory.createNewSystemEmailFor(targetId);
    Test.stopTest();

    System.assertNotEquals(null, mail, 'null instance');
    System.assertEquals(targetId, mail.targetId, 'target ID not provided to mail instance');
  }


  /**
   * A mock provider for this class.
   */
  public virtual class MT_SystemEmailFactoryMockProvider extends MT_SystemEmail_Test.MT_SystemEmailMockProvider {

    protected virtual override Object getMethodCallReturnValue(Object stubbedObject, String stubbedMethodName, Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
      if (stubbedObject instanceof MT_SystemEmailFactory) {
        if (stubbedMethodName == MT_SystemEmailFactory_Test.MT_SYSTEMEMAILFACTORY_CREATE_MAIL_METHOD) {
          Object retVal = Test.createStub(returnType, this);
          return retVal;
        }
      }
      return super.getMethodCallReturnValue(stubbedObject, stubbedMethodName, returnType, listOfParamTypes, listOfParamNames, listOfArgs);
    }
  }
}