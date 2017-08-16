/************************************************************************************************************
Name:  		MT_FieldSet
======================================================
Purpose: 	Utility class for handling FieldSet. Singletong pattern to cache the values
======================================================
History
-------
Date		AUTHOR						DETAIL
15.12.2016	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
public with sharing class MT_FieldSet {
  private static MT_FieldSet instance = null;
  private Map<String, Set<String>> fieldSets = null;

  private MT_FieldSet() {
    fieldSets = new Map<string, Set<String>>();
  }
  public static Set<String> getFields(Schema.FieldSet fs) {
    if (instance == null)
      instance = new MT_FieldSet();

    String key = String.valueOf(fs.getSObjectType()) + '_' + fs.getName();
    if (instance.fieldSets.containsKey(key))
      return instance.fieldSets.get(key);

    Set<String> fields = new Set<String>();
    List<Schema.FieldSetMember> flds = fs.getFields();
    for (Schema.FieldSetMember f : flds) {
      fields.add(f.getFieldPath());
    }

    instance.fieldSets.put(key, fields);
    return fields;
  }
  public static Set<String> getFields(List<Schema.FieldSetMember> fsmList) {
    Set<String> fields = new Set<String>();
    for (Schema.FieldSetMember f : fsmList) {
      fields.add(f.getFieldPath());
    }
    return fields;
  }
}