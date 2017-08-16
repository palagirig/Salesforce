/*
* Name:  		MT_MediaCampaignService
*
* Purpose: 	Service class for MT_MediaCampaign__c object
* 
* History
* -------
* Date		    AUTHOR						    DETAIL
* 12.12.2016	Duc Nguyen Tien       Initial architecture & development
* 21.04.2017  Falco Aulitzky        Javadoc styled documentation added
*/
global with Sharing class MT_MediaCampaignService {

  /*
  * static method to call the selector which queries the object and fields that were demanded
  *
  * @param Set<ID> campIds: Set of MediaTransparencyCampaign ids
  * @return a list with MediaTransparencyCampaign objects
  */
  global static List<MT_MediaCampaign__c> getMediaCampaignsByIds(Set<ID> campIds) {
    return MT_MediaCampaignService.getMediaCampaignsByIds(campIds, MT_FieldSet.getFields(SObjectType.MT_MediaCampaign__c.FieldSets.MT_ContextFields));
  }

  /*
  * static method to call the selector which queries the object and fields that were demanded
  *
  * @param  Set<ID> campIds: Set of MediaTransparencyCampaign ids
  *         Set<String> fields: Set of fields that are demanded by the caller
  * @return a list with MediaTransparencyCampaign objects
  */
  global static List<MT_MediaCampaign__c> getMediaCampaignsByIds(Set<ID> campIds, Set<String> fields) {
    return new MT_MediaCampaignSelector().getRecordsByIds(campIds, fields);
  }

  /*
  * static method to call the selector which queries the object and fields that were demanded
  *
  * @param Set<ID> mctIds: Set of MediaCampaignType ids
  * @return a list with MediaTransparencyCampaign objects
  */
  global static List<MT_MediaCampaign__c> getMediaCampaignsByMediaCampaignTypeIds(Set<ID> mctIds) {
    return MT_MediaCampaignService.getMediaCampaignsByMediaCampaignTypeIds(mctIds, MT_FieldSet.getFields(SObjectType.MT_MediaCampaign__c.FieldSets.MT_ContextFields));
  }

  /*
  * static method to call the selector which queries the object and fields that were demanded
  *
  * @param  Set<ID> mctIds: Set of MediaCampaignType ids
  *         Set<String> fields: Set of fields that are demanded by the caller
  * @return a list with MediaTransparencyCampaign objects
  */
  global static List<MT_MediaCampaign__c> getMediaCampaignsByMediaCampaignTypeIds(Set<ID> mctIds, Set<String> fields) {
    return new MT_MediaCampaignSelector().getRecordsByMediaCampaignTypeIds(mctIds, fields);
  }

  /*
  * static method to call the selector which queries the object and fields that were demanded
  *
  * @param  Set<ID> oppAppIds: Set of OpportunityApproval ids
  * @return a list with MediaTransparencyCampaign objects
  */
  global static List<MT_MediaCampaign__c> getMediaCampaignsByOpportunityApprovalsIds(Set<ID> oppAppIds) {
    return MT_MediaCampaignService.getMediaCampaignsByOpportunityApprovalsIds(oppAppIds, MT_FieldSet.getFields(SObjectType.MT_MediaCampaign__c.FieldSets.MT_ContextFields));
  }

  /*
  * static method to call the selector which queries the object and fields that were demanded
  *
  * @param  Set<ID> oppAppIds: Set of OpportunityApproval ids
  *         Set<String> fields: Set of fields that are demanded by the caller
  * @return a list with MediaTransparencyCampaign objects
  */
  global static List<MT_MediaCampaign__c> getMediaCampaignsByOpportunityApprovalsIds(Set<ID> oppAppIds, Set<String> fields) {
    return new MT_MediaCampaignSelector().getRecordsByOpportunityApprovalIds(oppAppIds, fields);
  }

  /*
  * static method to determine if a campaigns structure changed
  *
  * @param  MT_MediaCampaign__c newRec: MediaTransparencyCampaign object
  *         MT_MediaCampaign__c oldRec: MediaTransparencyCampaign object
  * @return a boolean that states if the campaign structured changed
  */
  global static Boolean isMediaBuildingBlockStructureChanged(MT_MediaCampaign__c newRec, MT_MediaCampaign__c oldRec) {
    return newRec.MT_Sys_BuildingBlockMatrix__c != oldRec.MT_Sys_BuildingBlockMatrix__c;
  }

  /*
  * static method to determine if a campaigns structure changed
  *
  * @param  MT_MediaCampaign__c campaign: MediaTransparencyCampaign object
  *         String updateComment:         Comment why the campaign was updated or that it was updated
  */
  global static void postFlightPlanUpdate(MT_MediaCampaign__c campaign, String updateComment) {
    FeedItem post = new FeedItem();
    post.Body = 'Flight plan updated:\n\n' + updateComment;
    post.ParentId = campaign.Id;
    insert post;
  }

  /*
  * sends out an email to notify IMA about flight planning changes
  *
  * @param  MT_MediaCampaign__c campaign: MediaTransparencyCampaign object
  *         ID buildingBlockId:           MediaBuildingBlock object id
  *         String updateComment:         Comment why the campaign was updated or that it was updated
  */
  global static void notifyImaAboutFlightPlanUpdate(MT_MediaCampaign__c campaign, ID buildingBlockId, String updateComment) {
    if (String.isBlank(campaign.MT_Responsible_IM_Agent__c)) {
      return;
    }

    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();

    message.setSaveAsActivity(false);
    message.setTargetObjectId(campaign.MT_Responsible_IM_Agent__c);

    message.setSubject('Flight plan change information');

    String body = 'Media Campaign "{!Name}" Flight plan was changed:\n';
    body += '\n';
    body += '{!BaseUrl}/console#%2F{!Id}|%2Fapex%2FMT_FlightPlanning%3Fid%3D{!MediaBuildingBlockId}\n';
    body += '\n';
    body += 'Comment by {!UserName}:\n';
    body += '\n';
    body += '{!SaveComment}';

    body = body
      .replace('{!Name}', campaign.Name)
      .replace('{!Id}', campaign.Id)
      .replace('{!UserName}', UserInfo.getName())
      .replace('{!SaveComment}', updateComment)
      .replace('{!BaseUrl}', URL.getSalesforceBaseUrl().toExternalForm())
      .replace('{!MediaBuildingBlockId}', buildingBlockId)
      ;

    message.setPlainTextBody(body);
    message.setTreatBodiesAsTemplate(false);

    Messaging.SendEmailResult[] results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{
      message
    });

    if (results[0].success) {
      System.debug('The email was sent successfully.');
      System.debug(results);
    } else {
      System.debug('The email failed to send: ' + results[0].errors[0].message);
    }
  }
}