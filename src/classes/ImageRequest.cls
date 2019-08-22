/**
 * Created by YuriiDyvak on 12.08.2019.
 */

public with sharing class ImageRequest {

    public Integer sendRequest(StaticResource file) {
        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('https://content.dropboxapi.com/2/files/upload');
        request.setHeader('Authorization', 'Bearer 5MwR4ZOyu0AAAAAAAAAAgytBU7ETQBeVYnIzwJ7nJt56o8iept5JVbVLEQUv3-xC');
        request.setHeader('Dropbox-API-Arg', '{"path": "/Homework/math/Matrices.txt","mode": "add","autorename": true,"mute": false,"strict_conflict": false}');
        request.setHeader('Content-Type', 'application/octet-stream');
        request.setBodyAsBlob(file.Body);
        HttpResponse response = http.send(request);
        return response.getStatusCode();
    }

}