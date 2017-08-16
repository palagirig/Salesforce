/**
 * Selector class for the MT_CampaignImportData__c.
 *
 * @author Fabio Andree Scheurel (MaibornWolff GmbH)
 */
public with sharing class MT_CampaignImportDataSelector extends MT_Selector {
  public static final String OBJECT_API_NAME = MT_CampaignImportData__c.SObjectType.getDescribe().getName();


  /**
   * Returns a query locator on all recods in the database.
   *
   * @param fields List of fields to include
   * @return Query Locator on all records, including all the
   * provided <code>fields</code>
   */
  public Database.QueryLocator queryLocatorForAll(Set<String> fields) {
    String query = 'SELECT ' + constructFieldString(fields) + ' FROM ' + MT_CampaignImportDataSelector.OBJECT_API_NAME;
    System.debug(query);
    return Database.getQueryLocator(query);
  }
}