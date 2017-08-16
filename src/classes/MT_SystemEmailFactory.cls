/**
 * Factory for creating System Emails.
 *
 * This class' main purpose is to centralize mail handling as well as
 * enable unit tests to check the generated emails.
 */
public class MT_SystemEmailFactory {
  @TestVisible
  private static Boolean ALLOW_CONSTRUCTOR_CALL = false;

  @TestVisible
  private static MT_SystemEmailFactory INSTANCE;


  /**
   * Constructor, DO NOT CALL DIRECTLY. It is only visible
   * for testing purpose as classes with private constructors
   * cannot be mocked.
   */
  public MT_SystemEmailFactory() {
    if (!ALLOW_CONSTRUCTOR_CALL) {
      throw new MT_SystemEmailFactoryException('A direct constructor call is not allowed!');
    }
  }


  /**
   * Returns the instance of the factory.
   *
   * @return instance
   */
  public static MT_SystemEmailFactory getInstance() {
    if (MT_SystemEmailFactory.INSTANCE == null) {
      ALLOW_CONSTRUCTOR_CALL = true;
      MT_SystemEmailFactory.INSTANCE = new MT_SystemEmailFactory();
      ALLOW_CONSTRUCTOR_CALL = false;
    }
    return MT_SystemEmailFactory.INSTANCE;
  }


  /**
   * Creates a new System Email for the provided recipients.
   *
   * @param addresses list of email addresses
   * @return new system email instance
   */
  public MT_SystemEmail createNewSystemEmailFor(List<String> addresses) {
    return new MT_SystemEmail(addresses);
  }


  /**
   * Creates a new System Email for the provided target Object.
   *
   * @param targetId ID of target object
   * @return new system email instance
   */
  public MT_SystemEmail createNewSystemEmailFor(Id targetId) {
    return new MT_SystemEmail(targetId);
  }

  @TestVisible
  private class MT_SystemEmailFactoryException extends Exception {}
}