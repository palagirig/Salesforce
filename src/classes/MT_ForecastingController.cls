/************************************************************************************************************
Name:     MT_ForecastingController
======================================================
Purpose:  Controller for a page, MT_Forecasting.page. Contains all the method for an angular app to access
      the sfdc db. Refered as Backend
======================================================
History
-------
Date        AUTHOR                      DETAIL
09.03.2017  Falco Aulitzky         Class created
13.03.2017  Falco Aulitzky             Initial architecture & development
20.03.2017  Falco Aulitzky             Creating DTOs and Data structure
*************************************************************************************************************/




/*
Version             (MFVer) Header
  Segment           (U)     D&A
    Business Units      (U)       Online
      Asset         (A)         Studio71
        Campaign Type   (MCT)         WKZ S71
          Values    (MFVal)         100


Query:
-> (All) Version (default last) -> (VersionId) Values (Queried one / Media Campaign Type) -> (MCTId) Media Campaign Type (Queried ones, Assets)
*/

public with sharing class MT_ForecastingController {
  public MT_ForecastingController(ApexPages.StandardController stdController) {
  }

  @RemoteAction
  public static MT_ForecastingDTO loadForecastingData(List<String> year) {
    return new MT_ForecastingDTO().getForecastingData(year);
  }

  @RemoteAction
  public static MT_VersionDTO loadForecastVersions(List<String> year) {
    Integer stringToInteger = Integer.valueOf(year.get(0));
    return new MT_VersionDTO().getVersionData(
      MT_MediaForecastVersionService.getMediaForecastVersionsForYear(stringToInteger)
    );
  }

  @RemoteAction
  public static MT_ValueDTO loadForecastValuesByVersionIds(List<Id> versionIds) {
    return new MT_ValueDTO().getValueData(
      MT_MediaForecastValueService.getMediaForecastValuesByForecastVersionIds(new Set<Id>(versionIds))
    );
  }

  @RemoteAction
  public static MT_CampaignTypeDTO loadMediaCampaignTypesByIds(List<Id> campaignIds) {
    return new MT_CampaignTypeDTO().getCampaignTypeData(
      MT_MediaCampaignTypeService.getMediaCampaignTypesByIds(new Set<Id>(campaignIds))
    );
  }

  @RemoteAction
  public static MT_AssetDTO loadAssetsByIds(List<Id> assetIds) {
    return new MT_AssetDTO().getAssetData(
      MT_AssetService.getAssetsByIds(new Set<Id>(assetIds))
    );
  }

  @RemoteAction
  public static MT_UnitDTO loadUnitsByIds(List<Id> unitIds) {
    return new MT_UnitDTO().getUnitData(
      MT_UnitService.getUnitsByIds(new Set<Id>(unitIds))
    );
  }

  @RemoteAction
  public static MT_ForecastingDTO upsertForecastValueData(MT_ValueDTO data, String year) {
    data.upsertData();
    return MT_ForecastingController.loadForecastingData(new List<String>{
      year
    });
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

  public class MT_ForecastingDTO {
    public MT_VersionDTO versions;
    public MT_ValueDTO values;
    public MT_CampaignTypeDTO campaignTypes;
    public MT_AssetDTO assets;
    public MT_UnitDTO units;

    public MT_ForecastingDTO() {
    }

    public MT_ForecastingDTO getForecastingData(List<String> year) {

      versions = MT_ForecastingController.loadForecastVersions(year);
      List<Id> ids = new List<Id>();

      for (MT_ForecastVersion__c version: versions.objectList) {
        ids.add(version.Id);
      }

      values = MT_ForecastingController.loadForecastValuesByVersionIds(ids); // Version Ids
      ids.clear();

      for (MT_ForecastValue__c value: values.objectList) {
        ids.add(value.MT_MediaCampaignType__c);
      }

      campaignTypes = MT_ForecastingController.loadMediaCampaignTypesByIds(ids); //Values.MCTId
      ids.clear();

      for (MT_MediaCampaignType__c campaignType: campaignTypes.objectList) {
        ids.add(campaignType.MT_Asset_ref__c);
      }

      assets = MT_ForecastingController.loadAssetsByIds(ids); // CT.AssetId
      ids.clear();

      for (P7S1_Asset__c asset: assets.objectList) {
        ids.add(asset.P7S1_Unit__c);
      }

      units = MT_ForecastingController.loadUnitsByIds(ids); // asset.UnitId

      return this;
    }
  }

  public class MT_VersionDTO {
    public List<MT_ForecastVersion__c> objectList;

    public MT_VersionDTO() {
    }

    public MT_VersionDTO getVersionData(List<MT_ForecastVersion__c> versions) {
      this.objectList = versions;

      return this;
    }
  }

  public class MT_ValueDTO {
    public List<MT_ForecastValue__c> objectList;

    public MT_ValueDTO() {
    }

    public MT_ValueDTO getValueData(List<MT_ForecastValue__c> values) {
      this.objectList = values;

      return this;
    }

    public void upsertData() {
      if (!objectList.isEmpty()) {
        upsert(objectList);
      }
    }
  }

  public class MT_CampaignTypeDTO {
    public List<MT_MediaCampaignType__c> objectList;

    public MT_CampaignTypeDTO() {
    }

    public MT_CampaignTypeDTO getCampaignTypeData(List<MT_MediaCampaignType__c> campaignTypes) {
      this.objectList = campaignTypes;
      return this;
    }
  }

  public class MT_AssetDTO {
    public List<P7S1_Asset__c> objectList;

    public MT_AssetDTO() {
    }

    public MT_AssetDTO getAssetData(List<P7S1_Asset__c> assets) {
      this.objectList = assets;
      return this;
    }
  }

  public class MT_UnitDTO {
    public List<P7S1_Unit__c> objectList;

    public MT_UnitDTO() {
    }

    public MT_UnitDTO getUnitData(List<P7S1_Unit__c> units) {
      this.objectList = units;
      return this;
    }
  }
}