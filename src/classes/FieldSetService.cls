/**
 * Created by YuriiDyvak on 17.07.2019.
 */

public class FieldSetService {

    public FieldSetService() {

    }

    public FieldSet getFieldsSet(String fieldSetName, SObjectType type) {
        SchemaUtil schemaUtil = (SchemaUtil) Application.Util.get(SchemaUtil.class);
        Map<String, Schema.FieldSet> fieldSets = schemaUtil.getFieldsSets(type);
        return fieldSets.get(fieldSetName);
    }

    public List<String> getFields(String fieldSetName, SObjectType type) {
        SchemaUtil schemaUtil = (SchemaUtil) Application.Util.get(SchemaUtil.class);
        return schemaUtil.getFieldsFromFieldSet(fieldSetName, type);
    }

}