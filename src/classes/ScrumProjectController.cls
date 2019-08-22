/**
 * Created by YuriiDyvak on 08.08.2019.
 */

public class ScrumProjectController {

    @AuraEnabled
    public static ScrumSprintRecord getSprintById(String sprintId) {
        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        return service.getSprintRecord(sprintId);
    }

    @AuraEnabled
    public static void moveTaskToSprint(String sprintId, String taskId) {
        ScrumBacklogService service = (ScrumBacklogService) Application.Service.get(ScrumBacklogService.class);
        service.moveTaskToSprint(sprintId, taskId);
    }

    @AuraEnabled
    public static List<ScrumTaskRecord> getBacklogs() {
        ScrumBacklogService service = (ScrumBacklogService) Application.Service.get(ScrumBacklogService.class);
        List<ScrumTaskRecord> backlogs = service.getBacklogs();
        System.debug(backlogs);
        return backlogs;
    }

    @AuraEnabled
    public static Project__c getProject(String projectId) {
        ScrumProjectService service = (ScrumProjectService) Application.Service.get(ScrumProjectService.class);
        Project__c result = service.getProject(projectId);
        return result;
    }

    @AuraEnabled
    public static List<Project__c> getProjects() {
        ScrumProjectService service = (ScrumProjectService) Application.Service.get(ScrumProjectService.class);
        return service.getProjects();
    }

}