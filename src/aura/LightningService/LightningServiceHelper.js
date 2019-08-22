/**
 * Created by YuriiDyvak on 12.08.2019.
 */

({
    showInfoToast: function (message) {
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: 'Info Message',
            message: message,
            messageTemplate: 'Record {0} created! See it {1}!',
            duration: '5000',
            key: 'info_alt',
            type: 'info',
            mode: 'dismissible'
        });
        toastEvent.fire();
    },
    showWarningToast: function (message) {
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: 'Warning',
            message: message,
            messageTemplate: 'Record {0} created! See it {1}!',
            duration: '5000',
            key: 'info_alt',
            type: 'warning',
            mode: 'dismissible'
        });
        toastEvent.fire();
    },
    showErrorToast: function (message) {
        const toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            title: 'Error',
            message: message,
            messageTemplate: 'Record {0} created! See it {1}!',
            duration: '5000',
            key: 'info_alt',
            type: 'error',
            mode: 'dismissible'
        });
        toastEvent.fire();
    },
    executeAction: function (cmp, action) {
        return new Promise(function (resolve, reject) {
            action.setCallback(this, function (response) {
                if (response.getState() === 'SUCCESS') {
                    resolve(response.getReturnValue());
                } else if (response.getState() === 'ERROR') {
                    reject(response.getError());
                }
            });
            $A.enqueueAction(action);
        });
    },

});