/************************************************************************************************************
Name:       MT_KPI_Controller
======================================================
Purpose:    Controller for all MT_KPI vf pages
======================================================
History
-------
Date        AUTHOR                      DETAIL
19.01.2017  Duc Nguyen Tien             Initial architecture & development
15.02.2017  Falco Aulitzky              Updated tvBlock and istBlock to finalize the functionality
*************************************************************************************************************/
public with sharing class MT_KPI_Controller {

  private final sObject mysObject;
  private Schema.SObjectType objType;
  public ContextObjectWrapper context { get; set; }

  public MT_KPI_Controller(ApexPages.StandardController stdController) {
    this.mysObject = (sObject) stdController.getRecord();
    this.objType = this.mysObject.getSobjectType();

    if (this.objType == MT_MediaCampaign__c.SobjectType) {
      context = new MT_KPI_Global_ConsoleComp(this.mysObject);
    }
  }

  public void init(Schema.SobjectType objType) {
  }

  public abstract class ContextObjectWrapper {
    public Map<String, Object> var { get; set; }
    abstract void init();
  }

  public class MT_KPI_Global_ConsoleComp extends ContextObjectWrapper {
    public MT_MediaCampaign__c mCamp;

    public MT_KPI_Global_ConsoleComp(Sobject obj) {
      this.mCamp = (MT_MediaCampaign__c) obj;

      var = new Map<String, Object>();

      init();
    }

    public override void init() {
      calculatedProgressBar();
    }

    public void calculatedProgressBar() {
      Double d = Math.min(this.mCamp.MT_ActualMonthlyBMV_sum__c == 0 ? 0 : this.mCamp.MT_ActualMonthlyBMV_sum__c / this.mCamp.MT_BMVTv__c, 1);
      var.put('progressBarPercentage', d * 100);
    }
  }
}