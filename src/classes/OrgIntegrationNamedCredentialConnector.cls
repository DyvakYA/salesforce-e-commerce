/**
 * Created by YuriiDyvak on 23.08.2019.
 */

public with sharing class OrgIntegrationNamedCredentialConnector implements OrgIntegrationConnector {


    public OrgIntegrationRequest getIntegrationRequest() {
        return new OrgIntegrationNamedCredentialRequest();
    }

    public OrgIntegrationVisitor getAuthProvider() {
        return new OrgIntegrationNamedCredentialAuth();
    }

    public OrgIntegrationVisitor getContentTypeProvider() {
        return new OrgIntegrationJsonContentType();
    }
}