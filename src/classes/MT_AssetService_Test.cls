/************************************************************************************************************
Name:      MT_AssetService_Test
======================================================
Purpose:   Test class for MT_Assets, MT_AssetService and MT_AssetSelector
======================================================
History
-------
Date    AUTHOR            DETAIL
18.03.2017  Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_AssetService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_Assets a = new MT_Assets(new List<P7S1_Asset__c>());
    Test.stopTest();
  }

  testmethod static void getAssetsByIds() {
    P7S1_Asset__c a = [SELECT Id, P7S1_Unit__c FROM P7S1_Asset__c limit 1];
    System.assertNotEquals(null, a);

    Test.startTest();

    System.assert(!MT_AssetService.getAssetsByIds(new Set<Id>{
      a.Id
    }).isEmpty());
    System.assert(MT_AssetService.getAssetsByIds(new Set<Id>()).isEmpty());
    System.assertEquals(a.P7S1_Unit__c, MT_AssetService.getAssetsByIds(new Set<Id>{
      a.Id
    }).get(0).P7S1_Unit__c);
    System.assertEquals('New Asset', MT_AssetService.getAssetsByIds(new Set<Id>{
      a.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getAssetsByIdsWithFields() {
    P7S1_Asset__c a = [SELECT Id, P7S1_Unit__c FROM P7S1_Asset__c limit 1];
    System.assertNotEquals(null, a);

    Test.startTest();

    System.assert(!MT_AssetService.getAssetsByIds(new Set<Id>{
      a.Id
    }, new Set<String>{
      'P7S1_Unit__c'
    }).isEmpty());
    System.assert(MT_AssetService.getAssetsByIds(new Set<Id>(), new Set<String>{
      'P7S1_Unit__c'
    }).isEmpty());
    System.assertEquals(a.P7S1_Unit__c, MT_AssetService.getAssetsByIds(new Set<Id>{
      a.Id
    }, new Set<String>{
      'P7S1_Unit__c'
    }).get(0).P7S1_Unit__c);
    System.assertEquals('New Asset', MT_AssetService.getAssetsByIds(new Set<Id>{
      a.Id
    }, new Set<String>{
      'P7S1_Unit__c, Name'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getAssetsByUnitIds() {
    P7S1_Asset__c a = [SELECT Id, P7S1_Unit__c FROM P7S1_Asset__c limit 1];
    System.assertNotEquals(null, a);

    P7S1_Unit__c u = [SELECT Id FROM P7S1_Unit__c limit 1];
    System.assertNotEquals(null, u);

    Test.startTest();

    System.assert(!MT_AssetService.getAssetsByUnitIds(new Set<Id>{
      u.Id
    }).isEmpty());
    System.assert(MT_AssetService.getAssetsByUnitIds(new Set<Id>()).isEmpty());
    System.assertEquals(u.Id, MT_AssetService.getAssetsByUnitIds(new Set<Id>{
      u.Id
    }).get(0).P7S1_Unit__c);
    System.assertEquals('New Asset', MT_AssetService.getAssetsByUnitIds(new Set<Id>{
      u.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getAssetsByUnitIdsWithFields() {
    P7S1_Asset__c a = [SELECT Id, P7S1_Unit__c FROM P7S1_Asset__c limit 1];
    System.assertNotEquals(null, a);

    P7S1_Unit__c u = [SELECT Id FROM P7S1_Unit__c limit 1];
    System.assertNotEquals(null, u);

    Test.startTest();

    System.assert(!MT_AssetService.getAssetsByUnitIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'P7S1_Unit__c'
    }).isEmpty());
    System.assert(MT_AssetService.getAssetsByUnitIds(new Set<Id>(), new Set<String>{
      'P7S1_Unit__c'
    }).isEmpty());
    System.assertEquals(u.Id, MT_AssetService.getAssetsByUnitIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'P7S1_Unit__c'
    }).get(0).P7S1_Unit__c);
    System.assertEquals('New Asset', MT_AssetService.getAssetsByUnitIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'P7S1_Unit__c, Name'
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getAssetsWithMediaCampaignTypesByIds() {
    P7S1_Asset__c a = [SELECT Id, P7S1_Unit__c FROM P7S1_Asset__c limit 1];
    System.assertNotEquals(null, a);

    Test.startTest();

    System.assert(!MT_AssetService.getAssetsWithMediaCampaignTypesByIds(new Set<Id>{
      a.Id
    }).isEmpty());
    System.assert(MT_AssetService.getAssetsWithMediaCampaignTypesByIds(new Set<Id>()).isEmpty());
    System.assertEquals(a.P7S1_Unit__c, MT_AssetService.getAssetsWithMediaCampaignTypesByIds(new Set<Id>{
      a.Id
    }).get(0).P7S1_Unit__c);
    System.assertEquals('New Asset', MT_AssetService.getAssetsWithMediaCampaignTypesByIds(new Set<Id>{
      a.Id
    }).get(0).Name);

    Test.stopTest();
  }

  testmethod static void getAssetsWithMediaCampaignTypesByIdsWithFields() {
    P7S1_Asset__c a = [SELECT Id, P7S1_Unit__c FROM P7S1_Asset__c limit 1];
    System.assertNotEquals(null, a);

    Test.startTest();

    System.assert(!MT_AssetService.getAssetsWithMediaCampaignTypesByIds(new Set<Id>{
      a.Id
    }, new Set<String>{
      'P7S1_Unit__c'
    }, new Set<String>{
      'Id'
    }).isEmpty());
    System.assert(MT_AssetService.getAssetsWithMediaCampaignTypesByIds(new Set<Id>(), new Set<String>{
      'P7S1_Unit__c'
    }, new Set<String>{
      'Id'
    }).isEmpty());
    System.assertEquals(a.P7S1_Unit__c, MT_AssetService.getAssetsWithMediaCampaignTypesByIds(new Set<Id>{
      a.Id
    }, new Set<String>{
      'P7S1_Unit__c'
    }, new Set<String>{
      'Id'
    }).get(0).P7S1_Unit__c);
    System.assertEquals('New Asset', MT_AssetService.getAssetsWithMediaCampaignTypesByIds(new Set<Id>{
      a.Id
    }, new Set<String>{
      'P7S1_Unit__c, Name'
    }, new Set<String>{
      'Id'
    }).get(0).Name);

    Test.stopTest();
  }

}