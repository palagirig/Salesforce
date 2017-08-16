/**
* Name:     MT_Selector
* Purpose:  A class that can used as a helper for selector classes
*
* History
* -------
* DATE        AUTHOR                      DETAIL
* 12.04.2017  Falco Aulitzky              Adding JavaDoc-Styled documentation
*
*/

/* Class that helps the Selector classes */
public virtual class MT_Selector {
  public MT_Selector() {
  }

  /*
  * Constructs a String from given fields so that it can be used in a SOQL query
  * 
  * @param    List<Schema.FieldSetMember> fields wants a list of fields that can be queried
  * @returns  String that contains all fields that can be queried
  */
  public String constructFieldString(List<Schema.FieldSetMember> fields) {
    Boolean hasIdField = false;
    List<String> fieldsList = new List<String>();

    for (Schema.FieldSetMember f : fields) {
      if (f.getFieldPath().toLowerCase() == 'id') {
        hasIdField = true;
      }

      fieldsList.add(f.getFieldPath());
    }

    if (!hasIdField) {
      fieldsList.add('Id');
    }

    return String.join(fieldsList, ',');
  }

  /*
  * Constructs a String from a given Set of ids 
  * 
  * @param    Set<Id> ids set of ids
  * @returns  String that contains all values to look into
  */
  public String constructInClauseString(Set<Id> ids) {
    List<String> cache = new List<String>();
    for (Id recordId : ids) {
      cache.add('\'' + recordId + '\'');
    }
    String idsStr = String.join(cache, ',');

    return '(' + idsStr + ')';
  }

  /*
  * Constructs a String from a given Set of Strings 
  * 
  * @param    Set<String> strings set of strings
  * @returns  String that contains all values to look into
  */
  public String constructInClauseString(Set<String> strings) {
    List<String> cache = new List<String>();
    for (String s : strings) {
      cache.add('\'' + s + '\'');
    }
    String idsStr = String.join(cache, ',');

    return '(' + idsStr + ')';
  }

  /*
  * Constructs a String from a given List of Strings 
  * 
  * @param    List<String> strings list of strings
  * @returns  String that contains all fields that need to be queried
  */
  public String constructFieldString(List<String> fields) {
    Boolean hasIdField = false;
    List<String> fieldsList = new List<String>();
    for (String f : fields) {
      if (f.toLowerCase() == 'id')
        hasIdField = true;
      fieldsList.add(f);
    }
    if (!hasIdField)
      fieldsList.add('Id');
    return String.join(fieldsList, ',');
  }

  /*
  * Constructs a String from a given Set of Strings 
  * 
  * @param    Set<String> strings set of strings
  * @returns  String that contains all fields that need to be queried
  */
  public String constructFieldString(Set<String> fields) {
    Boolean hasIdField = false;
    List<String> fieldsList = new List<String>();
    for (String f : fields) {
      if (f.toLowerCase() == 'id')
        hasIdField = true;
      fieldsList.add(f);
    }
    if (!hasIdField)
      fieldsList.add('Id');
    return String.join(fieldsList, ',');
  }
}