/**
 * Created by YuriiDyvak on 26.07.2019.
 */

({
    doInit: function (cmp, evt, helper) {
        const sprintId = cmp.get('v.recordId')
        if (sprintId != null) {
            helper.getSprint(cmp, evt, helper);
        }
        helper.getBacklogs(cmp, evt, helper);
    },

    hideProjectEditModal: function (cmp, evt, helper) {
        cmp.set("v.isOpenModalSprintEdit", false);
    },
    handleGetSprintEvent: function (cmp, event) {
        const sprint = event.getParam('sprint');
        cmp.set('v.sprint', sprint);
    },
    handleDelComponentEvent: function (cmp, event) {
        cmp.set('v.sprint', null);
    },
    handleMoveBacklogToSprint: function (cmp, evt, helper) {
        helper.moveBacklogToSprint(cmp, evt, helper);
    },
    handleMoveTaskToBacklog: function (cmp, event, helper) {
        const task = event.getParam('task');
        const backlogs = cmp.get('v.backlogs');
        backlogs.push(task);
        cmp.set('v.backlogs', backlogs);
    },
    handleDeleteBacklogEvent: function (cmp, evt, helper) {
        helper.deleteBacklog(cmp, evt, helper);
    },
    recalculationProgress: function (cmp, evt, helper) {
        helper.recalculateProgress(cmp, evt, helper);
    },
    handleDeleteTrackEvent: function (cmp, evt, helper) {
        const track = evt.getParam('track');
        console.log(JSON.stringify(track));

        const sprint = cmp.get('v.sprint');
        console.log(sprint)

        const tasks = sprint.tasks;
        const filteredTask = tasks.filter(function (element) {
            return element.task.Id == track.Task__c;
        })

        const task = filteredTask[0];
        console.log(JSON.stringify(task));
        const subtasks = task.subtasks;
        console.log(JSON.stringify(subtasks))
        const filteredSubtasks = subtasks.filter(function (element) {
            return element.Id == track.Subtask__c;
        })

        const subtask = filteredSubtasks[0];
        const newValue = subtask.SpendTime__c - track.Track__c;
        subtask.SpendTime__c = newValue;
        console.log(sprint);

        cmp.set('v.sprint', sprint);


        helper.recalculateProgress(cmp, evt, helper);
    }
});