/**
 * Created by YuriiDyvak on 26.07.2019.
 */

public class ScrumProjectController {

    @AuraEnabled
    public static Project__c getProject(String id) {
        System.debug('Input -> Id : ' + id);
        ScrumProjectService service = (ScrumProjectService) Application.Service.get(ScrumProjectService.class);
        Project__c result = service.getProject('a092p00003LrRmTAAV');
        System.debug('Output -> Result :' + result);
        return result;
    }
}