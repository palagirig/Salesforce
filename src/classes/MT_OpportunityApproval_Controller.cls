/*
* Name:       MT_OpportunityApproval_Controller
*
* Purpose:    extension for the MT_GlobalOppApp_ConsoleComp.page
*
* History
* -------
* Date        AUTHOR                      DETAIL
* 21.04.2017  Falco Aulitzky              Initial architecture & development & documentation
*/
public with sharing class MT_OpportunityApproval_Controller {

  private final sObject mysObject;
  private Schema.SObjectType objType;
  public ContextObjectWrapper context { get; set; }

  public MT_OpportunityApproval_Controller(ApexPages.StandardController stdController) {

    this.mysObject = (sObject) stdController.getRecord();
    this.objType = this.mysObject.getSobjectType();

    if (this.objType == P7S1_OpportunityApproval__c.SobjectType) {
      context = new MT_OppApp_Global_ConsoleComp(this.mysObject);
    }
  }

  public void init(Schema.SobjectType objType) {
  }

  public abstract class ContextObjectWrapper {
    public Map<String, Object> var { get; set; }
    abstract void init();
  }

    /* Data Wrapper class to provide the necessary informations to the console component*/
  public class MT_OppApp_Global_ConsoleComp extends ContextObjectWrapper {
    public P7S1_OpportunityApproval__c oppApp;

    public MT_OppApp_Global_ConsoleComp(Sobject obj) {
      this.oppApp = (P7S1_OpportunityApproval__c) obj;
      var = new Map<String, Object>();
      init();
    }

        /* initialises the loading of the media campaign informations */
    public override void init() {
      loadMediaCampaign();
    }

        /* Only queries the needed two fields of the media campaign and provides them to the console component */
    public void loadMediaCampaign() {
      List<MT_MediaCampaign__c> mCampaigns = MT_MediaCampaignService.getMediaCampaignsByOpportunityApprovalsIds(new Set<Id>{
        this.oppApp.Id
      }, new Set<String>{
        'MT_Type__c', 'MT_Status__c'
      });
      if (mCampaigns.isEmpty()) {
        var.put('mc', new MT_MediaCampaign__c());
      } else {
        var.put('mc', mCampaigns.get(0));
      }
    }
  }
}