/**
 * Created by Vladimir on 19.06.2019.
 */

({
    fetchOrderListHelper : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'Order Number', fieldName: 'OrderNumber', type: 'text'},
            {label: 'Order Start Date', fieldName: 'EffectiveDate', type: 'text'},
            {label: 'Status', fieldName: 'Status', type: 'text '}
        ]);
        var action = component.get("c.getAdminOrders");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})