/************************************************************************************************************
Name:       MT_FlightPlanningController
======================================================
Purpose:    Controller for a page MT_FlightPlanning. Contains all the method for an angular app to access
            the sfdc db. Refered as Backend
======================================================
History
-------
Date            AUTHOR                                DETAIL
17.11.2016  Duc Nguyen Tien             Initial architecture & development
06.01.2017  Sven Kretschmann            Refactored and moved common stuff into MT_ConfigController
*************************************************************************************************************/
public with sharing class MT_FlightPlanningController {
  public MT_FlightPlanningController(ApexPages.StandardController stdController) {
  }

  @RemoteAction
  public static MT_CampaignKPIDTO getCampaignKPIs(List<Id> campaignIds) {
    Set<Id> setCampaignIds = new Set<Id>(campaignIds);

    List<MT_ProSaOrder__c> orders = MT_ProSaOrderService.getProSaOrdersByMediaCampaignIds(setCampaignIds);
    List<MT_MediaCampaign__c> campaigns = MT_MediaCampaignService.getMediaCampaignsByIds(setCampaignIds);

    MT_CampaignKPIDTO dto = new MT_CampaignKPIDTO();

    dto
      .initializeCampaigns(campaigns)
      .initializeProSaOrders(orders)
      ;

    return dto;
  }

  @RemoteAction
  public static MT_FlightPlanningControllerDTO getMediaBuildingBlock(List<Id> mbbIds) {
    return new MT_FlightPlanningControllerDTO().initMediaBuildingBlocksWrapper(
      MT_MediaBuildingBlockService.getMediaBuildingBlocksByIds(new Set<Id>(mbbIds))
    );
  }

  @RemoteAction
  public static MT_FlightPlanningControllerDTO getMediaBuildingBlockMonthlyPlanWithMediaFlights(List<Id> mbbIds) {
    return new MT_FlightPlanningControllerDTO().initMonthlyPlansWrapper(
      MT_MediaBuildingBlockMonthlyPlanService.getMediaBuildingBlockMonthlyPlansWithMediaFlightsByParentIds(new Set<Id>(mbbIds))
    );
  }

  /**
   * Remote action that is accessed by Javascript to retrieve the read / write permissions for the affected objects and fields.
   *
   * @returns Map<String, MT_ObjectAccessDTO> Map of object names to permission dtos providing the requested information.
   */
  @RemoteAction
  public static Map<String, MT_ObjectAccessDTO> getObjectPermissions() {
    Map<String, MT_ObjectAccessDTO> result = new Map<String, MT_ObjectAccessDTO>();

    result.put('MT_MediaCampaign__c', new MT_ObjectAccessDTO(Schema.SObjectType.MT_MediaCampaign__c));
    result.put('MT_TvTarget__c', new MT_ObjectAccessDTO(Schema.SObjectType.MT_TvTarget__c));
    result.put('MT_MediaCampaignMonthlyPlan__c', new MT_ObjectAccessDTO(Schema.SObjectType.MT_MediaCampaignMonthlyPlan__c));
    result.put('MT_MediaFlight__c', new MT_ObjectAccessDTO(Schema.SObjectType.MT_MediaFlight__c));

    return result;
  }

  @RemoteAction
  public static MT_FlightPlanningControllerDTO getFlightPlanningData(List<Id> mbbIds) {
    MT_FlightPlanningControllerDTO result = new MT_FlightPlanningControllerDTO();

    result.initMonthlyPlansWrapper(
      MT_MediaBuildingBlockMonthlyPlanService.getMediaBuildingBlockMonthlyPlansWithMediaFlightsByParentIds(new Set<Id>(mbbIds))
    );

    Set<Id> flightIds = new Set<Id>();

    for (ID mbbId : mbbIds) {
      if (result.mediaBuildingBlockMonthlyPlan.containsKey(mbbId)) {
        for (MT_MediaCampaignMonthlyPlan__c plan : result.mediaBuildingBlockMonthlyPlan.get(mbbId)) {
          for (MT_MediaFlight__c flight : plan.MediaFlights__r) {
            flightIds.add(flight.Id);
          }
        }
      }
    }

    if (!flightIds.isEmpty()) {
      result.initMotiveAllocationsWrapper(
        MT_MediaFlightMotiveAllocationService.getMediaFlightMotiveAllocationsByParentIds(flightIds)
      );
    }

    return result;
  }

  @RemoteAction
  public static MT_FlightPlanningControllerDTO upsertFlightplanningData(MT_FlightPlanningControllerDTO data) {
    if (data.monthlyPlanIdsToMediaFlights != null && !data.monthlyPlanIdsToMediaFlights.isEmpty()) {
      List<MT_MediaFlight__c> flights = new List<MT_MediaFlight__c>();

      for (Id mpId : data.monthlyPlanIdsToMediaFlights.keySet()) {
        flights.addAll(data.monthlyPlanIdsToMediaFlights.get(mpId));
      }

      upsert flights;
    }

    if (data.mediaFlightsToMotiveAllocations != null && !data.mediaFlightsToMotiveAllocations.isEmpty()) {
      List<MT_MediaFlightMotiveAllocation__c> allocations = new List<MT_MediaFlightMotiveAllocation__c>();
      List<MT_MediaFlightMotiveAllocation__c> allocationsToDelete = new List<MT_MediaFlightMotiveAllocation__c>();

      for (Id mfId : data.mediaFlightsToMotiveAllocations.keySet()) {
        for (MT_MediaFlightMotiveAllocation__c allocation : data.mediaFlightsToMotiveAllocations.get(mfId)) {
          if (allocation.IsDeleted) {
            allocationsToDelete.add(allocation);
          } else {
            allocations.add(allocation);
          }
        }
      }

      if (!allocations.isEmpty()) {
        upsert allocations;
      }

      if (!allocationsToDelete.isEmpty()) {
        delete allocationsToDelete;
      }
    }

    if (!String.isBlank(data.saveComment) && data.campaignToBuildingBlocksMapping != null && !data.campaignToBuildingBlocksMapping.isEmpty()) {
      List<MT_MediaCampaign__c> campaigns = [SELECT Id, MT_Responsible_IM_Agent__c, Name FROM MT_MediaCampaign__c WHERE ID IN :data.campaignToBuildingBlocksMapping.keySet() AND MT_Responsible_IM_Agent__c != null];

      for (MT_MediaCampaign__c campaign : campaigns) {
        MT_MediaCampaignService.postFlightPlanUpdate(campaign, data.saveComment);

        if (data.notifyIma) {
          MT_MediaCampaignService.notifyImaAboutFlightPlanUpdate(campaign, data.campaignToBuildingBlocksMapping.get(campaign.Id)[0], data.saveComment);
        }
      }
    }

    return MT_FlightPlanningController.getFlightPlanningData(new List<Id>(data.mediaBuildingBlockMonthlyPlan.keySet()));
  }

  public class MT_FlightPlanningControllerDTO {
    public Map<Id, MT_TvTarget__c> mediaBuildingBlocks;
    public Map<Id, MT_MediaCampaign__c> mediaCampaigns;
    public Map<Id, List<Id>> campaignToBuildingBlocksMapping;
    public Map<Id, List<MT_MediaCampaignMonthlyPlan__c>> mediaBuildingBlockMonthlyPlan;
    public Map<Id, List<MT_MediaFlight__c>> monthlyPlanIdsToMediaFlights;
    public Map<Id, List<MT_MediaFlightMotiveAllocation__c>> mediaFlightsToMotiveAllocations;
    public Map<Id, MT_MediaMotive__c> mediaMotives;
    public Map<Id, MT_AdvertisedMediaProduct__c> advertisedProducts;
    public String saveComment;
    public Boolean notifyIma = false;

    public MT_FlightPlanningControllerDTO() {

    }

    public MT_FlightPlanningControllerDTO initMediaBuildingBlocksWrapper(List<MT_TvTarget__c> blocks) {
      this.mediaCampaigns = new Map<Id, MT_MediaCampaign__c>();
      this.campaignToBuildingBlocksMapping = new Map<Id, List<Id>>();
      this.mediaBuildingBlocks = new Map<Id, MT_TvTarget__c>();

      for (MT_TvTarget__c block : blocks) {
        if (block.MT_MediaCampaign_ref__c != null && block.MT_MediaCampaign_ref__r != null) {
          if (!this.mediaCampaigns.containsKey(block.MT_MediaCampaign_ref__c)) {

            if (this.campaignToBuildingBlocksMapping.containsKey(block.MT_MediaCampaign_ref__c)) {
              this.campaignToBuildingBlocksMapping.get(block.MT_MediaCampaign_ref__c).add(block.Id);
            } else {
              this.campaignToBuildingBlocksMapping.put(block.MT_MediaCampaign_ref__c, new List<Id>{
                block.Id
              });
            }

            this.mediaCampaigns.put(block.MT_MediaCampaign_ref__c, block.MT_MediaCampaign_ref__r);
          }
        }

        if (block.MT_MediaCampaign_ref__r != null) {
          block.MT_MediaCampaign_ref__r = null;
        }

        this.mediaBuildingBlocks.put(block.Id, block);
      }

      return this;
    }

    public MT_FlightPlanningControllerDTO initMonthlyPlansWrapper(List<MT_MediaCampaignMonthlyPlan__c> plans) {
      this.mediaBuildingBlockMonthlyPlan = new Map<Id, List<MT_MediaCampaignMonthlyPlan__c>>();

      for (MT_MediaCampaignMonthlyPlan__c plan : plans) {
        if (plan.MT_MediaCampaign_ref__c != null) {
          if (this.mediaBuildingBlockMonthlyPlan.containsKey(plan.MT_MediaCampaign_ref__c)) {
            this.mediaBuildingBlockMonthlyPlan.get(plan.MT_MediaCampaign_ref__c).add(plan);
          } else {
            this.mediaBuildingBlockMonthlyPlan.put(plan.MT_MediaCampaign_ref__c, new List<MT_MediaCampaignMonthlyPlan__c>{
              plan
            });
          }
        }
      }

      return this;
    }

    public MT_FlightPlanningControllerDTO initMotiveAllocationsWrapper(List<MT_MediaFlightMotiveAllocation__c> allocations) {
      this.mediaFlightsToMotiveAllocations = new Map < Id, List<MT_MediaFlightMotiveAllocation__c>>();

      for (MT_MediaFlightMotiveAllocation__c allocation : allocations) {
        if (this.mediaFlightsToMotiveAllocations.containsKey(allocation.MT_MediaFlight_ref__c)) {
          this.mediaFlightsToMotiveAllocations.get(allocation.MT_MediaFlight_ref__c).add(allocation);
        } else {
          this.mediaFlightsToMotiveAllocations.put(allocation.MT_MediaFlight_ref__c, new List<MT_MediaFlightMotiveAllocation__c>{
            allocation
          });
        }
      }

      return this;
    }
  }

  public class MT_CampaignKPIDTO {
    public Map<Id, Map<String, Object>> campaignKPIs;

    public MT_CampaignKPIDTO initializeCampaigns(List<MT_MediaCampaign__c> campaigns) {
      this.initializeMap();

      for (MT_MediaCampaign__c campaign : campaigns) {
        this.campaignKPIs.put(campaign.Id, new Map<String, Object>(campaign.getPopulatedFieldsAsMap()));
      }

      return this;
    }

    public MT_CampaignKPIDTO initializeProSaOrders(List<MT_ProSaOrder__c> orders) {
      this.initializeMap();

      for (MT_ProSaOrder__c order : orders) {
        if (!this.campaignKPIs.containsKey(order.MT_MediaCampaign_ref__c)) {
          this.campaignKPIs.put(order.MT_MediaCampaign_ref__c, new Map<String, Object>());
        }

        if (!this.campaignKPIs.get(order.MT_MediaCampaign_ref__c).containsKey('MT_ProSaOrder__r')) {
          this.campaignKPIs.get(order.MT_MediaCampaign_ref__c).put('MT_ProSaOrder__r', new List<Map<String, Object>>());
        }

        ((List<Map<String, Object>>) this.campaignKPIs.get(order.MT_MediaCampaign_ref__c).get('MT_ProSaOrder__r')).add(order.getPopulatedFieldsAsMap());
      }

      return this;
    }

    private void initializeMap() {
      if (this.campaignKPIs == null) {
        this.campaignKPIs = new Map<Id, Map<String, Object>>();
      }
    }
  }
}