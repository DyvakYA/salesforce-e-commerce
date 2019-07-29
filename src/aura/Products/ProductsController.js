({
    doInit: function (cmp, evt, helper) {
        const action = cmp.get("c.getProducts");
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const products = response.getReturnValue();
                cmp.set("v.record", products);
            }
            if (state === "INCOMPLETE") {
                //oborvalsya
            }
            if (state === "ERROR") {

            }
        });
         $A.enqueueAction(action);
    },

});