/************************************************************************************************************
Name:  		MT_AccountMotiveController_Test
======================================================
Purpose: 	Test class for MT_AccountMotiveController
======================================================
History
-------
Date		    AUTHOR						          DETAIL
11.04.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_AccountMotiveController_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  testmethod static void loadProductsAndMotivesbyAccountId() {
    Test.startTest();
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AccountMotivesController.MT_AccountMotivesControllerDTO amcdto = MT_AccountMotivesController.loadProductsAndMotivesbyAccountId(new List<Id>{
      acc.Id
    });
    List<MT_AdvertisedMediaProduct__c> ampList = amcdto.accountProducts.get(acc.Id);
    System.assertNotEquals(true, ampList.isEmpty());

    List<MT_MediaMotive__c> mmList = amcdto.productMotives.get(ampList.get(0).Id);
    System.assertEquals('12345', ampList.get(0).MT_ProductNumber__c);
    System.assertEquals('Test Motive', mmList.get(0).Name);

    Test.stopTest();
  }

  testmethod static void loadProductById() {
    Test.startTest();
    MT_AdvertisedMediaProduct__c amp = [Select Id FROM MT_AdvertisedMediaProduct__c limit 1];
    System.assertNotEquals(null, amp);

    MT_AccountMotivesController.MT_AdvertisedMediaProductDTO ampdto = MT_AccountMotivesController.loadProductById(amp.Id);
    System.assertNotEquals(null, ampdto.product);

    System.assertEquals('12345', ampdto.product.MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void loadMotiveById() {
    Test.startTest();
    MT_MediaMotive__c mm = [Select Id FROM MT_MediaMotive__c limit 1];
    System.assertNotEquals(null, mm);

    MT_AccountMotivesController.MT_MotiveDTO mmdto = MT_AccountMotivesController.loadMotiveById(mm.Id);
    System.assertNotEquals(null, mmdto.motive);

    System.assertEquals('Test Motive', mmdto.motive.Name);

    Test.stopTest();
  }

  //---------

  testmethod static void upsertProductsAndMotives() {
    Test.startTest();
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AccountMotivesController.MT_AccountMotivesControllerDTO amcdto = MT_AccountMotivesController.loadProductsAndMotivesbyAccountId(new List<Id>{
      acc.Id
    });
    List<MT_AdvertisedMediaProduct__c> ampList = amcdto.accountProducts.get(acc.Id);

    ampList.get(0).MT_ProductNumber__c = '3467856837';

    MT_AccountMotivesController.MT_AccountMotivesControllerDTO amcdto2 = MT_AccountMotivesController.upsertProductsAndMotives(amcdto);
    List<MT_AdvertisedMediaProduct__c> ampList2 = amcdto2.accountProducts.get(acc.Id);

    MT_AccountMotivesController.MT_AdvertisedMediaProductDTO ampdto2 = MT_AccountMotivesController.loadProductById(ampList2.get(0).Id);
    System.assertEquals('3467856837', ampdto2.product.MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void upsertProduct() {
    Test.startTest();
    MT_AdvertisedMediaProduct__c amp = [Select Id FROM MT_AdvertisedMediaProduct__c limit 1];
    System.assertNotEquals(null, amp);

    MT_AccountMotivesController.MT_AdvertisedMediaProductDTO ampdto = MT_AccountMotivesController.loadProductById(amp.Id);
    System.assertNotEquals(null, ampdto.product);

    ampdto.product.MT_ProductNumber__c = '3467856837';

    MT_AccountMotivesController.MT_AdvertisedMediaProductDTO ampdto2 = MT_AccountMotivesController.upsertProduct(ampdto);

    System.assertEquals('3467856837', ampdto2.product.MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void upsertMotive() {
    Test.startTest();
    MT_MediaMotive__c mm = [Select Id FROM MT_MediaMotive__c limit 1];
    System.assertNotEquals(null, mm);

    MT_AccountMotivesController.MT_MotiveDTO mmdto = MT_AccountMotivesController.loadMotiveById(mm.Id);
    System.assertNotEquals(null, mmdto.motive);

    mmdto.motive.Name = 'Not so new Motive';

    MT_AccountMotivesController.MT_MotiveDTO mmdto2 = MT_AccountMotivesController.upsertMotive(mmdto);

    System.assertEquals('Not so new Motive', mmdto2.motive.Name);

    Test.stopTest();
  }
}