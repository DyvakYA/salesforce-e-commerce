/**
 * Created by YuriiDyvak on 22.08.2019.
 */

@RestResource(urlMapping='/accounts/*')
global class AccountsWebService {

    @HttpGet
    global static List<Account> getAccounts() {
        List<Account> accounts = (List<Account>) [SELECT Id, Name FROM Account];

        for (Integer i = 0; i <= 200; i++) {
            Account account = accounts.get(0);
            accounts.add(new Account(Id = account.Id, Name = account.Name + i));
        }
        System.debug('Size of list for update ' + accounts.size());

        List<Account> accountsForUpdate = new List<Account>();

        updateList(accounts);


        System.debug('Size for update in one batch ' + accountsForUpdate.size());
//        ObjectUpdateProvider provider = new ObjectUpdateProvider(acc);
//        throwRuntime(Converter.toString(provider));

        return accounts;
    }

    private static  void updateList(List<Account> accounts) {
        Integer DEFAULT_PAGE_SIZE = 20;
        Integer index = 0;

        while (index * DEFAULT_PAGE_SIZE + DEFAULT_PAGE_SIZE - 1 <= accounts.size()) {

            System.debug('INDEX =' + index);

            Integer startPa = index * DEFAULT_PAGE_SIZE;
            Integer endPa = startPa + DEFAULT_PAGE_SIZE - 1;

            List<Account> result = new List<Account>();

            System.debug('Start : ' + startPa + ', End : ' + endPa);

            for (Integer i = startPa; i < endPa + 1; i++) {
                result.add(accounts.get(i));
            }
            index++;
            ObjectUpdateProvider provider = new ObjectUpdateProvider(result);
            throwRuntime(Converter.toString(provider));


            /*if (endPa >= accounts.size()) {
                endPa = accounts.size() - 1;
            }
            if (startPa >= accounts.size()) {
                index = 0;
            } else if (startPa < 0) {
                index = accounts.size() / DEFAULT_PAGE_SIZE;
                if (Math.mod(accounts.size(), DEFAULT_PAGE_SIZE) == 0) {
                    index--;
                }
            } else {
                for (Integer i = startPa; i < endPa + 1; i++) {
                    result.add(accounts.get(i));
                }
                index++;
                ObjectUpdateProvider provider = new ObjectUpdateProvider(result);
                throwRuntime(Converter.toString(provider));
            }*/
        }
    }


    @future
    private static void throwRuntime(String objectUpdateProvider) {
        ObjectUpdateProvider objectUpdateProvider2 = (ObjectUpdateProvider) Converter.toObject(objectUpdateProvider, ObjectUpdateProvider.class);
        objectUpdateProvider2.updateAccounts();
    }

}
