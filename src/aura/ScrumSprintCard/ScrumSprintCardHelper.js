/**
 * Created by YuriiDyvak on 08.08.2019.
 */

({

    showSprintEditModal: function (cmp, evt, helper) {
        const sprint = cmp.get('v.sprint.sprint');

        $A.createComponent("c:ScrumSprintEditModal", {
                sprint: sprint,
                scrumSprintEditEvent: cmp.getReference("c.handleScrumSprintEvent")
            },
            function (content, status) {
                if (status === "SUCCESS") {
                    cmp.find('overlayLib').showCustomModal({
                        header: 'Sprint Edit',
                        body: content,
                        showCloseButton: true,
                        cssClass: 'mymodal',
                    })
                }
            });
    },
    showTaskEditModal: function (cmp, evt, helper) {
        const recordId = evt.getSource().get('v.value')

        $A.createComponent("c:ScrumTaskEditModal", {recordId: recordId},
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
    },
    deleteTaskFromSprint: function (cmp, evt, helper) {
        const recordId = evt.getSource().get('v.value')
        const action = cmp.get("c.removeTaskFromSprint");
        action.setParam('recordId', recordId)
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                helper.showInfoToast('Task deleted');
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
    scrumMoveTaskToBacklog: function (cmp, evt, helper) {
        const task = evt.getParam('task');
        const sprint = cmp.get('v.sprint');
        const tasks = sprint.tasks;

        const filtered = tasks.filter(function (element, index, arr) {
            return element.task.Id !== task.task.Id;
        });
        sprint.tasks = filtered;
        cmp.set('v.sprint', sprint);
        cmp.getEvent('scrumSprintProgressRecalculationEvent').fire();
    }
});