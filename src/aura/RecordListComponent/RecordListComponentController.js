/**
 * Created by YuriiDyvak on 19.07.2019.
 */

({

    doInit: function (cmp, evt, helper) {
        console.log('asahfiahsfisaidgjf')

        const fieldSetName = cmp.get("v.fieldSetName")
        const sObjectId = cmp.get("v.recordId")
        const type = cmp.get("v.sObjectName")

        if (sObjectId && type) {
            const action = cmp.get("c.getFieldRecords");
            action.setParams({"type": type, "sObjectId": sObjectId, "fieldSetName" : fieldSetName});
            action.setCallback(this, (response) => {
                const state = response.getState();
                if (state === "SUCCESS") {
                    const result = response.getReturnValue();
                    cmp.set("v.records", result);
                }
                if (state === "INCOMPLETE") {
                }
                if (state === "ERROR") {
                }

            });
            $A.enqueueAction(action);
        }
    },
});