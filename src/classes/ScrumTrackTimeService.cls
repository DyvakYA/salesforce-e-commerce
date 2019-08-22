/**
 * Created by YuriiDyvak on 13.08.2019.
 */

public with sharing class ScrumTrackTimeService {

    public void trackTime(String subtaskId, String sprintId, String taskId, Integer trackTime) {
        AbstractSelector selector = (AbstractSelector) Application.Selector.get(TrackTime__c.getSObjectType());
        TrackTime__c track = new TrackTime__c(Name = 'Track Time ' + taskId, Sprint__c = sprintId, Task__c = taskId, Subtask__c = subtaskId, Track__c = trackTime);
        selector.save(track);
    }

    public List<TrackTime__c> getTrackTimes(String subtaskId) {


        AbstractSelector selector = (AbstractSelector) Application.Selector.get(TrackTime__c.getSObjectType());

        return (List<TrackTime__c>) selector.queryBuilder()
                .querySelect()
                .queryFields('Id, Name, Track__c, CreatedDate, Task__c, Sprint__c, Subtask__c')
                .queryFrom(TrackTime__c.getSObjectType())
                .queryWhere('Subtask__c', subtaskId)
                .execute();
    }

}