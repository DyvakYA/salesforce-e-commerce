/**
 * Created by YuriiDyvak on 31.07.2019.
 */

({
    doInit: function (cmp, evt, helper) {
        const projectId = cmp.get('v.projectId');
        if (projectId != null) {
            const action = cmp.get("c.getSprintsForProject");
            action.setParam('projectId', projectId);
            action.setCallback(this, (response) => {
                const state = response.getState();
                if (state === "SUCCESS") {
                    const result = response.getReturnValue();
                    cmp.set("v.sprints", result);

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
    },

    getSprint: function (cmp, event, helper) {
        const sprint = event.getSource().get('v.value');
        const sprintEvent = cmp.getEvent("scrumGetSprintEvent");
        sprintEvent.setParam('sprint', sprint);
        sprintEvent.fire();

        cmp.getEvent("scrumSprintProgressRecalculationEvent").fire();
        //recalculationEvent.fire();

    }
});