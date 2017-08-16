/************************************************************************************************************
Name:  		MT_AdvertisedMediaProductService_Test
======================================================
Purpose: 	Test class for MT_AdvertisedMediaProducts, MT_AdvertisedMediaProductService and MT_AdvertisedMediaProductSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
15.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_AdvertisedMediaProductService_Test {
  @testSetup static void setup() {
    MT_Test.init();

    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AdvertisedMediaProduct__c amp = MT_AdvertisedMediaProducts.create(acc, 'New Product', '12345');
    insert amp;

    MT_MediaMotive__c mm = MT_MediaMotives.create(amp, 'new Motive');
    insert mm;
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_AdvertisedMediaProducts amp = new MT_AdvertisedMediaProducts(new List<MT_AdvertisedMediaProduct__c>());
    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsByAccountIds() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];

    System.assertNotEquals(null, amp);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(new Set<Id>{
      acc.Id
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(new Set<Id>()).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(new Set<Id>{
      acc.Id
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(new Set<Id>{
      acc.Id
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsByAccountIdsWithFields() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];

    System.assertNotEquals(null, amp);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(new Set<Id>(), new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(new Set<ID>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByAccountIds(new Set<ID>{
      acc.Id
    }, new Set<String>{
      'MT_ProductNumber__c'
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsByIds() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];

    System.assertNotEquals(null, amp);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>{
      amp.Id
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>()).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>{
      amp.Id
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>{
      amp.Id
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsByIdsWithFields() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];

    System.assertNotEquals(null, amp);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>{
      amp.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>(), new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>{
      amp.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByIds(new Set<Id>{
      amp.Id
    }, new Set<String>{
      'MT_ProductNumber__c'
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsByProductNumbers() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];

    System.assertNotEquals(null, amp);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(new Set<String>{
      '12345'
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(new Set<String>()).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(new Set<String>{
      '12345'
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(new Set<String>{
      '12345'
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsByProductNumbersWithFields() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    MT_AdvertisedMediaProduct__c amp = [SELECT Id FROM MT_AdvertisedMediaProduct__c limit 1];

    System.assertNotEquals(null, amp);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(new Set<String>{
      '12345'
    }, new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(new Set<String>(), new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(new Set<String>{
      '12345'
    }, new Set<String>{
      'MT_Account_ref__c'
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsByProductNumbers(new Set<String>{
      '12345'
    }, new Set<String>{
      'MT_ProductNumber__c'
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsWithMotivesByAccountIds() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>()).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsWithMotivesByAccountIdsWithProductFields() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>(), new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_ProductNumber__c'
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsWithMotivesByAccountIdsWithProductAndMotiveFields() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>(), new Set<String>{
      'MT_Account_ref__c'
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithMotivesByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_ProductNumber__c'
    }, new Set<String>{
      'MT_AdvertisedMediaProduct_ref__c'
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>()).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIdsWithProductFields() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>(), new Set<String>{
      'MT_Account_ref__c'
    }).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_ProductNumber__c'
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }

  testmethod static void getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIdsWithProductAndFlightMotiveAllocationFields() {
    Account acc = [Select Id FROM Account limit 1];
    System.assertNotEquals(null, acc);

    Test.startTest();

    System.assert(!MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }, new Set<String>{
      'MT_MediaProduct_ref__c'
    }).isEmpty());
    System.assert(MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>(), new Set<String>{
      'MT_Account_ref__c'
    }, new Set<String>{
      'MT_MediaProduct_ref__c'
    }).isEmpty());
    System.assertEquals(acc.Id, MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_Account_ref__c'
    }, new Set<String>{
      'MT_MediaProduct_ref__c'
    }).get(0).MT_Account_ref__c);
    System.assertEquals('12345', MT_AdvertisedMediaProductService.getAdvertisedMediaProductsWithFlightMotiveAllocationByAccountIds(new Set<Id>{
      acc.Id
    }, new Set<String>{
      'MT_ProductNumber__c'
    }, new Set<String>{
      'MT_MediaProduct_ref__c'
    }).get(0).MT_ProductNumber__c);

    Test.stopTest();
  }
}