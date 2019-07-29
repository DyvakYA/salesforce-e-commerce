/**
 * Created by YuriiDyvak on 22.07.2019.
 */
public class MockUtil {
    private MockUtil() {
    }

    public static MockProvider getInstance() {
        return new MockProvider();
    }

    public static Object createMock(Type typeToMock) {
        return Test.createStub(typeToMock, MockUtil.getInstance());
    }
}