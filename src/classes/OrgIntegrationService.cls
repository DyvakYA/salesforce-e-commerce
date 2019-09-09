/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationService {

    public List<Account> getExternalAccounts(String authType) {
        // abstract factory
        OrgIntegrationConnector connector = OrgIntegrationConnectionFactory.getConnector(authType);

        // request from factory
        OrgIntegrationRequest request = connector.getIntegrationRequest();

        // visitors from factory for request
        OrgIntegrationVisitor authVisitor = connector.getAuthProvider();
        OrgIntegrationVisitor typeVisitor = connector.getContentTypeProvider();

        // visit
        request.accept(authVisitor);
        request.accept(typeVisitor);

        // execution
        return request.execute();
    }


}