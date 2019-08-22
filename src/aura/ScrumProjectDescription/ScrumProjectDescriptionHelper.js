/**
 * Created by YuriiDyvak on 08.08.2019.
 */

({
    showProjectEditModal: function (cmp, evt) {
        const project = cmp.get('v.project');
        $A.createComponent("c:ScrumProjectEditModal",
            {
                project: project
            },
            function (content, status) {
                if (status === "SUCCESS") {
                    cmp.find('overlayLib').showCustomModal({
                        header: 'Project Edit',
                        body: content,
                        showCloseButton: true,
                        cssClass: 'mymodal',
                    })
                }
            });
    },
    getProject: function (cmp, evt, helper) {
        const projectId = cmp.get('v.projectId');
        console.log('Get project ' + projectId);
        const action = cmp.get("c.getProject");
        action.setParam('projectId', projectId);
        action.setCallback(this, (response) => {
            const state = response.getState();
            if (state === "SUCCESS") {
                const result = response.getReturnValue();
                console.log(result)
                cmp.set("v.project", result);
            }
            if (state === "INCOMPLETE") {
                // NOP
            }
            if (state === "ERROR") {
                // NOP
            }
        });
        $A.enqueueAction(action);
    }
});