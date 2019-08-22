/**
 * Created by Vladimir on 19.06.2019.
 */

({
    massDeleteClick: function (cmp, event, helper) {
        alert("Delete all Orders!");

        const action = cmp.get("c.deleteAllOrders");
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title: 'Info Message',
                    message: 'Backlog deleted',
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

            }
        });
        $A.enqueueAction(action);

    }
});