/************************************************************************************************************
Name:       MT_ConfigController
======================================================
Purpose:    Controller for JS remote actions. Contains all the method for an angular app to access
            common configuration.
======================================================
History
-------
Date        AUTHOR                      DETAIL
06.01.2017  Sven Kretschmann             Initial architecture & development
*************************************************************************************************************/

public with sharing class MT_ConfigController {
  public MT_ConfigController(ApexPages.StandardController stdController) {
  }

  @RemoteAction
  public static MT_Labels getLabels() {
    return MT_Labels.getInstance().prepareForSerialization();
  }

  @RemoteAction
  public static MT_Constants getConstants() {
    return MT_Constants.getInstance().prepareForSerialization();
  }


  @RemoteAction
  public static MT_Config getConfig() {
    return MT_Config.getInstance()
      .loadObjectsSchemaConf(new List<Schema.sObjectType>{
        Account.SobjectType, MT_MediaCampaign__c.SobjectType, MT_TvTarget__c.SobjectType
      })
      .prepareForSerialization();
  }

  /**
   * We'll compare the provided dates against this in JS. If we would compare against a local date constructed on client
   * site, we might have a different timezone and have mismatches.
   */
  @RemoteAction
  public static Date getDate() {
    return Date.today();
  }

  @RemoteAction
  public static Set<String> getPicklistValues(String obj, String fieldName) {
    Set<String> result = new Set<String>();

    Schema.DescribeSobjectResult[] objDescs = Schema.describeSObjects(new String[]{
      obj
    });

    Map<String, Schema.SObjectField> fields = objDescs[0].fields.getMap();
    List<Schema.PicklistEntry> plValues = fields.get(fieldName).getDescribe().getPickListValues();

    for (Schema.PicklistEntry e : plValues) {
      result.add(e.getLabel());
    }

    return result;
  }

  @RemoteAction
  public static Boolean allowEditingAfterDeadlineDate() {
    return Schema.SObjectType.MT_ForecastVersion__c.isCreateable();
  }
}