/**
 * Unit test for System Email class.
 */
@IsTest
public class MT_SystemEmail_Test {
  public final static String MT_SYSTEMEMAIL_SUBJECT_METHOD = 'subject';
  public final static String MT_SYSTEMEMAIL_PLAINTEXTBODY_METHOD = 'plainTextBody';
  public final static String MT_SYSTEMEMAIL_SENDEMAIL_METHOD = 'sendEmail';

  @IsTest
  private static void testConstructor() {
    List<String> recipients = null;
    MT_SystemEmail mail = new MT_SystemEmail(recipients);
    System.assertEquals(recipients, mail.toAddresses, 'Recipients not set correctly.');

    recipients = new List<String>();
    mail = new MT_SystemEmail(recipients);
    System.assertEquals(recipients, mail.toAddresses, 'Recipients not set correctly.');

    recipients.add(null);
    mail = new MT_SystemEmail(recipients);
    System.assertEquals(recipients, mail.toAddresses, 'Recipients not set correctly.');

    recipients.add('test@example.com');
    mail = new MT_SystemEmail(recipients);
    System.assertEquals(recipients, mail.toAddresses, 'Recipients not set correctly.');
  }


  @IsTest
  private static void testBuild() {
    final List<String> recipients = new List<String> { 'test@example.com', 'test2@example.com' };
    final String senderName = 'Manny Myers';
    final String subject = 'test subject';
    final String htmlBody = '<b>test HTML body</b>';
    final String textBody = 'test TEXT body';
    final Boolean useSignature = true;
    final String replyTo = 'testabc@example.com';
    final Messaging.EmailFileAttachment fileAttachment1 = new Messaging.EmailFileAttachment();
    final Messaging.EmailFileAttachment fileAttachment2 = new Messaging.EmailFileAttachment();
    final Boolean saveAsActivity = true;
    final Boolean treatBodiesAsTemplate = true;


    MT_SystemEmail mail = new MT_SystemEmail(recipients).
        senderDisplayName(senderName).
        subject(subject).
        htmlBody(htmlBody).
        plainTextBody(textBody).
        useSignature(useSignature).
        replyTo(replyTo).
        fileAttachment(fileAttachment1).
        fileAttachment(fileAttachment2).
        saveAsActivity(saveAsActivity).
        treatBodiesAsTemplate(treatBodiesAsTemplate);

    Test.startTest();
    Messaging.SingleEmailMessage msg = mail.build();
    Test.stopTest();

    System.assertEquals(recipients, msg.getToAddresses(), 'wrong recipients');
    System.assertEquals(senderName, msg.getSenderDisplayName(), 'wrong sender display name');
    System.assertEquals(subject, msg.getSubject(), 'wrong subject');
    System.assertEquals(htmlBody, msg.getHtmlBody(), 'wrong HTML body');
    System.assertEquals(textBody, msg.getPlainTextBody(), 'wrong plain text body');
    System.assertEquals(useSignature, msg.getUseSignature(), 'wrong use signature setting');
    System.assertEquals(replyTo, msg.getReplyTo(), 'wrong reply to address');
    System.assertEquals(new List<Messaging.EmailFileAttachment> { fileAttachment1, fileAttachment2 }, msg.getFileAttachments(), 'wrong attachments');
    System.assertEquals(saveAsActivity, msg.getSaveAsActivity(), 'wrong save as activity setting');
    System.assertEquals(treatBodiesAsTemplate, msg.isTreatBodiesAsTemplate(), 'wrong treat bodies as template setting');
  }


  @IsTest
  private static void testBuildWithNulls() {
    List<String> recipients = null;
    MT_SystemEmail mail = new MT_SystemEmail(recipients).
      senderDisplayName(null).
      subject(null).
      htmlBody(null).
      plainTextBody(null).
      replyTo(null).
      fileAttachment(null).
      fileAttachment(null);

    Test.startTest();
    Messaging.SingleEmailMessage msg = mail.build();
    Test.stopTest();

    System.assertEquals(null, msg.getToAddresses(), 'wrong recipients');
    System.assertEquals(null, msg.getSenderDisplayName(), 'wrong sender display name');
    System.assertEquals(null, msg.getSubject(), 'wrong subject');
    System.assertEquals(null, msg.getHtmlBody(), 'wrong HTML body');
    System.assertEquals(null, msg.getPlainTextBody(), 'wrong plain text body');
    System.assertEquals(null, msg.getReplyTo(), 'wrong reply to address');
    System.assertEquals(null, msg.getFileAttachments(), 'wrong attachments');
  }


  @IsTest
  private static void testBuildWithDefaults() {
    final List<String> recipients = new List<String> { 'test@example.com', 'test2@example.com' };

    MT_SystemEmail mail = new MT_SystemEmail(recipients);

    Test.startTest();
    Messaging.SingleEmailMessage msg = mail.build();
    Test.stopTest();

    System.assertEquals(UserInfo.getName(), msg.getSenderDisplayName(), 'wrong sender display name');
    System.assertEquals('', msg.getSubject(), 'wrong subject');
    System.assertEquals('', msg.getHtmlBody(), 'wrong HTML body');
    System.assertEquals('', msg.getPlainTextBody(), 'wrong plain text body');
    System.assertEquals(false, msg.getUseSignature(), 'wrong use as signature setting');
    System.assertEquals(UserInfo.getUserEmail(), msg.getReplyTo(), 'wrong reply to address');
    System.assertEquals(null, msg.getFileAttachments(), 'wrong attachments');
    System.assertEquals(false, msg.getSaveAsActivity(), 'wrong save as activity setting');
    System.assertEquals(false, msg.isTreatBodiesAsTemplate(), 'wrong treat bodies as template setting');
  }


  @IsTest
  private static void testSendEmail() {
    final List<String> recipients = new List<String> { 'test@example.com', 'test2@example.com' };

    MT_SystemEmail mail = new MT_SystemEmail(recipients);

    Test.startTest();
    mail.sendEmail();
    Test.stopTest();

    // code coverage only, nothing to assert
  }


  /**
   * A mock provider for this class.
   */
  public virtual class MT_SystemEmailMockProvider extends MT_Test.MockProvider {

    protected virtual override Object getMethodCallReturnValue(Object stubbedObject, String stubbedMethodName, Type returnType, List<Type> listOfParamTypes, List<String> listOfParamNames, List<Object> listOfArgs) {
      if (stubbedObject instanceof MT_SystemEmail) {
        return stubbedObject;
      }
      return super.getMethodCallReturnValue(stubbedObject, stubbedMethodName, returnType, listOfParamTypes, listOfParamNames, listOfArgs);
    }
  }
}