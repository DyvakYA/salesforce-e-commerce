/**
 * Created by Dyvak Yurii on 06/15/2019.
 */

({
    likenClose: function(component, event, helper) {
        // Display alert message on the click on the "Like and Close" button from Model Footer
        // and set set the "isOpen" attribute to "False for close the model Box.
        alert('thanks for like Us :)');
        component.set("v.isOpen", false);
    },

    closeModel: function(component, event, helper) {
        console.log('hello world')
       // component.getEvent("closeWindowEvent").fire();
        console.log(component.getEvent("closeWindowEvent"))
        $A.get("e.c:CloseProductDetailWindowEvent").fire()
    },

    createOrder: function (cmp, evt, helper) {


        const product = cmp.get("v.product")
        console.log(JSON.stringify(product))

        const action = cmp.get("c.getOrder");
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
})