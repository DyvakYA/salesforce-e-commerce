/**
 * Created by YuriiDyvak on 08.08.2019.
 */

public class TaskRecord {

    @AuraEnabled
    public Double progress;

    @AuraEnabled
    public Task__c task;

    public TaskRecord(Double progress, Task__c task) {
        this.progress = progress;
        this.task = task;
    }
}
