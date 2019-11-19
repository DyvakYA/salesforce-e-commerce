/**
 * Created by YuriiDyvak on 10.09.2019.
 */

public class ObjectUpdateProvider {

    private List<Account> accounts;

    public ObjectUpdateProvider(List<Account> accounts){
        this.accounts = accounts;
    }

    public void updateAccounts(){
        for(Account account : accounts){
            update account;
        }
    }
}