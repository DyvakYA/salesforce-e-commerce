/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationConnectorFirst implements OrgIntegrationConnector {


    public OrgIntegrationRequest getIntegrationRequest() {
        return new OrgIntegrationRequestFirst();
    }

    public OrgIntegrationVisitor getAuthProvider() {
        return new OrgIntegrationAuthenticationVisitor();
    }

    public OrgIntegrationVisitor getRequestTypeProvider() {
        return new OrgIntegrationRequestTypeVisitor();
    }
}