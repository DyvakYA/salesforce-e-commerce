/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public interface OrgIntegrationRequest {

    void accept(OrgIntegrationVisitor visitor);

    void setToken(String token);

    void setContentType(String contentType);

    List<Account> execute();
}

