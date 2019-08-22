/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationRequestFirst implements OrgIntegrationRequest {

    public void accept(OrgIntegrationVisitor visitor) {
        visitor.visit(this);
    }

    public void execute() {
    }
}