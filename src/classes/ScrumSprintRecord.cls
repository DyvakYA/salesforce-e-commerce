/**
 * Created by YuriiDyvak on 08.08.2019.
 */

public class SprintRecord {

    @AuraEnabled
    public Double progress;

    @AuraEnabled
    public Sprint__c sprint;

    @AuraEnabled
    public List<TaskRecord> tasks;

    public SprintRecord(Double progress, Sprint__c sprint, List<TaskRecord> tasks) {
        this.progress = progress;
        this.sprint = sprint;
        this.tasks = tasks;
    }
}