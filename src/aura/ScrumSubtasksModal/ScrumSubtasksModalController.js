/**
 * Created by YuriiDyvak on 06.08.2019.
 */

({

    doInit: function (cmp, evt, helper) {
        const record = cmp.get('v.task');
        console.log(record)
        const action = cmp.get("c.getSubtasks");
        action.setParams({'taskId': record.Id});
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const subtasks = response.getReturnValue();
                console.log(subtasks)
                cmp.set('v.subtasks', subtasks);
            }
            if (state === "INCOMPLETE") {
                // NOP
            }
            if (state === "ERROR") {
                // NOP
            }
        });
        $A.enqueueAction(action);
    },
    subtaskEdit: function (cmp, evt, helper) {
        const subtask = evt.getSource().get('v.value');

        console.log(subtask)

        $A.createComponent("c:ScrumSubtaskEditModal",
            {
                subtaskId: subtask.Id
            },

            function (content, status) {
                if (status === "SUCCESS") {
                    cmp.find('overlayLib').showCustomModal({
                        body: content,
                        showCloseButton: true,
                        cssClass: 'mymodal',
                    })
                }
            });
    },
    handleScrumSubtaskEditEvent: function (cmp, evt, helper) {

    }
});