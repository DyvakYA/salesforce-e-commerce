/**
 * Created by YuriiDyvak on 26.07.2019.
 */

public class ScrumBacklogService {

    public List<ScrumTaskRecord> getBacklogs() {

        List<ScrumTaskRecord> result = new List<ScrumTaskRecord>();

        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Task__c.getSObjectType());
        List<Task__c> backlogs = (List<Task__c>) selector.queryBuilder()
                .querySelect()
                .queryFields('Id, Name, Assignee__c, Description__c, Total_Subtask_Estimate__c, Total_Spend_Time__c, Sprint__c')
                .queryFrom(Task__c.getSObjectType())
                .queryWhere('Stage__c', 'backlog')
                .execute();

        System.debug('Backlogs ' + backlogs);


        List<Subtask__c> subtasks = getSubtasksForTasks(backlogs);

        System.debug(subtasks);

        for (Task__c backlog : backlogs) {
            if (!subtasks.isEmpty()) {
                for (Subtask__c subtask : subtasks) {
                    if (subtask.Task__c == backlog.Id) {
                        result.add(new ScrumTaskRecord(backlog, subtasks));
                    } else {
                        result.add(new ScrumTaskRecord(backlog));
                    }
                }
            } else {
                result.add(new ScrumTaskRecord(backlog));
            }
        }

        System.debug(result);
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

    public void deleteById(String backlogId) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Task__c.getSObjectType());
        selector.deleteById(backlogId);
    }

    public void moveTaskToSprint(String sprintId, String taskId) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Task__c.getSObjectType());
        Task__c task = (Task__c) selector.findById(taskId);
        task.Sprint__c = sprintId;
        task.Stage__c = 'sprint';
        selector.save(task);
    }

    public void moveTaskToBacklog(String taskId) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Task__c.getSObjectType());
        Task__c task = (Task__c) selector.findById(taskId);
        task.Stage__c = 'backlog';
        selector.save(task);
    }
}