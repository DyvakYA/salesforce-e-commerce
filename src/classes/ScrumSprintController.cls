/**
 * Created by YuriiDyvak on 02.08.2019.
 */

public class ScrumSprintController {

    @AuraEnabled
    public static List<ScrumSprintRecord> getSprintsForProject(String projectId) {
        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        return service.getSprintRecordsForProject(projectId);
    }

    @AuraEnabled
    public static void removeTaskFromSprint(String recordId) {
        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        service.removeTaskFromSprint(recordId);
    }

    @AuraEnabled
    public static ScrumSprintRecord getSprintById(String sprintId) {
        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        return service.getSprintRecord(sprintId);
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

    @AuraEnabled
    public static void trackTimeForSubtask(String subtaskId, String sprintId, String taskId, Integer trackTime) {
        ScrumTrackTimeService trackTimeService = (ScrumTrackTimeService) Application.Service.get(ScrumTrackTimeService.class);
        trackTimeService.trackTime(subtaskId, sprintId, taskId, trackTime);
        ScrumSubtaskService subtaskService = (ScrumSubtaskService) Application.Service.get(ScrumSubtaskService.class);
        subtaskService.updateSubtaskSpendTime(subtaskId);
    }
}