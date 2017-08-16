/************************************************************************************************************
Name:  		MT_MediaFlightMotiveAllocations
======================================================
Purpose: 	Domain class for MT_MediaFlightMotiveAllocation__c object
======================================================
History
-------
Date		AUTHOR						DETAIL
???			???							Created class
16.03.2017	Falco Aulitzky	            Initial architecture & development
*************************************************************************************************************/
public class MT_MediaFlightMotiveAllocations {
  private List<MT_MediaFlightMotiveAllocation__c> scope;

  public MT_MediaFlightMotiveAllocations(List<MT_MediaFlightMotiveAllocation__c> scope) {
    this.scope = scope;
  }

  public static MT_MediaFlightMotiveAllocation__c create(MT_MediaFlight__c mediaFlight, MT_MediaMotive__c mediaMotive, MT_AdvertisedMediaProduct__c mediaProduct) {
    return new MT_MediaFlightMotiveAllocation__c(
      MT_MediaFlight_ref__c = mediaFlight.Id,
      MT_MediaMotive_ref__c = mediaMotive.Id,
      MT_MediaProduct_ref__c = mediaProduct.Id
    );
  }

  public class MT_MediaFlightMotiveAllocationsException extends Exception {
  }
}