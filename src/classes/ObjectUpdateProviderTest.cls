/**
 * Created by YuriiDyvak on 10.09.2019.
 */

@isTest(SeeAllData=true)
public class ObjectUpdateProviderTest {

    @isTest
    public static void testProvider(){
        //AccountsWebService service = new AccountsWebService();
        AccountsWebService.getAccounts();
    }


}