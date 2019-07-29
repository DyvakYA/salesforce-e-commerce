/**
 * Created by YuriiDyvak on 22.07.2019.
 */


public with sharing class MockProvider implements StubProvider {

    public Object handleMethodCall(Object stubbedObject, String methodName,
            Type returnType, List<Type> listOfParamTypes,
            List<String> listOfParamNames, List<Object> listOfArgs) {

        return emailSending(stubbedObject, methodName);
    }

    private Object emailSending(Object stubbedObject, String methodName) {
        if (stubbedObject instanceOf EmailSending) {
            if (methodName.equals('send')) {
                return true;
            }
            if (methodName.equals('email')) {
                return new EmailSending.EmailBuilder();
            }
        }
        return null;
    }
}