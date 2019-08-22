/**
 * Created by YuriiDyvak on 05.08.2019.
 */

({
    handleSuccess: function (cmp, event, helper) {
        const changed = cmp.get('v.changedFields');
        const task = cmp.get('v.task');
        if (changed != null) {
            const fields = event.getParam("response").fields;
            changed.forEach(function (element) {
                const newField = fields[element];
                task[element] = newField.value;
            });

            const projectDescriptionEvent = cmp.getEvent("scrumTaskEditEvent");
            projectDescriptionEvent.setParam('task', task);
            projectDescriptionEvent.fire();

            const toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title: 'Info Message',
                message: 'Task changed',
                messageTemplate: 'Record {0} created! See it {1}!',
                duration: '5000',
                key: 'info_alt',
                type: 'info',
                mode: 'dismissible'
            });
            toastEvent.fire();
            cmp.find("overlayLib").notifyClose();
        }
    },
    changed: function (cmp, evt, helper) {
        const fieldName = evt.getSource().get('v.fieldName');
        const changed = cmp.get('v.changedFields');
        changed.push(fieldName);
        cmp.set('v.changedFields', changed);
    }
});