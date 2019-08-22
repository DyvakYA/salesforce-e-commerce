/**
 * Created by YuriiDyvak on 02.08.2019.
 */

({
    doInit: function(){

    },
    handleSuccess: function (cmp, event, helper) {

        console.log(cmp.getElements())
        const project = cmp.get('v.project');
        const param = event.getParams();
        const fields = param.response.fields;
        const name = fields.Name.value;
        console.log('Name ' + JSON.stringify(fields.Name));
        if (name != project.Name) {

            const component_target = event.currentTarget;
            console.log(component_target)
            const subtaskId = component_target.dataset.value;
            console.log(subtaskId)

            let projectDescriptionEvent = cmp.getEvent("scrumProjectDescriptionEditEvent");
            projectDescriptionEvent.setParam('name', name);
            projectDescriptionEvent.fire();

            helper.showInfoToast('Project changed');
            cmp.find("overlayLib").notifyClose();
        }
    }
});