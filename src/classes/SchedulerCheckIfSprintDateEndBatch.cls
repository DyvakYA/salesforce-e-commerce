/**
 * Created by YuriiDyvak on 20.08.2019.
 */


public with sharing class SchedulerCheckIfSprintDateEndBatch implements Database.Batchable<sObject>, Database.Stateful {

    public final String myQuery = '[SELECT Id FROM Sprint__c WHERE Date_finish__c < today]';
    public String errMsg = '';

    public void execute(Database.BatchableContext param1, List<sObject> scope) {
        List<Task__c> recordsForUpdate = new List<Task__c>();

        List<Sprint__c> sprints = (List<Sprint__c>) scope;
        Set<Id> ids = new Set<Id>();
        for (Sprint__c sprint : sprints) {
            ids.add(sprint.Id);
        }
        List<Task__c> tasks = [SELECT Id FROM Task__c WHERE Sprint__c = :ids];
        for (Task__c task : tasks) {
            if (task.Total_Subtask_Estimate__c > task.Total_Spend_Time__c) {
                recordsForUpdate.add(new Task__c(Id = task.Id, Stage__c = 'backlog'));
            }
        }

        update recordsForUpdate;
    }

    public void finish(Database.BatchableContext param1) {
        if (errMsg == '') {
            System.debug('Batch [AccountBatch] has finished : All Account updates are successful!');
        } else {
            System.debug('Batch [AccountBatch] has finished : There were errors. Here are a list of all errors. <br />' + errMsg);
        }
    }

    public Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(myQuery);
    }

}