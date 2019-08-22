/**
 * Created by YuriiDyvak on 06.08.2019.
 */

({
    deleteBackLog: function (cmp, evt, helper) {
        const backlog = cmp.get('v.backlog');
        const recordId = backlog.task.Id;
        const action = cmp.get("c.deleteBacklog");
        action.setParam('backlogId', recordId)
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                helper.showInfoToast('Deleted');
                helper.deleteBacklogEvent(cmp, evt, helper);
                helper.sprintProgressRecalculationEvent(cmp, evt, helper);
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
    scrumBacklogMoveToSprintEvent: function (cmp, evt, helper) {
        const backlog = cmp.get('v.backlog');
        // Scrum backlog move to sprint event
        let scrumBacklogMoveToSprintEvent = cmp.getEvent('scrumBacklogMoveToSprintEvent');
        scrumBacklogMoveToSprintEvent.setParam('task', backlog);
        scrumBacklogMoveToSprintEvent.fire();
    },
    deleteBacklogEvent: function (cmp, evt, helper) {

        const backlog = cmp.get('v.backlog');
        // Delete backlog event
        const taskId = backlog.task.Id;
        console.log('delete backlog eent' + taskId)
        const deleteBacklogEvent = cmp.getEvent('deleteBacklogEvent');
        deleteBacklogEvent.setParam('backlogId', taskId);
        deleteBacklogEvent.fire();
    },
    sprintProgressRecalculationEvent: function (cmp, evt, helper) {
        // Sprint and tasks progress recalculation
        cmp.getEvent('scrumSprintProgressRecalculationEvent').fire();
    },

    showTaskEditModal: function (cmp, evt, helper) {
        const backlog = cmp.get('v.backlog');
        $A.createComponent("c:ScrumTaskEditModal",
            {
                task: backlog.task,
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
    },
    showSubtasks: function (cmp, evt, helper) {
        const backlog = cmp.get('v.backlog');
        const subtasks = backlog.subtasks;
        if (subtasks.length > 0) {

            $A.createComponent("c:ScrumSubtasksModal",
                {
                    task: backlog.task,
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

})
;