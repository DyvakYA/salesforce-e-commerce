/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationUsernamePasswordAuth implements OrgIntegrationVisitor {

    private static final String CLIENT_SECRET = '2BCAC538DCE2C26A2AAA2FC4F84460C8F942495904A8367E43A658C58DC0559A';
    private static final String USER_NAME = 'dyvakyurii@resourceful-panda-1y4ro.com';
    private static final String PASSWORD = 'Pentagon1987';
    private static final String CLIENT_ID = '3MVG96_7YM2sI9wQQLhB3NNoIq71chgfHzdbBLxwBNpvKf2zcH5z_WmcbSRGLLcp.8_cypnIIH0HYouQGDg4F';
    private static final String GRANT_TYPE = 'password';

    public void visit(OrgIntegrationRequest request) {

        String params = '?grant_type=' + GRANT_TYPE + '&client_id=' + CLIENT_ID + '&client_secret=' + CLIENT_SECRET + '&username=' + USER_NAME + '&password=' + PASSWORD;
        System.debug(params);
        // create request for getting access token
        Http http = new Http();
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setMethod('POST');
        httpRequest.setEndpoint('https://login.salesforce.com/services/oauth2/token' + params);
        HttpResponse response = http.send(httpRequest);

        // get body from response
        String body = response.getBody();
        System.debug(body);

        // convert body to object
        Response responseObject = (Response) JSON.deserialize(body, Response.class);
        System.debug(responseObject);

        // get token from response object
        String type = responseObject.token_type;
        String token = responseObject.access_token;

        // set token to main request
        request.setToken(type + ' ' + token);
    }

    public class Response {
        String access_token { get; set; }
        String token_type { get; set; }
    }
}

