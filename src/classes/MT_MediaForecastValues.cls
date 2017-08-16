/************************************************************************************************************
Name:  		MT_MediaForecastValues
======================================================
Purpose: 	Domain class for MT_ForecastValue__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
09.03.2017	Falco Aulitzky	            Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaForecastValues {
  private List<MT_ForecastValue__c> scope;

  public MT_MediaForecastValues(List<MT_ForecastValue__c> scope) {
    this.scope = scope;
  }

  public static MT_ForecastValue__c create(MT_MediaCampaignType__c mediaCampaignType, MT_ForecastVersion__c mediaForecastVersion) {
    return new MT_ForecastValue__c(
      MT_MediaCampaignType__c = mediaCampaignType.Id,
      MT_MediaForecastVersion_ref__c = mediaForecastVersion.Id
    );

  }

  public class MT_MediaForecastValuesException extends Exception {
  }
}