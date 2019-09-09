/**
 * Created by YuriiDyvak on 23.08.2019.
 */

({
    handleGetAccountsEvent: function (cmp, evt, helper) {
        console.log('hello world')
        const accounts = evt.getParam('accounts');
        console.log(JSON.stringify(accounts));
        cmp.set('v.accounts', accounts);
    }
});