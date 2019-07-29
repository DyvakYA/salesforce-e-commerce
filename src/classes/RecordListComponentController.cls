/**
 * Created by YuriiDyvak on 19.07.2019.
 */

public class RecordListComponentController {

    @AuraEnabled
    public static List<RecordListComponentService.FieldRecord> getFieldRecords(String sObjectType, String sObjectId, String fieldSetName) {
        SchemaUtil util = (SchemaUtil) Application.Util.get(SchemaUtil.class);
        SObjectType type = util.getSObjectType(sObjectType);
        RecordListComponentService service = (RecordListComponentService) Application.Service.get(RecordListComponentService.class);
        return service.getFieldRecords(sObjectId, type, fieldSetName);
    }

}