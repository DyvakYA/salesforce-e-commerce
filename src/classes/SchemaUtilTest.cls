/**
 * Created by YuriiDyvak on 25.07.2019.
 */

@isTest
public with sharing class SchemaUtilTest {

    @isTest
    public static void schemaUtilTest() {
        SchemaUtil schemaUtil = new SchemaUtil();
        List<String> result = schemaUtil.getFieldsFromFieldSet('test', Account.SObjectType);
        System.assert(result.size() > 0);
    }

    @isTest
    public static void schemaUtilGetFieldsSetTest() {
        SchemaUtil schemaUtil = new SchemaUtil();
        Map<String, Schema.FieldSet> result = schemaUtil.getFieldsSets(Account.SObjectType);
        System.assert(result.keySet().size() > 0);
    }
}