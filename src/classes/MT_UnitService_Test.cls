/************************************************************************************************************
Name:  		MT_UnitService_Test
======================================================
Purpose: 	Test class for MT_Units, MT_UnitService and MT_UnitSelector
======================================================
History
-------
Date		AUTHOR						DETAIL
16.03.2017	Falco Aulitzky             Initial architecture & development
*************************************************************************************************************/

@isTest
private class MT_UnitService_Test {
  @testSetup static void setup() {
    MT_Test.init();
  }

  @isTest static void constructor() {
    Test.startTest();
    MT_Units u = new MT_Units(new List<P7S1_Unit__c>());
    Test.stopTest();
  }

  testmethod static void getUnitsByIds() {
    P7S1_Unit__c u = [SELECT Id FROM P7S1_Unit__c limit 1];
    System.assertNotEquals(null, u);

    Test.startTest();

    System.assert(!MT_UnitService.getUnitsByIds(new Set<Id>{
      u.Id
    }).isEmpty());
    System.assert(MT_UnitService.getUnitsByIds(new Set<Id>()).isEmpty());
    System.assertEquals('Test Unit', MT_UnitService.getUnitsByIds(new Set<Id>{
      u.Id
    }).get(0).Name);
    System.assertEquals('D&A', MT_UnitService.getUnitsByIds(new Set<Id>{
      u.Id
    }).get(0).P7S1_Segment__c);

    Test.stopTest();
  }

  testmethod static void getUnitsByIdsWithFields() {
    P7S1_Unit__c u = [SELECT Id FROM P7S1_Unit__c limit 1];
    System.assertNotEquals(null, u);

    Test.startTest();

    System.assert(!MT_UnitService.getUnitsByIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'P7S1_Segment__c'
    }).isEmpty());
    System.assert(MT_UnitService.getUnitsByIds(new Set<Id>(), new Set<String>{
      'P7S1_Segment__c'
    }).isEmpty());
    System.assertEquals('Test Unit', MT_UnitService.getUnitsByIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'Name'
    }).get(0).Name);
    System.assertEquals('D&A', MT_UnitService.getUnitsByIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'P7S1_Segment__c'
    }).get(0).P7S1_Segment__c);

    Test.stopTest();
  }

  testmethod static void getUnitsWithAssetsByIds() {
    P7S1_Unit__c u = [SELECT Id FROM P7S1_Unit__c limit 1];
    System.assertNotEquals(null, u);

    Test.startTest();

    System.assert(!MT_UnitService.getUnitsWithAssetsByIds(new Set<Id>{
      u.Id
    }).isEmpty());
    System.assert(MT_UnitService.getUnitsWithAssetsByIds(new Set<Id>()).isEmpty());
    System.assertEquals('Test Unit', MT_UnitService.getUnitsWithAssetsByIds(new Set<Id>{
      u.Id
    }).get(0).Name);
    System.assertEquals('D&A', MT_UnitService.getUnitsWithAssetsByIds(new Set<Id>{
      u.Id
    }).get(0).P7S1_Segment__c);

    Test.stopTest();
  }

  testmethod static void getUnitsWithAssetsByIdsithFields() {
    P7S1_Unit__c u = [SELECT Id, Name FROM P7S1_Unit__c limit 1];
    System.assertNotEquals(null, u);

    Test.startTest();

    System.assert(!MT_UnitService.getUnitsWithAssetsByIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'P7S1_Segment__c'
    }, new Set<String>{
      'P7S1_Unit__c'
    }).isEmpty());
    System.assert(MT_UnitService.getUnitsWithAssetsByIds(new Set<Id>(), new Set<String>{
      'P7S1_Segment__c'
    }, new Set<String>{
      'P7S1_Unit__c'
    }).isEmpty());
    System.assertEquals('Test Unit', MT_UnitService.getUnitsWithAssetsByIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'Name'
    }, new Set<String>{
      'P7S1_Unit__c'
    }).get(0).Name);
    System.assertEquals('D&A', MT_UnitService.getUnitsWithAssetsByIds(new Set<Id>{
      u.Id
    }, new Set<String>{
      'P7S1_Segment__c'
    }, new Set<String>{
      'P7S1_Unit__c'
    }).get(0).P7S1_Segment__c);

    Test.stopTest();
  }

  testmethod static void getUnitsBySegments() {
    P7S1_Unit__c u = [SELECT Id FROM P7S1_Unit__c limit 1];
    System.assertNotEquals(null, u);

    Test.startTest();

    System.assert(!MT_UnitService.getUnitsBySegments(new Set<String>{
      'D&A'
    }).isEmpty());
    System.assert(MT_UnitService.getUnitsBySegments(new Set<String>()).isEmpty());
    System.assertEquals('Test Unit', MT_UnitService.getUnitsBySegments(new Set<String>{
      'D&A'
    }).get(0).Name);
    System.assertEquals('D&A', MT_UnitService.getUnitsBySegments(new Set<String>{
      'D&A'
    }).get(0).P7S1_Segment__c);

    Test.stopTest();
  }

  testmethod static void getUnitsBySegmentsWithFields() {
    P7S1_Unit__c u = [SELECT Id FROM P7S1_Unit__c limit 1];
    System.assertNotEquals(null, u);

    Test.startTest();

    System.assert(!MT_UnitService.getUnitsBySegments(new Set<String>{
      'D&A'
    }, new Set<String>{
      'P7S1_Segment__c'
    }).isEmpty());
    System.assert(MT_UnitService.getUnitsBySegments(new Set<String>(), new Set<String>{
      'P7S1_Segment__c'
    }).isEmpty());
    System.assertEquals('Test Unit', MT_UnitService.getUnitsBySegments(new Set<String>{
      'D&A'
    }, new Set<String>{
      'Name'
    }).get(0).Name);
    System.assertEquals('D&A', MT_UnitService.getUnitsBySegments(new Set<String>{
      'D&A'
    }, new Set<String>{
      'P7S1_Segment__c'
    }).get(0).P7S1_Segment__c);

    Test.stopTest();
  }
}