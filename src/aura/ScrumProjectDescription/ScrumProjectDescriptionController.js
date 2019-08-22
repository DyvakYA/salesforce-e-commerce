/**
 * Created by YuriiDyvak on 31.07.2019.
 */

({
    doInit: function (cmp, event, helper) {
        helper.getProject(cmp, event, helper);
    },
    returnToSprints: function (cmp, event, helper) {
        cmp.getEvent('scrumDeleteSprintEvent').fire();
    },
    showProjectEditModal: function (cmp, evt, helper) {

        console.log(cmp)
        console.log(cmp.getElements())



        helper.showProjectEditModal(cmp, evt);
    },

    handleScrumProjectEditProjectEvent: function (component, event, helper) {
        console.log('event handled')
        const name = event.getParam('name');
        const project = component.get('v.project');
        project.Name = name;
        component.set('v.project', project);
    }
});