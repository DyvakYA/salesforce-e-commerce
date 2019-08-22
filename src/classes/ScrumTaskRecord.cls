/**
 * Created by YuriiDyvak on 08.08.2019.
 */

public class ScrumTaskRecord {

    @AuraEnabled
    public Double progress;

    @AuraEnabled
    public Task__c task;

    @AuraEnabled
    public List<Subtask__c> subtasks;

    public ScrumTaskRecord(Double progress, Task__c task) {
        this.progress = progress;
        this.task = task;
    }

    public ScrumTaskRecord(Task__c task) {
        this.progress = 0.00;
        this.task = task;
        this.subtasks = new List<Subtask__c>();
    }

    public ScrumTaskRecord(Task__c task, List<Subtask__c> subtasks) {
        this.progress = 0.00;
        this.task = task;
        this.subtasks = subtasks;
    }
}
