/**
 * Created by YuriiDyvak on 07.08.2019.
 */

@isTest
public with sharing class ScrumSprintServiceTest {

    @TestSetup
    public static void setUp() {

        Project__c project = new Project__c(Name = 'new project');
        insert project;

        Sprint__c sprint = new Sprint__c(Name = 'newSprint', Project__c = project.Id);
        insert sprint;

        List<Task__c> tasks = new List<Task__c>();
        for (Integer i = 0; i < 10; i++) {
            tasks.add(new Task__c(Name = 'newTask ' + 1, Sprint__c = sprint.Id, Project__c = project.Id, Planning_time__c = 5, Type__c = 'new', Stage__c = 'sprint'));
        }
        insert tasks;

        List<Subtask__c> subtasks = new List<Subtask__c>();
        Task__c task = [Select Id From Task__c Limit 1];
        for (Integer i = 0; i < 10; i++) {
            subtasks.add(new Subtask__c(Name = 'new subtask', Project__c = project.Id, Type__c = 'new', Task__c = task.Id, SpendTime__c = 5));
        }
        insert subtasks;

    }


    @isTest
    public static void getSprints() {

        Project__c project = [SELECT Id FROM Project__c WHERE Name = 'new project'];
        System.debug(project);

        ScrumSprintService service = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
        List<ScrumSprintRecord> result = service.getSprintRecordsForProject(project.Id);
        System.debug(result);
    }

}