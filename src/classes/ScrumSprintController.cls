/**
 * Created by YuriiDyvak on 26.07.2019.
 */

public class ScrumSprintController {

    @AuraEnabled
    public static List<Sprint__c> getSprintsForProject(String id) {
        System.debug('Input -> Id : ' + id);
        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        List<Sprint__c> result = service.getSprintsForProject('a092p00003LrRmTAAV');
        System.debug('Output -> Result :' + result);
        return result;
    }

}