/**
* Name:     MT_AccountMotivesController
* Purpose:  Controller for the page MT_FlightPlanning.
*           It contains all the method for an angular app to access the sfdc db. Refered as Backend
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 17.02.2017  Falco Aulitzky              Initial architecture and development
* 12.04.2017  Falco Aulitzky              Adding JavaDoc-Styled documentation
*
*/

public with sharing class MT_AccountMotivesController {
  public MT_AccountMotivesController(ApexPages.StandardController stdController) {
  }

  /*
  * Remote Action that is accessed by Javascript to load AdvertisedMediaProducts and MediaMotives regarding the given account ids
  *
  * @param    List<Id> accountIds want a list of Account ids
  * @returns  AccountMotivesControllerDTO
  *           Map<Id, List<MT_AdvertisedMediaProduct__c>> maps a Account id to a list of AdvertisedMediaProduct objects
  *           Map<Id, List<MT_MediaMotive__c>> maps a AdvertisedMediaProduct id to a list of MediaMotive objects
  */
  @RemoteAction
  public static MT_AccountMotivesControllerDTO loadProductsAndMotivesbyAccountId(List<Id> accountIds) {
    return new MT_AccountMotivesControllerDTO().getMotivesByAccountIds(
      MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>(accountIds))
    );
  }

  /*
  * Remote Action that is accessed by Javascript to load one AdvertisedMediaProducts
  *
  * @param    Id productId wants an id of an AdvertisedMediaProduct object
  * @returns  AdvertisedMediaProductDTO
  *           AdvertisedMediaProduct is stored in the DTO
  */
  @RemoteAction
  public static MT_AdvertisedMediaProductDTO loadProductById(Id productId) {
    return new MT_AdvertisedMediaProductDTO().getProductById(
      (MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>{
        productId
      })).get(0)
    );
  }

  /*
  * Remote Action that is accessed by Javascript to load one MediaMotive
  *
  * @param    Id motiveId want an id of a MediaMotive object
  * @returns  MotiveDTO
  *           MediaMotive is stored in the DTO
  */
  @RemoteAction
  public static MT_MotiveDTO loadMotiveById(Id motiveId) {
    return new MT_MotiveDTO().getMotiveById(
      (MT_MediaMotiveService.getMediaMotivesByIds(new Set<Id>{
        motiveId
      })).get(0)
    );
  }

  /*
  * Remote Action that is accessed by Javascript to save AccountMotivesControllerDTO
  *
  * @param    AccountMotivesControllerDTO data
  * @returns  AccountMotivesControllerDTO with updated values
  *           Map<Id, List<MT_AdvertisedMediaProduct__c>> maps a Account id to a list of AdvertisedMediaProduct objects
  *           Map<Id, List<MT_MediaMotive__c>> maps a AdvertisedMediaProduct id to a list of MediaMotive objects
  */
  @RemoteAction
  public static MT_AccountMotivesControllerDTO upsertProductsAndMotives(MT_AccountMotivesControllerDTO data) {
    data.upsertData();

    return MT_AccountMotivesController.loadProductsAndMotivesbyAccountId(new List<Id>(data.accountProducts.keySet()));
  }

  /*
  * Remote Action that is accessed by Javascript to save an AdvertisedMediaProductDTO
  *
  * @param    AdvertisedMediaProductDTO data
  * @returns  AdvertisedMediaProductDTO with updated values
  *           AdvertisedMediaProduct is stored in the DTO
  */
  @RemoteAction
  public static MT_AdvertisedMediaProductDTO upsertProduct(MT_AdvertisedMediaProductDTO data) {
    data.upsertData();

    return MT_AccountMotivesController.loadProductById(data.product.Id);
  }

  /*
  * Remote Action that is accessed by Javascript to save a MediaMotiveDTO
  *
  * @param    MediaMotiveDTO data
  * @returns  MediaMotiveDTO with updated values
  *           MediaMotive is stored in the DTO
  */
  @RemoteAction
  public static MT_MotiveDTO upsertMotive(MT_MotiveDTO data) {
    data.upsertData();

    return MT_AccountMotivesController.loadMotiveById(data.motive.Id);
  }

  /* MT_AccountMotivesControllerDTO that holds and combines the fetched data from the server in readable junks for the front end. */
  public class MT_AccountMotivesControllerDTO {
    public Map<Id, List<MT_AdvertisedMediaProduct__c>> accountProducts;
    public Map<Id, List<MT_MediaMotive__c>> productMotives;

    public MT_AccountMotivesControllerDTO() {
    }

    /*
    * Method to fill maps with data from the database
    *
    * @param    List<MT_AdvertisedMediaProduct__c> mediaProducts gets the AdvertisedMediaProduct objects included with the MediaMotive objects and saves them alongside their respective relationships
    * @returns  MT_AccountMotivesControllerDTO with:
    *             Account ids mapped to a list of AdvertisedMediaProduct objects
    *             AdvertisedMediaProduct ids mapped to a list of MediaMotive objects
    */
    public MT_AccountMotivesControllerDTO getMotivesByAccountIds(List<MT_AdvertisedMediaProduct__c> mediaProducts) {
      this.accountProducts = new Map<Id, List<MT_AdvertisedMediaProduct__c>>();
      this.productMotives = new Map<Id, List<MT_MediaMotive__c>>();

      for (MT_AdvertisedMediaProduct__c mediaProduct: mediaProducts) {
        if (mediaProduct.MT_Account_ref__c != null) {
          if (this.accountProducts.containsKey(mediaProduct.MT_Account_ref__c)) {
            this.accountProducts.get(mediaProduct.MT_Account_ref__c).add(mediaProduct);
          } else {
            this.accountProducts.put(mediaProduct.MT_Account_ref__c, new List<MT_AdvertisedMediaProduct__c>{
              mediaProduct
            });
          }
        }

        for (MT_MediaMotive__c mediaMotive: mediaProduct.MT_MediaMotives__r) {
          if (mediaMotive.MT_AdvertisedMediaProduct_ref__c != null) {

            if (this.productMotives.containsKey(mediaMotive.MT_AdvertisedMediaProduct_ref__c)) {
              this.productMotives.get(mediaMotive.MT_AdvertisedMediaProduct_ref__c).add(mediaMotive);
            } else {
              this.productMotives.put(mediaMotive.MT_AdvertisedMediaProduct_ref__c, new List<MT_MediaMotive__c>{
                mediaMotive
              });
            }
          }
        }
      }

      return this;
    }

    /*
    * Method to save a given DTO to the data base
    *
    * @param   none
    * @returns void
    */
    public void upsertData() {
      if (accountProducts != null && !accountProducts.isEmpty()) {
        Set<MT_AdvertisedMediaProduct__c> eraseDublicatedProducts = new Set<MT_AdvertisedMediaProduct__c>();
        List<MT_AdvertisedMediaProduct__c> products = new List<MT_AdvertisedMediaProduct__c>();

        for (Id accountId : this.accountProducts.keySet()) {
          eraseDublicatedProducts.addAll(this.accountProducts.get(accountId));
        }

        if (productMotives != null && !productMotives.isEmpty()) {
          List<MT_MediaMotive__c> motives = new List<MT_MediaMotive__c>();

          for (MT_AdvertisedMediaProduct__c product : eraseDublicatedProducts) {
            motives.addAll(this.productMotives.get(product.Id));
          }

          upsert(motives);
        }

        products.addAll(eraseDublicatedProducts);
        upsert(products);
      }
    }
  }

  /* MT_MotiveDTO that holds the fetched data from the server and provide it further to the front end. */
  public class MT_MotiveDTO {
    public MT_MediaMotive__c motive;

    public MT_MotiveDTO() {
    }

    /*
    * Method to allocate a MediaMotive object to a DTO
    *
    * @param   MediaMotive object
    * @returns MT_MotiveDTO
    */
    public MT_MotiveDTO getMotiveById(MT_MediaMotive__c motive) {
      this.motive = motive;

      return this;
    }

    /*
    * Method to save a given DTO to the data base
    *
    * @param   none
    * @returns void
    */
    public void upsertData() {
      upsert(motive);
    }
  }

  /* MT_AdvertisedMediaProductDTO that holds the fetched data from the server and provide it further to the front end. */
  public class MT_AdvertisedMediaProductDTO {
    public MT_AdvertisedMediaProduct__c product;

    public MT_AdvertisedMediaProductDTO() {
    }

    /*
    * Method to allocate a AdvertisedMediaProduct object to a DTO
    *
    * @param   AdvertisedMediaProduct object
    * @returns MT_AdvertisedMediaProductDTO
    */
    public MT_AdvertisedMediaProductDTO getProductById(MT_AdvertisedMediaProduct__c product) {
      this.product = product;

      return this;
    }

    /*
    * Method to save a given DTO to the data base
    *
    * @param   none
    * @returns void
    */
    public void upsertData() {
      upsert(product);
    }
  }
}