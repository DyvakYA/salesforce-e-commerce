/**
 * Created by YuriiDyvak on 09.09.2019.
 */

public class Converter {

    public static List<String> toStrings(List<Object> objs) {

        List<String> result = new List<String>();
        for (Object obj : objs) {
            result.add(JSON.serialize(obj));
        }
        return result;
    }

    public static String toString(Object obj) {
        return JSON.serialize(obj);
    }

    public static List<Object> toObjects(List<String> strs, Type apexType) {
        List<Object> result = new List<Object>();

        for (String str : strs) {
            result.add(JSON.deserialize(str, apexType));
        }

        return result;
    }

    public static Object toObject(String str, Type apexType) {
        return JSON.deserialize(str, apexType);
    }
}