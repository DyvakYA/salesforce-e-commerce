/**
 * Created by YuriiDyvak on 22.08.2019.
 */

public class OrgIntegrationController {

    @AuraEnabled
    public static List<Account> getExternalAccounts(String authType) {
        System.debug(authType);
        OrgIntegrationService service = (OrgIntegrationService) Application.Service.get(OrgIntegrationService.class);
        return service.getExternalAccounts(authType);
    }

}