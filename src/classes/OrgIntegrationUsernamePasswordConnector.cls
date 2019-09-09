/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationUsernamePasswordConnector implements OrgIntegrationConnector {


    public OrgIntegrationRequest getIntegrationRequest() {
        return new OrgIntegrationUsernamePasswordRequest();
    }

    public OrgIntegrationVisitor getAuthProvider() {
        return new OrgIntegrationUsernamePasswordAuth();
    }

    public OrgIntegrationVisitor getContentTypeProvider() {
        return new OrgIntegrationJsonContentType();
    }
}