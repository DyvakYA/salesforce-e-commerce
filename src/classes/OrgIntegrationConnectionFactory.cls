/**
 * Created by YuriiDyvak on 21.08.2019.
 */

public class OrgIntegrationConnectionFactory {

    private static Map<String, OrgIntegrationConnector> factory;

    static {
        factory = new Map<String, OrgIntegrationConnector>{
                'Username-password flow' => new OrgIntegrationUsernamePasswordConnector(),
                'User-agent flow' => null,
                'Web server flow' => null,
                'Named Credential' => new OrgIntegrationNamedCredentialConnector()
        };
    }

    public static OrgIntegrationConnector getConnector(String selector) {
        return factory.get(selector);
    }
}