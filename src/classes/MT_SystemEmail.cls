/**
 * Utility for sending emails.
 */
public class MT_SystemEmail {

  @TestVisible
  private final List<String> toAddresses;

  @TestVisible
  private final Id targetId;

  //optional parameters set to default
  @TestVisible
  private String subject = '';

  @TestVisible
  private String htmlBody = '';

  @TestVisible
  private String plainTextBody = '';

  @TestVisible
  private Boolean treatBodiesAsTemplate = false;

  @TestVisible
  private List<Messaging.EmailFileAttachment> fileAttachments;

  @TestVisible
  private String senderDisplayName = UserInfo.getName();

  @TestVisible
  private Boolean useSignature = false;

  @TestVisible
  private String replyTo = UserInfo.getUserEmail();

  @TestVisible
  private Boolean saveAsActivity = false;


  /**
   * Creates a new instance for the given recipients. This is an internal
   * method, please use MT_SystemEmailFactory.createNewSystemEmailFor(List<String>)
   * only.
   *
   * @param addresses list of recipients
   */
  public MT_SystemEmail(List<String> addresses) {
    this.toAddresses = addresses;
  }


  /**
   * Creates a new instance for the given target Object ID. This is an internal
   * method, please use MT_SystemEmailFactory.createNewSystemEmailFor(Id)
   * only.
   *
   * @param targetId ID of target object
   */
  public MT_SystemEmail(Id targetId) {
    this.targetId = targetId;
  }


  /**
   * Sets the sender display name to <code>val</code>, defaults
   * to the current user's name.
   *
   * @param val sender display name
   * @return current instance of the system mail
   */
  public MT_SystemEmail senderDisplayName(String val) {
    senderDisplayName = val;
    return this;
  }


  /**
   * Sets the subject to <code>val</code>, defaults
   * to empty subject.
   *
   * @param val subject
   * @return current instance of the system mail
   */
  public MT_SystemEmail subject(String val) {
    subject = val;
    return this;
  }


  /**
   * Sets the mail's HTML body to <code>val</code>, defaults
   * to empty string.
   *
   * @param val HTML body
   * @return current instance of the system mail
   */
  public MT_SystemEmail htmlBody(String val) {
    htmlBody = val;
    return this;
  }


  /**
   * Enables or disables use of user's signature, defaults
   * to <code>false</code>.
   *
   * @param bool enable or disable signature
   * @return current instance of the system mail
   */
  public MT_SystemEmail useSignature(Boolean bool) {
    useSignature = bool;
    return this;
  }


  /**
   * Enables or disables storage of the email as activity,
   * defaults to <code>false</code>.
   *
   * @param bool enable or disable save as activity
   * @return current instance of the system mail
   */
  public MT_SystemEmail saveAsActivity(Boolean bool) {
    saveAsActivity = bool;
    return this;
  }


  /**
   * Enables or disables treatment of bodies as template,
   * defaults to <code>false</code>.
   *
   * @param bool enable or disable treatment of bodies as template
   * @return current instance of the system mail
   */
  public MT_SystemEmail treatBodiesAsTemplate(Boolean bool) {
    treatBodiesAsTemplate = bool;
    return this;
  }


  /**
   * Sets the reply to address to <code>val</code>, defaults
   * to the current user's email address.
   *
   * @param val reply to email address
   * @return current instance of the system mail
   */
  public MT_SystemEmail replyTo(String val) {
    replyTo = val;
    return this;
  }


  /**
   * Sets the plain text body to <code>val</code>, defaults
   * to empty string.
   *
   * @param val plain text body
   * @return current instance of the system mail
   */
  public MT_SystemEmail plainTextBody(String val) {
    plainTextBody = val;
    return this;
  }


  /**
   * Adds the provided file attachment <code>val</code>.
   *
   * @param val attachment
   * @return current instance of the system mail
   */
  public MT_SystemEmail fileAttachment(Messaging.EmailFileAttachment val) {
    if (val != null) {
      if (fileAttachments == null) {
        fileAttachments = new List<Messaging.EmailFileAttachment>();
      }
      fileAttachments.add(val);
    }
    return this;
  }


  /**
   * Send out the email.
   */
  public void sendEmail() {
    Messaging.sendEmail(new List<Messaging.SingleEmailMessage> { build() });
  }


  @TestVisible
  private Messaging.SingleEmailMessage build() {
    Messaging.SingleEmailMessage singleEmailMessage = new Messaging.SingleEmailMessage();
    if (this.toAddresses != null) {
      singleEmailMessage.setToAddresses(this.toAddresses);
    } else {
      singleEmailMessage.setTargetObjectId(this.targetId);
    }
    singleEmailMessage.setSenderDisplayName(this.senderDisplayName);
    singleEmailMessage.setSubject(this.subject);
    singleEmailMessage.setHtmlBody(this.htmlBody);
    singleEmailMessage.setUseSignature(this.useSignature);
    singleEmailMessage.setReplyTo(this.replyTo);
    singleEmailMessage.setPlainTextBody(this.plainTextBody);
    if (this.fileAttachments != null) {
      singleEmailMessage.setFileAttachments(this.fileAttachments);
    }
    singleEmailMessage.setSaveAsActivity(this.saveAsActivity);
    singleEmailMessage.setTreatBodiesAsTemplate(this.treatBodiesAsTemplate);
    return singleEmailMessage;
  }
}