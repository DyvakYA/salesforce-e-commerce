/**
 * Created by YuriiDyvak on 22.08.2019.
 */

@RestResource(urlMapping='/accounts/*')
global class AccountsWebService {

    @HttpGet
    global static List<Account> getAccounts() {
        List<Account> accounts = (List<Account>) [SELECT Id, Name FROM Account];
        throwRuntime(ListConverter.toStrings(accounts));
        return accounts;
    }

    @future
    public static void throwRuntime(List<String> accounts) {

        List<Account> accounts1 = (List<Account>) ListConverter.toObjects(accounts, Account.class);


    }

}