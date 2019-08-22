/**
 * Created by YuriiDyvak on 19.08.2019.
 */

public with sharing class ScrumTrackTimeController {

    @AuraEnabled
    public static List<TrackTime__c> getTrackTimes(String subtaskId) {
        ScrumTrackTimeService service = (ScrumTrackTimeService) Application.Service.get(ScrumTrackTimeService.class);
        return service.getTrackTimes(subtaskId);
    }

    @AuraEnabled
    public static Subtask__c getSubtask(String subtaskId) {
        ScrumSubtaskService service = (ScrumSubtaskService) Application.Service.get(ScrumSubtaskService.class);
        return service.getSubtask(subtaskId);
    }

    @AuraEnabled
    public static void removeTrackTime(String trackId){
        ScrumSubtaskService service = (ScrumSubtaskService) Application.Service.get(ScrumSubtaskService.class);
        service.removeTrackTime(trackId);
    }

}