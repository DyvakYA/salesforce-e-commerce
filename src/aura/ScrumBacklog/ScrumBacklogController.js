/**
 * Created by YuriiDyvak on 26.07.2019.
 */

({
    doInit: function (cmp, evt, helper) {
        //const projectId = null;
        const action = cmp.get("c.getBackLogs");
        //action.setParam({"id": projectId});
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const result = response.getReturnValue();
                console.log(result)
                cmp.set("v.project", result);
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