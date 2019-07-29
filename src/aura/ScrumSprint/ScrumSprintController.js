/**
 * Created by YuriiDyvak on 26.07.2019.
 */

({
    doInit: function (cmp, evt, helper) {

        const projectId = cmp.get("v.projectId");

        const action = cmp.get("c.getSprintsForProject");
        action.setParam({"id": projectId});
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const result = response.getReturnValue();
                console.log(result)
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

});