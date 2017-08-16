/**
 * DTO class describing the available access of a user to a field.
 */
public with sharing class MT_FieldAccessDTO {
  public String fieldName;

  public Boolean isAccessible;
  public Boolean isUpdateable;

  /**
   * Initialize this dto with the information of a single object.
   *
   * @param Schema.DescribeSObjectResult dor The describe result of the object.
   */
  public MT_FieldAccessDTO(Schema.DescribeFieldResult dfr) {
    this.fieldName = dfr.getName();

    this.isAccessible = dfr.isAccessible();
    this.isUpdateable = dfr.isUpdateable();
  }
}