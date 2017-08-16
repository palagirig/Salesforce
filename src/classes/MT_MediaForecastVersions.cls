/************************************************************************************************************
Name:  		MT_MediaForecastVersions
======================================================
Purpose: 	Domain class for MT_ForecastVersion__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
09.03.2017	Falco Aulitzky	            Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_MediaForecastVersions {
  private List<MT_ForecastVersion__c> scope;

  public MT_MediaForecastVersions(List<MT_ForecastVersion__c> scope) {
    this.scope = scope;
  }

  public static MT_ForecastVersion__c create(String name) {
    return new MT_ForecastVersion__c(
      MT_VersionName__c = name
    );

  }

  public class MT_MediaForecastVersionsException extends Exception {
  }
}