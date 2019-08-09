/**
 * Created by YuriiDyvak on 30.07.2019.
 */

({
    handleSuccess: function (component, event, helper) {
        const recordId = cmp.get('v.recordId');
        console.log(sprint)
        var contactRec = event.getParams().response;
        var navEvt = $A.get('e.force:navigateToSObject');
        navEvt.setParams({
            'recordId': recordId,
            'slideDevName': 'related'
        });
        navEvt.fire();
    }
})