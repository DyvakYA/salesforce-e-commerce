/**
 * Created by Dyvak Yurii on 06/15/2019.
 */

({
    openModel: function (component, event, helper) {
        // for Display Model,set the "isOpen" attribute to "true"
        component.set("v.isOpen", true);
    },

    closeModel: function (component, event, helper) {
        // for Hide/Close Model,set the "isOpen" attribute to "Fasle"
        console.log('close')
        component.set("v.isOpen", false);
    },

    createOrder: function (cmp, evt, helper) {

        console.log('Execute')

        const product = cmp.get("v.productFromParent")
        console.log(JSON.stringify(product))

        var action = cmp.get("c.getOrder");
        action.setParams({"product": JSON.stringify(product.sobj)});
        action.setCallback(this, function(response){
            const state = response.getState();
            if (state === "SUCCESS") {
                console.log('Add order: SUCCESS')
                const toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: 'Info Message',
                    message: 'Product Added',
                    messageTemplate: 'Record {0} created! See it {1}!',
                    duration: '5000',
                    key: 'info_alt',
                    type: 'info',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
            if (state === "INCOMPLETE") {
                //oborvalsya
            }
            if (state === "ERROR") {

                    console.log('Add order: Error')
                    const toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        title: 'Error',
                        message: 'Error',
                        messageTemplate: 'Record {0} created! See it {1}!',
                        duration: '5000',
                        key: 'info_alt',
                        type: 'error',
                        mode: 'dismissible'
                    });
                    toastEvent.fire();
            }

        });
        $A.enqueueAction(action);
    },
});