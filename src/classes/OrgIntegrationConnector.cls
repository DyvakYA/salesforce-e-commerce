/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public interface OrgIntegrationConnector {

    OrgIntegrationRequest getIntegrationRequest();

    OrgIntegrationVisitor getAuthProvider();

    OrgIntegrationVisitor getContentTypeProvider();

}