/**
 * Created by Dyvak Yurii on 06/16/2019.
 */

({
    fetchProducts: function (component, event, helper) {

        component.set('v.columns', [
            {label: 'Product Name', fieldName: 'product', type: 'text'},
            {label: 'Quantity', fieldName: 'quantity', type: 'number', editable: true}
        ]);
        const action = component.get("c.getProducts");
        action.setCallback(this, function (response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                const products = response.getReturnValue()
                console.log('SUCCESS')
                console.log(JSON.stringify(products))
                component.set("v.products", products);
            }
        });
        $A.enqueueAction(action);
    },

    saveRecords: function (cmp, event, helper) {

        const products = event.getParam('draftValues')
        console.log(JSON.stringify(products))

        const action = cmp.get("c.updateQuantities");
        action.setParams({"products": JSON.stringify(products)});
        action.setCallback(this, function (response) {
            const state = response.getState();
            if (state === "SUCCESS") {
                console.log('Add order: SUCCESS')

                const products = response.getReturnValue();
                cmp.set("v.products", products);
                const toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: 'Info Message',
                    message: 'Quantity changed',
                    messageTemplate: 'Record {0} created! See it {1}!',
                    duration: '5000',
                    key: 'info_alt',
                    type: 'info',
                    mode: 'dismissible'
                });
                toastEvent.fire();
            }
            if (state === "INCOMPLETE") {
                console.log('Not finished')
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