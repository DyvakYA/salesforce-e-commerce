/**
 * Created by YuriiDyvak on 29.07.2019.
 */

({
    showDetails: function (cmp, evt, helper) {
        cmp.set("v.showDetails", true);
    },
    hideDetails: function (cmp, evt, helper) {
        cmp.set("v.showDetails", false);
    },
    showTaskEditModal: function (cmp, evt, helper) {
        helper.showTaskEditModal(cmp, evt, helper);
    },
    hideTaskEditModal: function (cmp, evt, helper) {
        cmp.set("v.isOpenModalSprintEdit", false);
    },
    deleteBackLog: function (cmp, evt, helper) {
        helper.deleteBackLog(cmp, evt);
    },
    handleScrumTaskEvent: function (cmp, evt, helper) {
        const task = evt.getParam('task');
        cmp.set("v.backlog.task", task);
    },
    moveToSprint: function (cmp, evt, helper) {
        const sprintId = cmp.get('v.sprintId');
        console.log('Move to sprint: sprintID = ' + sprintId);
        if (sprintId !== null) {
            helper.scrumBacklogMoveToSprintEvent(cmp, evt, helper);
            helper.deleteBacklogEvent(cmp, evt, helper);
            helper.sprintProgressRecalculationEvent(cmp, evt, helper);
        } else if (sprintId === null) {
            helper.showInfoToast('Choose sprint for beginning');
        }
    },
    showSubtasks: function (cmp, evt, helper) {
        helper.showSubtasks(cmp, evt, helper);
    }

});