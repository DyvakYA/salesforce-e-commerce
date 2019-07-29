/**
 * Created by Vladimir on 18.06.2019.
 */

({
    fetchLaptops: function (cmp, event, helper) {
        const action = cmp.get("c.getLaptops");
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const products = response.getReturnValue();
                console.log(JSON.stringify(products))
                cmp.set("v.products", products);
            }
            if (state === "INCOMPLETE") {
                //oborvalsya
            }
            if (state === "ERROR") {

            }
        });
        $A.enqueueAction(action);
    },

    fetchOthers: function (cmp, event, helper) {
        const action = cmp.get("c.getOthers");
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const products = response.getReturnValue();
                console.log(JSON.stringify(products))
                cmp.set("v.products", products);
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