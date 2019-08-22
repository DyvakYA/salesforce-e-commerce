/**
 * Created by YuriiDyvak on 30.07.2019.
 */

({
    handleSuccess: function (cmp, event, helper) {

        const changed = cmp.get('v.changedFields');
        console.log(JSON.stringify(changed))
        const sprint = cmp.get('v.sprint');
        console.log(JSON.stringify(sprint))

        if (changed != null) {
            const fields = event.getParam("response").fields;
            console.log(JSON.stringify(fields))
            changed.forEach(function (element) {
                const newField = fields[element];
                console.log(JSON.stringify(newField))
                sprint[element] = newField.value;
            });

            const projectDescriptionEvent = cmp.getEvent("scrumSprintEditEvent");
            projectDescriptionEvent.setParam('sprint', sprint);
            projectDescriptionEvent.fire();

            const toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                title: 'Info Message',
                message: 'Sprint changed',
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
        console.log(fieldName)
        const changed = cmp.get('v.changedFields');
        console.log(changed)
        changed.push(fieldName);
        cmp.set('v.changedFields', changed);
    }
})