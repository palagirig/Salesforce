/**
 * Unit test for <code>MT_MediaCampaignSelector</code> class.
 *
 * @author Fabio Andree Scheurel (MaibornWolff GmbH)
 */
@IsTest
private class MT_MediaCampaignSelector_Test {

  @IsTest
  private static void testGetRecordsByKrsIdsWithEmptySet() {
    Test.startTest();
    List<SObject> result = new MT_MediaCampaignSelector().getRecordsByKrsIds(new Set<String>(), new Set<String>());
    Test.stopTest();

    System.assertNotEquals(null, result, 'A null result was returned');
    System.assertEquals(0, result.size(), 'An other number of records was returned than should be.');
  }

  @IsTest
  private static void testGetRecordsByKrsIds() {
    MT_Test.Init();

    Set<String> krsIds = new Set<String>();

    List<MT_MediaCampaign__c> campaigns = [SELECT MT_KRSID__c
                                            FROM MT_MediaCampaign__c];
    for (Integer i = 0; i < campaigns.size(); i++) {
      MT_MediaCampaign__c campaign = campaigns.get(i);
      campaign.MT_KRSID__c = 'testAAA#' + i;
      krsIds.add(campaign.MT_KRSID__c);
    }
    update campaigns;

    Set<String> fields = new Set<String> {
      MT_MediaCampaign__c.Id.getDescribe().getName(),
      MT_MediaCampaign__c.Name.getDescribe().getName(),
      MT_MediaCampaign__c.MT_KRSID__c.getDescribe().getName(),
      MT_MediaCampaign__c.MT_MediaCampaignType_ref__c.getDescribe().getName()
    };

    MT_MediaCampaignSelector sel = new MT_MediaCampaignSelector();

    Test.startTest();
    List<sObject> records = sel.getRecordsByKrsIds(krsIds, fields);
    Test.stopTest();

    System.assertNotEquals(null, records, 'No records were returned');
    System.assertEquals(campaigns.size(), records.size(), 'An other number of records was returned than should be.');

    System.assertEquals(true, records instanceof List<MT_MediaCampaign__c>, 'Returned results are not of instance ' + MT_MediaCampaign__c.getSObjectType().getDescribe().getName());

    for (MT_MediaCampaign__c campaign : (List<MT_MediaCampaign__c>) records) {
      for (String field : fields) {
        System.assertNotEquals(null, campaign.get(field), 'Field ' + field + ' has not been selected!');
      }
      System.assertEquals(true, krsIds.contains(campaign.MT_KRSID__c), 'A campaign with an unknown KRS ID has been returned. KRS ID: ' + campaign.MT_KRSID__c);
      krsIds.remove(campaign.MT_KRSID__c);
    }

    System.assert(krsIds.isEmpty(), 'All KRS IDs should have been found and returned, but these are ' + krsIds.size() + ' missing!');
  }
}