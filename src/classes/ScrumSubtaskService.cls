/**
 * Created by YuriiDyvak on 07.08.2019.
 */

public class ScrumSubtaskService {

    public List<Subtask__c> getSubtasks(String taskId) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Subtask__c.getSObjectType());
        return (List<Subtask__c>) selector.queryBuilder()
                .querySelect()
                .queryFields('Id, Name, PlanTime__c, SpendTime__c, Type__c')
                .queryFrom(Subtask__c.getSObjectType())
                .queryWhere('Task__c', taskId)
                .execute();
    }

    public Subtask__c getSubtask(String subTaskId) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Subtask__c.getSObjectType());
        return (Subtask__c) selector.queryBuilder()
                .querySelect()
                .queryFields('Id, Name, PlanTime__c, SpendTime__c, Type__c')
                .queryFrom(Subtask__c.getSObjectType())
                .queryWhere('Id', subTaskId)
                .queryLimit(1)
                .execute();
    }

    public void updateSubtaskSpendTime(List<TrackTime__c> newTrackTimes) {
        List<Subtask__c> result = new List<Subtask__c>();

        Set<Id> subtaskIds = new Set<Id>();
        for (SObject trackTime : newTrackTimes) {
            TrackTime__c track = (TrackTime__c) trackTime;
            subtaskIds.add(track.Subtask__c);
        }

        List<Subtask__c> subtasks = [SELECT Id FROM Subtask__c WHERE Id = :subtaskIds];

        List<TrackTime__c> trackTimes = [SELECT Id, Subtask__c, Track__c FROM TrackTime__c WHERE Subtask__c = :subtaskIds];

        for (Subtask__c subtask : subtasks) {
            Decimal spendTime = 0;

            for (TrackTime__c trackTime : trackTimes) {
                if (trackTime.Subtask__c == subtask.Id) {
                    spendTime += trackTime.Track__c;
                }
            }

            subtask.SpendTime__c = spendTime;
            result.add(subtask);
        }

        update result;
    }

    public void updateSubtaskSpendTime(String subtaskId) {
        List<Subtask__c> result = new List<Subtask__c>();

        Set<Id> subtaskIds = new Set<Id>();
        subtaskIds.add(Id.valueOf(subtaskId));

        List<Subtask__c> subtasks = [SELECT Id FROM Subtask__c WHERE Id = :subtaskIds];

        List<TrackTime__c> trackTimes = [SELECT Id, Subtask__c, Track__c FROM TrackTime__c WHERE Subtask__c = :subtaskIds];

        for (Subtask__c subtask : subtasks) {
            Decimal spendTime = 0;

            for (TrackTime__c trackTime : trackTimes) {
                if (trackTime.Subtask__c == subtask.Id) {
                    spendTime += trackTime.Track__c;
                }
            }

            subtask.SpendTime__c = spendTime;
            result.add(subtask);
        }

        update result;
    }

    public void removeTrackTime(String trackId) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(TrackTime__c.getSObjectType());
        selector.deleteById(trackId);
    }

}