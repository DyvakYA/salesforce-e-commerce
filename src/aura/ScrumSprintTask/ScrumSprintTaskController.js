/**
 * Created by YuriiDyvak on 06.08.2019.
 */

({
    doInit: function (cmp, evt, helper) {
        const task = cmp.get('v.task');
        let taskProgress = '';
        if (task.task.Total_Spend_Time__c != 0 && task.task.Total_Subtask_Estimate__c != 0) {
            taskProgress = (100 * task.task.Total_Spend_Time__c) / task.task.Total_Subtask_Estimate__c;
        }
        task.progress = taskProgress;
        cmp.set('v.task', task);

        let subtaskRecords = [];
        const subtasks = cmp.get('v.task.subtasks');

        subtasks.forEach(function (element, index, arr) {
            let progre = 0;
            if (element.SpendTime__c != 0 && element.PlanTime__c != 0) {
                progre = (100 * element.SpendTime__c) / element.PlanTime__c;
            }
            let subtask = {
                progress: '',
                subtask: ''
            }
            subtask.progress = progre.toString();
            subtask.subtask = element;
            subtaskRecords.push(subtask);
        });

        cmp.set('v.subtasks', subtaskRecords);
    }
    ,
    showSubtasks: function (cmp, evt, helper) {
        cmp.set("v.showSubtasks", true);
    }
    ,
    hideSubtasks: function (cmp, evt, helper) {
        cmp.set("v.showSubtasks", false);
    }
    ,
    showTaskEditModal: function (cmp, evt, helper) {
        const task = cmp.get('v.task');
        $A.createComponent("c:ScrumTaskEditModal",
            {
                task: task.task,
                scrumTaskEditEvent: cmp.getReference("c.handleScrumTaskEvent")
            },
            function (content, status) {
                if (status === "SUCCESS") {
                    cmp.find('overlayLib').showCustomModal({
                        header: 'Task Edit',
                        body: content,
                        showCloseButton: true,
                        cssClass: 'mymodal',
                    })
                }
            });
    }
    ,
    handleScrumTaskEvent: function (cmp, evt, helper) {
        const task = evt.getParam('task');
        cmp.set("v.task.task", task);
    }
    ,
    moveToBacklog: function (cmp, evt, helper) {

        const task = cmp.get('v.task')
        const action = cmp.get("c.moveTaskToBacklog");
        action.setParams({'taskId': task.task.Id});
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const event = cmp.getEvent('scrumMoveTaskToBacklogEvent');
                event.setParam('task', task)
                event.fire();
                // todo doesn't work properly
                //cmp.destroy();
            }
            if (state === "INCOMPLETE") {
                // NOP
            }
            if (state === "ERROR") {
                // NOP
            }
        });
        $A.enqueueAction(action);

    }
    ,
    showSubtasksModal: function (cmp, evt, helper) {
        const task = cmp.get('v.task');
        const subtasks = task.subtasks;
        if (subtasks.length > 0) {
            $A.createComponent("c:ScrumSubtasksModal",
                {
                    task: task.task,
                    scrumDeleteTrackTimeEvent: cmp.getReference("c.handleScrumTaskEvent")
                },
                function (content, status) {
                    if (status === "SUCCESS") {
                        cmp.find('overlayLib').showCustomModal({
                            header: 'Subtasks',
                            body: content,
                            showCloseButton: true,
                            cssClass: 'mymodal',
                        })
                    }
                });
        } else {
            helper.showInfoToast('No subtasks');
        }
    },
    trackTime: function (cmp, evt, helper) {

        const subtaskId = evt.getSource().get('v.value');
        const tracker = cmp.get('v.tracker');
        let subtasks = cmp.get('v.subtasks');
        let subtask = '';
        subtasks.forEach(function (element) {
            if (element.subtask.Id == tracker.subtaskId) {
                subtask = element;
            }
        });

        const planTime = Number(subtask.subtask.PlanTime__c);
        const newSpendTime = Number(subtask.subtask.SpendTime__c) + Number(tracker.count);
        console.log(planTime);
        console.log(newSpendTime);
        if (planTime >= newSpendTime) {

            if (tracker.subtaskId == subtaskId) {
                cmp.set('v.showSpinner', true);

                const action = cmp.get("c.trackTimeForSubtask");
                action.setParams({
                    'subtaskId': tracker.subtaskId,
                    'sprintId': tracker.sprintId,
                    'taskId': tracker.taskId,
                    'trackTime': tracker.count
                });

                helper.executeAction(cmp, action).then(function () {
                    helper.updateListOfSubtask(cmp, evt);
                    helper.trackTime(cmp, evt);
                    helper.recalculateProgressForTask(cmp, evt);
                    helper.showInfoToast('Tracked');
                    cmp.set('v.showSpinner', false);
                })
            }
        } else {
            helper.showWarningToast('Too mach time');
        }

    },
    tracker: function (cmp, evt, helper) {
        new Promise(function (resolve, reject) {
            const count = evt.getSource().get('v.value');
            const sprintId = cmp.get('v.sprintId');
            const task = cmp.get('v.task');
            const subtaskId = evt.getSource().get('v.id');

            let tracker = {
                count: '',
                sprintId: '',
                taskId: '',
                subtaskId: ''
            }

            tracker.count = count;
            tracker.sprintId = sprintId;
            tracker.taskId = task.task.Id;
            tracker.subtaskId = subtaskId;
// todo make tracker in any situation not only onchange count of tracktime
            cmp.set('v.tracker', tracker);
            resolve("Good one");
        })
    },
    showSubtaskDetailModal: function (cmp, evt, helper) {

        const component_target = evt.currentTarget;
        const subtaskId = component_target.dataset.value;

        $A.createComponent("c:ScrumSubtaskEditModal", {
                subtaskId: subtaskId,
                scrumDeleteTrackTimeEvent: cmp.getReference("c.handleScrumDeleteTrackTimeEvent")
            },
            function (content, status) {
                if (status === "SUCCESS") {
                    cmp.find('overlayLib').showCustomModal({
                        header: 'Subtask',
                        body: content,
                        showCloseButton: true,
                        cssClass: 'mymodal',
                    })
                }
            });
    },
    handleScrumSubtaskEditEvent: function (cmp, evt, helper) {
        cmp.find("overlayLib").notifyClose();
    },
    handleScrumDeleteTrackTimeEvent: function (cmp, evt, helper) {
        const track = evt.getParam('track');
        console.log(track);
        const ev = cmp.getEvent('scrumDeleteTrackTimeEvent');
        ev.setParam('track', track);
        ev.fire();


    }
});