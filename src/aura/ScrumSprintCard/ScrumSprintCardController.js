/**
 * Created by YuriiDyvak on 29.07.2019.
 */

({
    // doInit: function (cmp, evt, helper) {
    //     const sprintRecord = cmp.get('v.sprint');
    //     console.log(JSON.stringify(sprintRecord))
    //
    //     const today = new Date();
    //     const sprintStartDate = new Date(sprintRecord.sprint.Start_Day__c)
    //     const taskEstimated = Number(sprintRecord.sprint.Total_Estimate_of_Tasks__c);
    //     const days = (today - sprintStartDate);
    //     var differDays = Math.ceil(days / (1000 * 3600 * 24));
    //
    //     const spendTime = Math.ceil((differDays * 8) * 100 / Number(taskEstimated));
    //
    //     console.log(sprintRecord.progress)
    //     console.log(spendTime)
    //     const productivity = Number(sprintRecord.progress) / Number(spendTime);
    //
    //
    //     cmp.set('v.spendTime', spendTime);
    //     cmp.set('v.productivity', productivity);
    // },
    showTasks: function (cmp, evt, helper) {
        cmp.set("v.showTasks", true);
    },
    hideTasks: function (cmp, evt, helper) {
        cmp.set("v.showTasks", false);
    },

    showSprintEditModal: function (cmp, evt, helper) {
        helper.showSprintEditModal(cmp, evt, helper);

    },
    hideSprintEditModal: function (cmp, evt, helper) {
        cmp.set("v.isOpenModalSprintEdit", false);
    },

    showTaskEditModal: function (cmp, evt, helper) {
        helper.showTaskEditModal(cmp, evt, helper);
    },

    hideTaskEditModal: function (cmp, evt, helper) {
        cmp.set("v.isOpenModalSprintEdit", false);
    },
    deleteTaskFromSprint: function (cmp, evt, helper) {
        helper.deleteTaskFromSprint(cmp, evt, helper);
    },
    handleScrumSprintEvent: function (cmp, evt, helper) {
        const sprint = evt.getParam('sprint');
        cmp.set("v.sprint.sprint", sprint);
    },
    handleScrumMoveTaskToBacklogEvent: function (cmp, evt, helper) {
        helper.scrumMoveTaskToBacklog(cmp, evt, helper);
    },
    trackTime: function (cmp, evt, helper) {
        const trackTime = evt.getParam('trackedTime');

        const sprint = cmp.get('v.sprint');
        sprint.sprint.Total_Track_Time__c = Number(sprint.sprint.Total_Track_Time__c) + Number(trackTime);
        if (sprint.sprint.Total_Estimate_of_Tasks__c != 0 && sprint.sprint.Total_Track_Time__c != 0) {
            sprint.progress = (100 * sprint.sprint.Total_Track_Time__c) / sprint.sprint.Total_Estimate_of_Tasks__c;
        }
        const productivity = Math.ceil((Number(sprint.progress) * 100)/ Number(sprint.spendTime));
        sprint.productivity = productivity;
        cmp.set('v.sprint', sprint);
        //cmp.getEvent('scrumSprintProgressRecalculationEvent').fire();
    }
});