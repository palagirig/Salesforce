/**
 * Provides access to media building block records in different contexts.
 */
global with sharing class MT_MediaBuildingBlockService {
  private static Set<String> contextFields = null;

  /**
   * Return the media building blocks to the given ids. Uses predefined fieldsets to populate the
   * records.
   *
   * @see MT_MediaBuildingBlockService.getContextFields
   *
   * @param Set<ID> blockIds The ids of the media building blocks to load.
   *
   * @return List<MT_MediaBuildingBlock__c> The loaded and populated media building blocks.
   */
  global static List<MT_TvTarget__c> getMediaBuildingBlocksByIds(Set<ID> blockIds) {
    return getMediaBuildingBlocksByIds(blockIds, MT_MediaBuildingBlockService.getContextFields());
  }

  /**
   * Return the media building blocks to the given ids, populated with the given fields.
   *
   * @param Set<ID> blockIds The ids of the media building blocks to load.
   * @param Set<String> fields The fields to populate media building blocks with.
   *
   * @return List<MT_MediaBuildingBlock__c> The loaded and populated media building blocks.
   */
  global static List<MT_TvTarget__c> getMediaBuildingBlocksByIds(Set<ID> blockIds, Set<String> fields) {
    return new MT_MediaBuildingBlockSelector().getRecordsByIds(blockIds, fields);
  }

  /**
   * Return the media building blocks to the given ids. Uses predefined fieldsets to populate the
   * records.
   *
   * @see MT_MediaBuildingBlockService.getContextFields
   *
   * @param Set<ID> campIds The ids of the MediaCampaign to load.
   *
   * @return List<MT_MediaBuildingBlock__c> The loaded and populated media building blocks.
   */
  global static List<MT_TvTarget__c> getMediaBuildingBlocksByMediaCampaignIds(Set<ID> campIds) {
    return getMediaBuildingBlocksByMediaCampaignIds(campIds, MT_MediaBuildingBlockService.getContextFields());
  }

  /**
   * Return the media building blocks to the given ids, populated with the given fields.
   *
   * @param Set<ID> campIds The ids of the MediaCampaign to load.
   * @param Set<String> fields The fields to populate media building blocks with.
   *
   * @return List<MT_MediaBuildingBlock__c> The loaded and populated media building blocks.
   */
  global static List<MT_TvTarget__c> getMediaBuildingBlocksByMediaCampaignIds(Set<ID> campIds, Set<String> fields) {
    return new MT_MediaBuildingBlockSelector().getRecordsByMediaCampaignIds(campIds, fields);
  }

  /**
   * Returns the default context fields to populate the media building blocks with.
   */
  private static Set<String> getContextFields() {
    if (contextFields == null) {
      contextFields = MT_FieldSet.getFields(SObjectType.MT_TvTarget__c.FieldSets.MT_ContextFields);
      contextFields.addAll(MT_FieldSet.getFields(SObjectType.MT_TvTarget__c.FieldSets.MT_YieldFields));
      contextFields.addAll(MT_FieldSet.getFields(SObjectType.MT_TvTarget__c.FieldSets.MT_VariableRevenueFields));
    }

    return contextFields;
  }
}