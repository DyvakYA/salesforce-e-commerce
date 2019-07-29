/**
 * Created by YuriiDyvak on 23.07.2019.
 */

public with sharing class SchemaUtil {

    public Map<String, Schema.FieldSet> getFieldsSets(SObjectType type) {
        Schema.DescribeSObjectResult d = type.getDescribe();
        return d.fieldSets.getMap();
    }

    public List<String> getFieldsFromFieldSet(String fieldSetName, SObjectType type) {

        List<String> result = new List<String>();
        Map<String, Schema.FieldSet> fieldSets = this.getFieldsSets(type);
        FieldSet fieldSet = fieldSets.get(fieldSetName);
        List<FieldSetMember> fieldSetMembers = fieldSet.getFields();
        for (FieldSetMember member : fieldSetMembers) {
            result.add(member.getFieldPath());
        }
        return result;
    }

    public sObjectType getSObjectType(String sObjectType) {
        return Schema.getGlobalDescribe().get(sObjectType);
    }

}