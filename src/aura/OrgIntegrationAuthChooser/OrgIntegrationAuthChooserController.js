/**
 * Created by YuriiDyvak on 23.08.2019.
 */

({
    doInit: function (cmp, evt, helper) {
        const options = [
            {'label': 'Username-password flow', 'value': 'Username-password flow'},
            {'label': 'Named Credential', 'value': 'Named Credential'},
            {'label': 'User-agent flow', 'value': 'User-agent flow'},
            {'label': 'Web server flow (doesn\'t work)', 'value': 'Web server flow'}
        ];

        cmp.set('v.options', options);
    },
    getAccountsFromOrg: function (cmp, evt, helper) {
        alert(cmp.get('v.value'));
        const authType = cmp.get('v.value');
        const action = cmp.get('c.getExternalAccounts');
        action.setParams({'authType': authType})

        helper.executeAction(cmp, action).then(function (data) {
            const sprintEvent = cmp.getEvent("getAccountsEvent");
            sprintEvent.setParam('accounts', data);
            sprintEvent.fire();
        });
    }
});