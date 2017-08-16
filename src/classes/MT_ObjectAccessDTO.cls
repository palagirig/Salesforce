/**
 * DTO class describing the available access of a user to an object and its fields.
 */
public with sharing class MT_ObjectAccessDTO {
  public String objectName;

  public Boolean isCreateable;
  public Boolean isAccessible;
  public Boolean isUpdateable;
  public Boolean isDeletable;

  public Map<String, MT_FieldAccessDTO> fields;

  /**
   * Initialize this dto with the information of a single object.
   *
   * @param Schema.DescribeSObjectResult dor The describe result of the object.
   */
  public MT_ObjectAccessDTO(Schema.DescribeSObjectResult dor) {
    this.objectName = dor.getName();

    this.isCreateable = dor.isCreateable();
    this.isAccessible = dor.isAccessible();
    this.isUpdateable = dor.isUpdateable();
    this.isDeletable = dor.isDeletable();

    this.fields = new Map<String, MT_FieldAccessDTO>();

    Map<String, Schema.SObjectField> fieldMap = dor.fields.getMap();

    for (String fieldName : fieldMap.keySet()) {
      MT_FieldAccessDTO fa = new MT_FieldAccessDTO(fieldMap.get(fieldName).getDescribe());

      this.fields.put(fa.fieldName, fa);
    }
  }
}