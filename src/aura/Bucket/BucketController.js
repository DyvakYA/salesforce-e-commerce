/**
 * Created by Dyvak Yurii on 06/16/2019.
 */

({

    openModel: function (component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
    },

    closeModel: function (component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"
        component.set("v.isOpen", false);
    },


    performOrder: function (cmp, event, helper) {
        const action = cmp.get("c.perform");
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                console.log('SUCCESS')
            }
            if (state === "INCOMPLETE") {
                //oborvalsya
            }
            if (state === "ERROR") {
                console.log('ERROR')
            }
        });
        $A.enqueueAction(action);
        $A.get("e.c:ProductRewriteEvent").fire()
        cmp.set("v.isOpen", false);
    },
});