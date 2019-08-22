/**
 * Created by YuriiDyvak on 08.08.2019.
 */

public class ScrumSprintRecord {

    @AuraEnabled
    public Double progress;

    @AuraEnabled
    public Double spendTime;

    @AuraEnabled
    public Double productivity;

    @AuraEnabled
    public Sprint__c sprint;

    @AuraEnabled
    public List<ScrumTaskRecord> tasks;

    public ScrumSprintRecord(Double progress, Sprint__c sprint, List<ScrumTaskRecord> tasks) {
        this.progress = progress;
        this.sprint = sprint;
        this.tasks = tasks;
    }

    public ScrumSprintRecord(Sprint__c sprint, List<ScrumTaskRecord> tasks) {
        this.progress = 0.00;
        this.spendTime = 0.00;
        this.productivity = 0.00;
        this.sprint = sprint;
        this.tasks = tasks;
    }

}