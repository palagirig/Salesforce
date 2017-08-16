@isTest
private class MT_BusinessPlanningController_Test {

  @testSetup static void setup() {
    MT_Test.init();
  }
  testmethod static void constructor() {
    MT_MediaCampaign__c mc = [Select ID, MT_RunTimeTVEnd__c from MT_MediaCampaign__c limit 1];
    List<MT_TvTarget__c> mbbs = (List<MT_TvTarget__c>) new MT_MediaBuildingBlockSelector().getTVRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    });
    system.assertEquals(1, mbbs.size(), 'Not found TV block for test');
    MT_BusinessPlanningController mCtrl = new MT_BusinessPLanningController(new ApexPages.StandardController(mbbs.get(0)));
  }
  testmethod static void getMediaBuildingBlock() {
    MT_MediaCampaign__c mc = [Select ID, MT_RunTimeTVEnd__c from MT_MediaCampaign__c limit 1];
    List<MT_TvTarget__c> mbbs = (List<MT_TvTarget__c>) new MT_MediaBuildingBlockSelector().getTVRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    });
    system.assertEquals(1, mbbs.size(), 'Not found TV block for test');

    MT_BusinessPlanningController.MT_BusinessPlanningControllerDTO dto = MT_BusinessPlanningController.getMediaBuildingBlock(new List<Id>{
      mbbs.get(0).Id
    });
  }
  testmethod static void getMediaBuildingBlockMonthlyPlan() {
    MT_MediaCampaign__c mc = [Select ID, MT_RunTimeTVEnd__c from MT_MediaCampaign__c limit 1];
    List<MT_TvTarget__c> mbbs = (List<MT_TvTarget__c>) new MT_MediaBuildingBlockSelector().getTVRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    });
    system.assertEquals(1, mbbs.size(), 'Not found TV block for test');
  }
  testmethod static void getMediaBuildingBlockMonthlyPlanWithMediaFlights() {
    MT_MediaCampaign__c mc = [Select ID, MT_RunTimeTVEnd__c from MT_MediaCampaign__c limit 1];
    List<MT_TvTarget__c> mbbs = (List<MT_TvTarget__c>) new MT_MediaBuildingBlockSelector().getTVRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    });
    system.assertEquals(1, mbbs.size(), 'Not found TV block for test');

    MT_BusinessPlanningController.MT_BusinessPlanningControllerDTO dto = MT_BusinessPlanningController.getMediaBuildingBlockMonthlyPlanWithMediaFlights(new List<Id>{
      mbbs.get(0).Id
    });
  }
  testmethod static void upsertMediaBuildingBlockMonthlyPlansWithMediaFlights() {
    MT_MediaCampaign__c mc = [Select ID, MT_RunTimeTVEnd__c from MT_MediaCampaign__c limit 1];
    List<MT_TvTarget__c> mbbs = (List<MT_TvTarget__c>) new MT_MediaBuildingBlockSelector().getTVRecordsByMediaCampaignIds(new Set<ID>{
      mc.Id
    }, new Set<String>{
      'Name'
    });
    system.assertEquals(1, mbbs.size(), 'Not found TV block for test');

    MT_BusinessPlanningController.MT_BusinessPlanningControllerDTO dto = MT_BusinessPlanningController.getMediaBuildingBlockMonthlyPlanWithMediaFlights(new List<Id>{
      mbbs.get(0).Id
    });
    dto.monthlyPlanIdsToMediaFlights = new Map<Id, List<MT_MediaFlight__c>>();

    for (Id mdId : dto.mediaBuildingBlockMonthlyPlan.keySet()) {
      for (MT_MediaCampaignMonthlyPlan__c mmbbmp : dto.mediaBuildingBlockMonthlyPlan.get(mdId)) {
        dto.monthlyPlanIdsToMediaFlights.put(mmbbmp.Id, new List<MT_MediaFlight__c>{
          new MT_MediaFlight__c(MT_MediaBuildingBlockMonthlyPlan_ref__c = mmbbmp.Id, MT_BMVAmount__c = 1000, MT_StartDate__c = Date.today(), MT_EndDate__c = Date.today().addDays(1))
        });
      }
    }

    MT_BusinessPlanningController.MT_BusinessPlanningControllerDTO resp = MT_BusinessPlanningController.upsertMediaBuildingBlockMonthlyPlansWithMediaFlights(dto);
  }

  testmethod static void getObjectPermissions() {
    Map<String, MT_ObjectAccessDTO> perms = MT_BusinessPlanningController.getObjectPermissions();

    // make sure anything was returned
    System.assertNotEquals(null, perms);
    System.assert(!perms.isEmpty());

    // make sure the map contains the correct entries
    System.assertEquals(4, perms.size());

    System.assert(perms.containsKey('MT_MediaCampaign__c'));
    System.assert(perms.containsKey('MT_TvTarget__c'));
    System.assert(perms.containsKey('MT_MediaCampaignMonthlyPlan__c'));
    System.assert(perms.containsKey('MT_MediaFlight__c'));

    // make sure every of the entries contains also field information
    System.assertNotEquals(null, perms.get('MT_MediaCampaign__c'));
    System.assertNotEquals(null, perms.get('MT_MediaCampaign__c').fields);
    System.assert(!perms.get('MT_MediaCampaign__c').fields.isEmpty());

    System.assertNotEquals(null, perms.get('MT_TvTarget__c'));
    System.assertNotEquals(null, perms.get('MT_TvTarget__c').fields);
    System.assert(!perms.get('MT_TvTarget__c').fields.isEmpty());

    System.assertNotEquals(null, perms.get('MT_MediaCampaignMonthlyPlan__c'));
    System.assertNotEquals(null, perms.get('MT_MediaCampaignMonthlyPlan__c').fields);
    System.assert(!perms.get('MT_MediaCampaignMonthlyPlan__c').fields.isEmpty());

    System.assertNotEquals(null, perms.get('MT_MediaFlight__c'));
    System.assertNotEquals(null, perms.get('MT_MediaFlight__c').fields);
    System.assert(!perms.get('MT_MediaFlight__c').fields.isEmpty());
  }
}