/*
* Name:     MT_MediaCamTypeParaVersionWrapper
* Purpose:  Sort; Orders a given CampaignTypeParameterVersion object by MT_ValidFrom__c ASC
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 28.04.2017  Falco Aulitzky              Initial architecture and development
*
*/
global class MT_MediaCamTypeParaVersionWrapper implements Comparable {

  public MT_CampaignTypeParameterVersion__c mctpv;

  public MT_MediaCamTypeParaVersionWrapper(MT_CampaignTypeParameterVersion__c mctpv) {
    this.mctpv = mctpv;
  }

	/* Compares values to create a ASC list of CampaignTypeParameterVersions */
  global Integer compareTo(Object compareTo) {
    MT_MediaCamTypeParaVersionWrapper compareToMCTPV = (MT_MediaCamTypeParaVersionWrapper) compareTo;

    Integer returnValue = 0;

    if (mctpv.MT_ValidFrom__c > compareToMCTPV.mctpv.MT_ValidFrom__c) {
      returnValue = -1;
    } else if (mctpv.MT_ValidFrom__c < compareToMCTPV.mctpv.MT_ValidFrom__c) {
      returnValue = 1;
    }

    return returnValue;
  }
}