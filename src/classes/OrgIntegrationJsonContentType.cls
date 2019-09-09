/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationJsonContentType implements OrgIntegrationVisitor {

    private String type = 'application/json';

    public void visit(OrgIntegrationRequest request) {
        request.setContentType(type);
    }
}