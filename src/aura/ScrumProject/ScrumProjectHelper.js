/**
 * Created by YuriiDyvak on 05.08.2019.
 */

({
    getSprint: function (cmp, evt, helper) {
        const sprintId = cmp.get('v.recordId')
        console.log('sprintId != null')
        const action = cmp.get("c.getSprintById");
        action.setParams({"sprintId": sprintId});
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const sprint = response.getReturnValue();
                console.log(sprint)
                cmp.set("v.sprint", sprint);
                helper.recalculateProgress(cmp, evt, helper);
            }
            if (state === "INCOMPLETE") {
                // NOP
            }
            if (state === "ERROR") {
                // NOP
            }
        });
        $A.enqueueAction(action);
    },
    getBacklogs: function (cmp, event, helper) {
        const projectId = null;
        const action = cmp.get("c.getBacklogs");
        action.setParam({"id": projectId});
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const result = response.getReturnValue();
                console.log(result)
                cmp.set("v.backlogs", result);
            }
            if (state === "INCOMPLETE") {
                // NOP
            }
            if (state === "ERROR") {
                // NOP
            }
        });
        $A.enqueueAction(action);
    },
    recalculateProgress: function (cmp, evt, helper) {
        console.log('recalculation');
        const sprint = cmp.get('v.sprint');
        const taskRecords = sprint.tasks;

        let amountSprintEstimateTime = sprint.sprint.Total_Estimate_of_Tasks__c;
        let amountSprintSpendTime = 0
        let sprintProgress = 0;
        taskRecords.forEach(function (element, index, arr) {
            amountSprintSpendTime += element.task.Total_Spend_Time__c;
            element.progress = (100 * element.task.Total_Spend_Time__c) / element.task.Total_Subtask_Estimate__c;
        });

        if (amountSprintEstimateTime != 0 && amountSprintSpendTime != 0) {
            sprintProgress = (100 * amountSprintSpendTime) / amountSprintEstimateTime;
        }

        const today = new Date();
        //console.log(today)
        const sprintStartDate = new Date(sprint.sprint.Start_Day__c)
        //console.log(sprintStartDate)
        const taskEstimated = Number(sprint.sprint.Total_Estimate_of_Tasks__c);
        //console.log(taskEstimated)
        const days = (today - sprintStartDate);
        //console.log(days)
        var differDays = Math.ceil(days / (1000 * 3600 * 24));
        //console.log(differDays)

        const spendTime = Math.ceil((differDays * 8) * 100 / Number(taskEstimated));
        //console.log(spendTime)
        const productivity = Math.ceil((Number(sprintProgress) * 100)/ Number(spendTime));
        //console.log(productivity)

        cmp.set('v.sprint.spendTime', spendTime);
        cmp.set('v.sprint.productivity', productivity);
        cmp.set('v.sprint.progress', sprintProgress);
    },
    moveBacklogToSprint: function (cmp, evt, helper) {
        const record = cmp.get('v.sprint');
        const task = evt.getParam('task');
        const action = cmp.get("c.moveTaskToSprint");
        action.setParams({'sprintId': record.sprint.Id, 'taskId': task.task.Id});
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const tasks = record.tasks;
                tasks.push(task);
                cmp.set('v.sprint', record);
                helper.recalculateProgress(cmp, evt);
            }
            if (state === "INCOMPLETE") {
                // NOP
            }
            if (state === "ERROR") {
                // NOP
            }
        });
        $A.enqueueAction(action);
    },
    deleteBacklog: function (cmp, evt, helper) {
        const backlogId = evt.getParam('backlogId');
        let backlogs = cmp.get('v.backlogs');
        const filtered = backlogs.filter(function (element, index, arr) {
            return element.task.Id !== backlogId;
        });
        cmp.set("v.backlogs", filtered);
    }
});
