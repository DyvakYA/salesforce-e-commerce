/**
 * Created by YuriiDyvak on 12.08.2019.
 */

@isTest
public with sharing class ImageTest {
    @isTest
    public static void test() {
        StaticResource file = [SELECT Id, Name, description, contentType, body, cacheControl FROM StaticResource WHERE id = '0812p000000qpVxAAI'];
        System.debug(file);

        ImageRequest request = new ImageRequest();
        request.sendRequest(file);




    }

}