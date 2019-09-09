/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationUsernamePasswordRequest implements OrgIntegrationRequest {

    private String token;

    private String contentType;

    public void accept(OrgIntegrationVisitor visitor) {
        visitor.visit(this);
    }

    public List<Account> execute() {

        System.debug('Token -> ' + token);

        Http http = new Http();
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setMethod('GET');
        httpRequest.setEndpoint('https://resourceful-panda-1y4ro-dev-ed.my.salesforce.com/services/apexrest/accounts');
        httpRequest.setHeader('Authorization', token);
        httpRequest.setHeader('Content-Type', contentType);
        HttpResponse response = http.send(httpRequest);
        System.debug(response);
        System.debug(response.getBody());

        List<Account> accounts = (List<Account>) JSON.deserialize(response.getBody(), List<Account>.class);
        System.debug(accounts);

        return accounts;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }
}