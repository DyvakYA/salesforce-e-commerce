/**
 * Created by YuriiDyvak on 02.08.2019.
 */

public class ScrumController {



    @AuraEnabled
    public static List<SprintRecord> getSprintsForProject(String projectId) {
        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        List<SprintRecord> result = service.getSprintsForProject(projectId);
        return result;
    }

    @AuraEnabled
    public static void removeTaskFromSprint(String recordId) {
        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        service.removeTaskFromSprint(recordId);
    }

    @AuraEnabled
    public static SprintRecord getSprintById(String sprintId) {
        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        return service.getSprintById(sprintId);
    }

    @AuraEnabled
    public static void moveTaskToBacklog(String taskId) {
        ScrumBacklogService service = (ScrumBacklogService) Application.Service.get(ScrumBacklogService.class);
        service.moveTaskToBacklog(taskId);
    }

    @AuraEnabled
    public static List<Subtask__c> getSubtasks(String taskId) {
        ScrumSubtaskService service = (ScrumSubtaskService) Application.Service.get(ScrumSubtaskService.class);
        return service.getSubtasks(taskId);
    }

}