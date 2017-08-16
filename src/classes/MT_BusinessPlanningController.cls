/**
* Name:     MT_BusinessPlanningController
* Purpose:  Controller for the page MT_BusinessPlanning.
*           It contains all the method for an angular app to access the sfdc db. Refered as Backend
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 17.11.2016  Duc Nguyen Tien             Initial architecture and development
* 06.01.2017  Sven Kretschmann            Refactored and moved common stuff into MT_ConfigController
* 12.04.2017  Falco Aulitzky              Adding JavaDoc-Styled documentation
*
*/

public with sharing class MT_BusinessPlanningController {
  public MT_BusinessPlanningController(ApexPages.StandardController stdController) {
  }

  /*
  * Remote Action that is accessed by Javascript to load MediaBuildingBlocks
  *
  * @param    List<Id> mbbIds want a list of MediaBuildingBlock ids
  * @returns  MT_BusinessPlanningControllerDTO
  *           Map<Id, MT_MediaCampaign>        : Map of MediaTransparencyCampaign id to MediaTransparencyCampaign object
  *           Map<Id, List<Id>>                : Map of MediaTransparencyCampaign id to a list of MediaBuildingBlock ids
  *           Map<Id, MT_TvTarget__c>: Map of MediaBuildingBlock id to MediaBuildingBlock object
  */
  @RemoteAction
  public static MT_BusinessPlanningControllerDTO getMediaBuildingBlock(List<Id> mbbIds) {
    return new MT_BusinessPlanningControllerDTO().initGetMediaBuildingBlockWrapper(
      MT_MediaBuildingBlockService.getMediaBuildingBlocksByIds(new Set<Id>(mbbIds))
    );
  }

  /*
  * Remote Action that is accessed by Javascript to load MediaBuildingBlockMonthlyPlans with MediaFlights included
  *
  * @param    List<Id> mbbIds want a list of MediaBuildingBlock ids
  * @returns  MT_BusinessPlanningControllerDTO
  *           Map<Id, List<MT_MediaCampaignMonthlyPlan__c>>: Map of MediaBuildingBlock ids to a list of MediaBuildingBlockMonthlyPlan objects with MediaFlights included
  */
  @RemoteAction
  public static MT_BusinessPlanningControllerDTO getMediaBuildingBlockMonthlyPlanWithMediaFlights(List<Id> mcIds) {
    return new MT_BusinessPlanningControllerDTO().initGetMediaBuildingBlockMonthlyPlanWithMediaFlightsWrapper( 
      MT_MediaBuildingBlockMonthlyPlanService.getMediaBuildingBlockMonthlyPlansWithMediaFlightsByParentIds(new Set<Id>(mcIds))
    );
  }

  /*
  * Remote Action that is accessed by Javascript to save changes to the database
  *
  * @param    MT_BusinessPlanningControllerDTO data want a MT_BusinessPlanningControllerDTO
  * @returns  An updated MT_BusinessPlanningControllerDTO
  *           Map<Id, List<MT_MediaCampaignMonthlyPlan__c>>: Map of MediaBuildingBlock ids to a list of MediaBuildingBlockMonthlyPlan objects with MediaFlights included
  */
  @RemoteAction
  public static MT_BusinessPlanningControllerDTO upsertMediaBuildingBlockMonthlyPlansWithMediaFlights(MT_BusinessPlanningControllerDTO data) {
    data.upsertData();

    return MT_BusinessPlanningController.getMediaBuildingBlockMonthlyPlanWithMediaFlights(new List<Id>(data.mediaBuildingBlockMonthlyPlan.keySet()));
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

  /* MT_BusinessPlanningControllerDTO that holds and combines the fetched data from the server in readable junks for the front end. */
  public class MT_BusinessPlanningControllerDTO {

    Map<Id, MT_TvTarget__c> mediaBuildingBlocks;
    Map<Id, MT_MediaCampaign__c> mediaCampaigns;
    Map<Id, List<Id>> campaignToBuildingBlocksMapping;
    public Map<Id, List<MT_MediaCampaignMonthlyPlan__c>> mediaBuildingBlockMonthlyPlan;
    public Map<Id, List<MT_MediaFlight__c>> monthlyPlanIdsToMediaFlights;

    public MT_BusinessPlanningControllerDTO() {
    }

    /*
    * Method to save a given DTO to the data base
    *
    * @param   none
    * @returns void
    */
    public void upsertData() {
      if (this.mediaCampaigns != null && !this.mediaCampaigns.isEmpty()) {
        upsert this.mediaCampaigns.values();
      }

      if (this.mediaBuildingBlocks != null && !this.mediaBuildingBlocks.isEmpty()) {
        upsert this.mediaBuildingBlocks.values();
      }

      if (this.mediaBuildingBlockMonthlyPlan != null && !this.mediaBuildingBlockMonthlyPlan.isEmpty()) {
        List<MT_MediaCampaignMonthlyPlan__c> plans = new List<MT_MediaCampaignMonthlyPlan__c>();

        for (Id mbbId : this.mediaBuildingBlockMonthlyPlan.keySet()) {
          plans.addAll(this.mediaBuildingBlockMonthlyPlan.get(mbbId));
        }

        upsert(plans);
      }

      if (this.monthlyPlanIdsToMediaFlights != null && !this.monthlyPlanIdsToMediaFlights.isEmpty()) {
        List<RecordType> recordTypes = [Select Id, DeveloperName from RecordType WHERE SobjectType = :MT_MediaFlightSelector.objectAPIName];
        Map<String, Id> recordTypeIds = new Map<String, Id>();

        for (RecordType rt : recordTypes) {
          recordTypeIds.put(rt.DeveloperName, rt.Id);
        }

        List<MT_MediaFlight__c> flightsToInsert = new List<MT_MediaFlight__c>();
        List<MT_MediaFlight__c> flightsToUpdate = new List<MT_MediaFlight__c>();
        List<MT_MediaFlight__c> flightsToDelete = new List<MT_MediaFlight__c>();
        system.debug(this.monthlyPlanIdsToMediaFlights);
        system.debug(this.monthlyPlanIdsToMediaFlights);
        for (Id mpId : this.monthlyPlanIdsToMediaFlights.keySet()) {
          for (MT_MediaFlight__c flight : this.monthlyPlanIdsToMediaFlights.get(mpId)) {
            Boolean hasId = flight.Id != null;
            if (flight.MT_BMVAmount__c > 0) {
              if (flight.RecordTypeId == null && flight.RecordType != null) {
                flight.RecordTypeId = recordTypeIds.get(flight.RecordType.Name);
                flight.RecordType = null;
              }

              if (hasId) {
                flightsToUpdate.add(flight);
              } else {
                flightsToInsert.add(flight);
              }
            } else if (hasId) {
              flightsToDelete.add(flight);
            }
          }
        }

        insert flightsToInsert;
        update flightsToUpdate;
        delete flightsToDelete;
      }
    }

    /*
    * Method to fill maps with data from the data base.
    *
    * @param    List<MT_TvTarget__c> blocks want a list of MediaBuildingBlock objects
    * @returns  MT_BusinessPlanningControllerDTO with:
    *             MediaTransparencyCampaign ids mapped to MediaTransparencyCampaign objects
    *             MediaTransparencyCampaign ids mapped to a list of MediaBuildingBlock ids
    *             MediaBuildingBlock ids mapped to MediaBuildingBlock objects
    */
    public MT_BusinessPlanningControllerDTO initGetMediaBuildingBlockWrapper(List<MT_TvTarget__c> blocks) {
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
        if (block.MT_MediaCampaign_ref__r != null)
          block.MT_MediaCampaign_ref__r = null;
        this.mediaBuildingBlocks.put(block.Id, block);
      }
      return this;
    }

    /*
    * Method to fill maps with data from the data base.
    *
    * @param    List<MT_MediaCampaignMonthlyPlan__c> plans want a list of MediaBuildingBlockMonthlyPlan objects
    * @returns  MT_BusinessPlanningControllerDTO with:
    *             MediaBuildingBlock ids mapped to a list of MediaBuildingBlockMonthlyPlan objects
    */
    public MT_BusinessPlanningControllerDTO initGetMediaBuildingBlockMonthlyPlanWrapper(List<MT_MediaCampaignMonthlyPlan__c> plans) {
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

    /*
    * Method to fill maps with data from the data base.
    *
    * @param    List<MT_MediaCampaignMonthlyPlan__c> plans want a list of MediaBuildingBlockMonthlyPlan objects
    * @returns  MT_BusinessPlanningControllerDTO with:
    *             MediaBuildingBlock ids mapped to a list of MediaBuildingBlockMonthlyPlan objects that held informations about MediaFlight objects
    */
    public MT_BusinessPlanningControllerDTO initGetMediaBuildingBlockMonthlyPlanWithMediaFlightsWrapper(List<MT_MediaCampaignMonthlyPlan__c> plans) {
      system.debug(plans);
      this.initGetMediaBuildingBlockMonthlyPlanWrapper(plans);
      return this;
    }
  }
}