/**
 * Created by Vladimir on 19.06.2019.
 */

({
    massDeleteClick : function (cmp, event, helper) {
        alert("Delete all Orders!");

        	const action = cmp.get("c.deleteAllOrders");
        	action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {

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