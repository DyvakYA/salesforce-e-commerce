/**
 * Created by YuriiDyvak on 19.08.2019.
 */

({
    doInit: function (cmp, evt, helper) {
        const subtaskId = cmp.get('v.subtaskId');
        console.log(subtaskId)
        const action1 = cmp.get("c.getSubtask");
        action1.setParams({"subtaskId": JSON.stringify(subtaskId)});
        action1.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                cmp.set('v.subtask', response.getReturnValue());
            }
            if (state === "INCOMPLETE") {
                // NOP
            }
            if (state === "ERROR") {
                // NOP
            }
        });
        $A.enqueueAction(action1);


        const action2 = cmp.get("c.getTrackTimes");
        action2.setParams({"subtaskId": subtaskId});
        action2.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());

                const trackTimes = response.getReturnValue();
                trackTimes.forEach(function (element, index, arr) {
                    let dateString = element.CreatedDate;
                    element.CreatedDate = $A.localizationService.formatDate(dateString, "yyyy-MM-dd");
                })


                cmp.set('v.trackTimes', trackTimes);
            }
            if (state === "INCOMPLETE") {
                // NOP
            }
            if (state === "ERROR") {
                // NOP
            }
        });
        $A.enqueueAction(action2);
    },
    handleSuccess: function (cmp, evt, helper) {
        helper.showInfoToast('Subtask changed')
        cmp.find("overlayLib").notifyClose();
    },
    removeItem: function (cmp, evt, helper) {
        const trackId = evt.getSource().get('v.name');
        const action = cmp.get("c.removeTrackTime");
        action.setParams({"trackId": trackId});
        helper.executeAction(cmp, action).then(function () {
            const trackTimes = cmp.get('v.trackTimes');
            let filtered = trackTimes.filter(function (element) {
                return element.Id == trackId;
            });
            const event = cmp.getEvent('scrumDeleteTrackTimeEvent');
            console.log(trackId);
            console.log(filtered)
            event.setParam('track', filtered[0]);
            event.fire();
        }).then(function () {
            const trackTimes = cmp.get('v.trackTimes');
            let filtered = trackTimes.filter(function (element) {
                return element.Id != trackId;
            });
            cmp.set('v.trackTimes', filtered);
        }).then(function () {
            helper.showInfoToast('Track deleted')
        });

    }
});