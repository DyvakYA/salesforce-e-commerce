/**
 * Created by YuriiDyvak on 26.07.2019.
 */

public class ScrumSprintService {

    public void removeTaskFromSprint(String recordId) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Task__c.getSobjectType()) ;
        Task__c task = (Task__c) selector.queryBuilder()
                .querySelect()
                .queryFields('Id, Sprint__c')
                .queryFrom(Task__c.getSObjectType())
                .queryWhere('Id', recordId)
                .execute();

        task.Sprint__c = null;
        task.Type__c = 'backlog';
        selector.save((SObject) task);
    }

    public ScrumSprintRecord getSprintRecord(String sprintId) {
        Sprint__c sprint = getSprintById(sprintId);
        List<Task__c> tasks = new List<Task__c>();
        for (Task__c task : sprint.Tasks__r) {
            tasks.add(task);
        }
        List<Subtask__c> subtasks = getSubtasksForTasks(tasks);
        return getSprintRecord(sprint, subtasks);
    }

    public List<ScrumSprintRecord> getSprintRecordsForProject(String id) {
        List<ScrumSprintRecord> result = new List<ScrumSprintRecord>();

        List<Sprint__c> sprints = getTasksForSprintsForProject(id);
        System.debug(sprints);

        List<Task__c> tasks = new List<Task__c>();
        for (Sprint__c sprint : sprints) {
            for (Task__c task : sprint.Tasks__r) {
                tasks.add(task);
            }
        }

        List<Subtask__c> subtasks = getSubtasksForTasks(tasks);

        for (Sprint__c sprint : sprints) {
            result.add(getSprintRecord(sprint, subtasks));
        }
        return result;
    }

    public List<Subtask__c> getSubtasksForTasks(List<Task__c> tasks) {
        Set<Id> taskIds = new Set<Id>();
        for (Task__c task : tasks) {
            taskIds.add(task.Id);
        }

        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Subtask__c.getSobjectType()) ;
        return (List<Subtask__c>) selector
                .queryBuilder()
                .querySelect()
                .queryFields('Id, Name, Task__c, SpendTime__c, PlanTime__c')
                .queryFrom(Subtask__c.getSObjectType())
                .queryWhere('Task__c', taskIds)
                .execute();
    }

    public ScrumSprintRecord getSprintRecord(Sprint__c sprint, List<Subtask__c> subtasks) {
        List<ScrumTaskRecord> taskRecords = new List<ScrumTaskRecord>();
        for (Task__c task : sprint.Tasks__r) {
            List<Subtask__c> taskSubtasks = new List<Subtask__c>();
            for (Subtask__c subtask : subtasks) {
                if (task.Id == subtask.Task__c) {
                    taskSubtasks.add(subtask);
                }
            }
            taskRecords.add(new ScrumTaskRecord(task, taskSubtasks));
        }
        return new ScrumSprintRecord(sprint, taskRecords);
    }

    public List<Sprint__c> getSprintsForProject(String id) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Sprint__c.getSobjectType()) ;
        return (List<Sprint__c>) selector.queryBuilder()
                .querySelect()
                .queryFields('Id, Name, Date_finish__c, Project__c, Start_Day__c, Total_Estimate__c, Type__c')
                .queryFrom(Sprint__c.getSObjectType())
                .queryWhere('Project__c', id)
                .execute();
    }

    public List<Sprint__c> getTasksForSprints(Set<Id> ids) {

        String FIELDS = 'Id, ' +
                'Name, ' +
                'Date_finish__c, ' +
                'Project__c, ' +
                'Start_Day__c, ' +
                'Total_Estimate__c, ' +
                'Type__c, ' +
                '(SELECT Id,Name FROM Task__c';

        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Sprint__c.getSObjectType());

        return (List<Sprint__c>) selector.queryBuilder()
                .querySelect()
                .queryFields(FIELDS)
                .queryFrom(Task.getSobjectType())
                .queryWhere('Sprint__c', ids)
                .execute();

    }

    public List<Sprint__c> getTasksForSprintsForProject(String id) {

        String FIELDS = 'Id, ' +
                'Name, ' +
                'Date_finish__c, ' +
                'Project__c, ' +
                'Start_Day__c, ' +
                'Total_Estimate__c, ' +
                'Total_Track_Time__c, ' +
                'Total_Estimate_of_Tasks__c, ' +
                'Type__c, ' +
                '(SELECT Id, ' +
                'Name, ' +
                'Description__c, ' +
                'Total_Subtask_Estimate__c, ' +
                'Total_Spend_Time__c FROM Tasks__r WHERE Stage__c = \'sprint\')';

        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Sprint__c.getSObjectType());

        return (List<Sprint__c>) selector.queryBuilder()
                .querySelect()
                .queryFields(FIELDS)
                .queryFrom(Sprint__c.getSobjectType())
                .queryWhere('Project__c', id)
                .execute();

    }

    public Sprint__c getSprintById(String sprintId) {

        String FIELDS = 'Id, ' +
                'Name, ' +
                'Date_finish__c, ' +
                'Project__c, ' +
                'Start_Day__c, ' +
                'Total_Estimate__c, ' +
                'Total_Track_Time__c, ' +
                'Total_Estimate_of_Tasks__c, ' +
                'Type__c, ' +
                '(SELECT Id, Name, Description__c, Total_Subtask_Estimate__c, Total_Spend_Time__c FROM Tasks__r WHERE Stage__c = \'sprint\')';

        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Sprint__c.getSObjectType());

        return (Sprint__c) selector.queryBuilder()
                .querySelect()
                .queryFields(FIELDS)
                .queryFrom(Sprint__c.getSobjectType())
                .queryWhere('Id', sprintId)
                .queryLimit(1)
                .execute();
    }

    public void updateSpendTime(List<TrackTime__c> newTrackTimes) {
        List<Sprint__c> result = new List<Sprint__c>();

        Set<Id> sprintIds = new Set<Id>();
        for (SObject trackTime : newTrackTimes) {
            TrackTime__c track = (TrackTime__c) trackTime;
            sprintIds.add(track.Sprint__c);
        }

        List<Sprint__c> sprints = [SELECT Id FROM Sprint__c WHERE Id = :sprintIds];

        List<TrackTime__c> trackTimes = [SELECT Id, Subtask__c, Track__c FROM TrackTime__c WHERE Subtask__c = :sprintIds];

        for (Sprint__c sprint : sprints) {
            Decimal spendTime = 0;

            for (TrackTime__c trackTime : trackTimes) {
                if (trackTime.Sprint__c == sprint.Id) {
                    spendTime += trackTime.Track__c;
                }
            }

            sprint.Total_Track_Time__c = spendTime;
            result.add(sprint);
        }

        update result;

    }

    public void recalculateTotalEstimateOfTasks(List<Sprint__c> sprints) {
        List<Sprint__c> result = new List<Sprint__c>();

        Set<Id> sprintIds = new Set<Id>();
        for (SObject sprint : sprints) {
            sprintIds.add(sprint.Id);
        }

        List<Task__c> tasks = [SELECT Id, Total_Subtask_Estimate__c, Total_Spend_Time__c, Sprint__c FROM Task__c WHERE Sprint__c = :sprintIds];


        for (Sprint__c sprint : sprints) {
            Decimal planningTime = 0;
            Decimal trackedTime = 0;

            for (Task__c task : tasks) {
                if (task.Sprint__c == sprint.Id) {
                    planningTime += task.Total_Subtask_Estimate__c;
                    trackedTime += task.Total_Spend_Time__c;
                }
            }
            System.debug(planningTime + '  ' + trackedTime);

            //sprint.Total_Estimate_of_Tasks__c = planningTime;
            result.add(new Sprint__c(Id = sprint.Id, Total_Estimate_of_Tasks__c = planningTime, Total_Track_Time__c = trackedTime));
        }

        TriggerHandlerExecutor.bypassHandler(SprintHandler.UpdateSprintHandler.class);
        update result;
        TriggerHandlerExecutor.clearBypass(SprintHandler.UpdateSprintHandler.class);
    }

    public void isNotPossibleHaveTwoActiveSprints(List<Sprint__c> sprints) {

        List<Sprint__c> recordsForUpdating = new List<Sprint__c>();

        List<Sprint__c> inProgressSprint = new List<Sprint__c>();

        for (Sprint__c sprint : sprints) {
            if (sprint.Type__c == 'in progress') {
                inProgressSprint.add(sprint);
            }
        }
        if (!inProgressSprint.isEmpty()) {
            Datetime attachCreatedDate = null;
            Id attachId = null;
            for (Sprint__c sprint : inProgressSprint) {

                if (attachCreatedDate == null || sprint.CreatedDate > attachCreatedDate) {
                    attachCreatedDate = sprint.CreatedDate;
                    attachId = sprint.Id;
                }
            }
            recordsForUpdating.clear();
            recordsForUpdating.add(new Sprint__c(Id = attachId, Type__c = 'in progress'));

            clearInProgressSprints();
            System.debug(recordsForUpdating);

            // update records
            TriggerHandlerExecutor.bypassHandler(SprintHandler.UpdateSprintHandler.class);
            update recordsForUpdating;
            TriggerHandlerExecutor.clearBypass(SprintHandler.UpdateSprintHandler.class);
        }
    }

    @TestVisible
    private void clearInProgressSprints() {
        List<Sprint__c> items = [SELECT Id FROM Sprint__c WHERE Type__c = 'in progress'];
        for (Sprint__c item : items) {
            item.Type__c = 'new';
        }

        System.debug(items);

        TriggerHandlerExecutor.bypassHandler(SprintHandler.UpdateSprintHandler.class);
        update items;
        TriggerHandlerExecutor.clearBypass(SprintHandler.UpdateSprintHandler.class);
    }


}
