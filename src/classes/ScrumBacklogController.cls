/**
 * Created by YuriiDyvak on 26.07.2019.
 */

public class ScrumBacklogController {

    @AuraEnabled
    public static List<Task__c> getBacklogs() {
        ScrumBacklogService service = (ScrumBacklogService) Application.Service.get(ScrumBacklogService.class);
        List<Task__c> result = service.getBacklogs();
        System.debug('Output -> Result :' + result);
        return result;
    }
}