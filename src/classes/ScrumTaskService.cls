/**
 * Created by YuriiDyvak on 15.08.2019.
 */

public with sharing class ScrumTaskService {

    public void updateTaskSpendTime(List<TrackTime__c> newTrackTimes) {
        List<Task__c> result = new List<Task__c>();

        Set<Id> taskIds = new Set<Id>();
        for (TrackTime__c trackTime : newTrackTimes) {
            TrackTime__c track = (TrackTime__c) trackTime;
            taskIds.add(track.Task__c);
        }

        List<Task__c> tasks = [SELECT Id FROM Task__c WHERE Id = :taskIds];

        List<TrackTime__c> trackTimes = [SELECT Id, Task__c FROM TrackTime__c WHERE Subtask__c = :taskIds];

        for (Task__c task : tasks) {
            Decimal spendTime = 0;

            for (TrackTime__c trackTime : trackTimes) {
                if (trackTime.Task__c == task.Id) {
                    spendTime += trackTime.Track__c;

                }
            }

            System.debug(spendTime);
            //Task__c newTask = new Task__c(Id = task.Id, Total_Spend_Time__c = spendTime);
            //result.add(newTask);
        }

        insert result;
    }

}