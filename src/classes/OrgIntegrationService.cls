/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationService {

    void execute() {
        // abstract factory
        OrgIntegrationConnector connector = OrgIntegrationConnectionFactory.getConnector('First');

        // request from factory
        OrgIntegrationRequest request = connector.getIntegrationRequest();

        // visitors from factory for request
        OrgIntegrationVisitor authVisitor = connector.getAuthProvider();
        OrgIntegrationVisitor typeVisitor = connector.getRequestTypeProvider();

        // visitor
        request.accept(authVisitor);
        request.accept(typeVisitor);

        // execution
        List<Account> accounts = request.execute();
    }


}