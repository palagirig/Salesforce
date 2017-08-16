/************************************************************************************************************
Name:  		MT_Config
======================================================
Purpose: 	Configuration wrapper for a Media Transperancy Angular App. Contains all the information of the org
needed for app to run. Example like : object and fields describes, custom settings etc.
======================================================
History
-------
Date		AUTHOR						DETAIL
17.11.2016	Duc Nguyen Tien             Initial architecture & development
*************************************************************************************************************/
public class MT_Config {
  private static MT_Config instance = null;
  private MT_Config() {
  }
  public static MT_Config getInstance() {
    if (instance == null)
      instance = new MT_Config();
    return instance;
  }

  public map<Integer, String> monthMapping = new Map<Integer, String>{
    // Provide the label key for each month value (see MT_Labels)
    1 => 'JANUARY',
    2 => 'FEBRUARY',
    3 => 'MARCH',
    4 => 'APRIL',
    5 => 'MAY',
    6 => 'JUNE',
    7 => 'JULY',
    8 => 'AUGUST',
    9 => 'SEPTEMBER',
    10 => 'OCTOBER',
    11 => 'NOVEMBER',
    12 => 'DECEMBER'
  };

  public MT_Config loadObjectsSchemaConf(List<Schema.sObjectType> objTypes) {
    for (Schema.SObjectType stype : objTypes) {
      Schema.DescribeSObjectResult dsr = stype.getDescribe();
      this.objectsSchema.put(dsr.getName(), new ObjectSchemaDTO(dsr));

    }
    return this;
  }

  public Map<String, ObjectSchemaDTO> objectsSchema {
    get {
      if (objectsSchema == null)
        objectsSchema = new Map<String, ObjectSchemaDTO>();
      return objectsSchema;
    }
    set;
  }
  public MT_Config prepareForSerialization() {
    return this;
  }

  public static String ERR_ContextAlreadySet = 'Context Object Already Set';

  public class MT_ConfigException extends Exception {
  }
  public class ObjectSchemaDTO {
    public String name = '';
    public String label = '';
    public String labelPlural = '';
    public String objKeyPrefix = '';
    public Map<String, FieldSchemaDTO> fieldsLabel = new Map<String, FieldSchemaDTO>();
    public ObjectSchemaDTO(Schema.DescribeSObjectResult dsr) {
      this.name = dsr.getName();
      this.label = dsr.getLabel();
      this.labelPlural = dsr.getLabelPlural();
      this.objKeyPrefix = dsr.getKeyPrefix();
      for (Schema.SObjectField sof : dsr.fields.getMap().values()) {
        Schema.DescribeFieldResult dfr = sof.getDescribe();
        this.fieldsLabel.put(dfr.getName(), new FieldSchemaDTO(dfr));
      }
    }
  }
  public class FieldSchemaDTO {
    public String name = '';
    public String label = '';
    public String type = '';
    public Boolean isCalculated;
    public Integer length = -1;
    public Integer precision = -1;
    public Integer scale = -1;
    public Boolean isAutoNumber;
    public Object defaultValue = null;
    public FieldSchemaDTO(Schema.DescribeFieldResult dfr) {
      this.name = dfr.getName();
      this.label = dfr.getLabel();
      this.type = dfr.getType().name();
      this.isCalculated = dfr.isCalculated();
      this.length = dfr.getLength();
      this.precision = dfr.getPrecision();
      this.scale = dfr.getScale();
      this.isAutoNumber = dfr.isAutoNumber();
      this.defaultValue = dfr.getDefaultValue();
    }
  }
}