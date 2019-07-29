/**
 * Created by YuriiDyvak on 23.07.2019.
 */

public class RecordListComponentService {

    private FieldSetService service;

    public RecordListComponentService() {
        service = (FieldSetService) Application.Service.get(FieldSetService.class);
    }

    public List<FieldRecord> getFieldRecords(String recordId, SObjectType type, String fieldSetName) {

        System.debug(recordId + ' : ' + type + ' : ' + fieldSetName);
        List<FieldRecord> result = new List<FieldRecord>();
        FieldSet fieldSet = service.getFieldsSet(fieldSetName, type);
        List<sObject> sObjList = getFieldsSetRecord(fieldSet, type, recordId);

        if (!sObjList.isEmpty()) {
            SObject record;
            record = sObjList.get(0);
            Map<String, Object> dataMap = getMapFromObject(record);
            dataMap.remove('attributes');
            System.debug(dataMap);

            List<String> fields = service.getFields(fieldSetName, type);

            for (String item : fields) {
                String[] size = item.split('\\.');
                System.debug(size.size());
                if (item.split('\\.').size() == 1) {
                    Object value = dataMap.get(item);
                    System.debug(item + ' : ' + value);
                    result.add(new FieldRecord(item, String.valueOf(record.get(item))));
                }
            }
        }

        System.debug(result);
        return result;
    }

    public List<SObject> getFieldsSetRecord(FieldSet fieldSet, SobjectType sObjectType, String id) {

        AbstractSelector selector = (AbstractSelector) Application.Selector.get(Account.getSObjectType());

        List<String> fields = new List<String>();
        for (Schema.FieldSetMember f : fieldSet.getFields()) {
            fields.add(f.getFieldPath());
        }
        String queryFields = String.join(fields, ',');

        String queryId = id;

        if (!id.contains('\"'))
            queryId = '\'' + id + '\'';

        System.debug(id);

        if (queryId.contains('"'))
            queryId = queryId.replace('"', '\'');

        System.debug(queryId);

        return (List<SObject>) selector.queryBuilder()
                .querySelect()
                .queryFields(queryFields)
                .queryFrom(sObjectType)
                .queryWhere('Id', queryId)
                .queryLimit(1)
                .execute();
    }

    @TestVisible
    private Map<String, Object> getMapFromObject(sObject sObj) {
        String representation = JSON.serialize(sObj);
        return (Map<String, Object>) JSON.deserializeUntyped(representation);
    }

    @TestVisible
    public class FieldRecord {

        @AuraEnabled
        public String name;

        @AuraEnabled
        public String value;

        public FieldRecord(String name, String value) {
            this.name = name;
            this.value = value;
        }
    }
}