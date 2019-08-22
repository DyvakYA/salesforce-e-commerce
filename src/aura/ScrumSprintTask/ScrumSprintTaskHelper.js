/**
 * Created by YuriiDyvak on 16.08.2019.
 */

({
    updateListOfSubtask : function (cmp, evt) {
        let subtasks = cmp.get('v.subtasks');
        const tracker = cmp.get('v.tracker');
        subtasks.forEach(function (element) {
            if (element.subtask.Id == tracker.subtaskId) {
                element.subtask.SpendTime__c = Number(element.subtask.SpendTime__c) + Number(tracker.count);
                element.progress = (100 * element.subtask.SpendTime__c) / element.subtask.PlanTime__c;
            }
        });
        cmp.set('v.subtasks', subtasks);
    },
    trackTime : function (cmp, evt) {
        const tracker = cmp.get('v.tracker');
        // event started
        const trackEvent = cmp.getEvent('scrumSubtaskTrackTimeEvent');
        trackEvent.setParam('trackedTime', tracker.count);
        trackEvent.fire();
    },
    recalculateProgressForTask : function (cmp, evt) {
        const tracker = cmp.get('v.tracker');
        // recalculate progress for task
        const task = cmp.get('v.task');
        task.task.Total_Spend_Time__c = Number(task.task.Total_Spend_Time__c) + Number(tracker.count);
        task.progress = (100 * task.task.Total_Spend_Time__c) / task.task.Total_Subtask_Estimate__c;
        cmp.set('v.task', task);
    }
})
