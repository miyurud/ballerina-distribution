import ballerina/test;
import ballerina/io;
import ballerina/http;


boolean serviceStarted;

function startService() {
    //serviceStarted = test:startServices("base-path-and-path");
}

@test:Config {
    before: "startService",
    after: "stopService"
}
function testFunc() {
    // Invoking the main function.
    http:Client httpEndpoint = new("http://localhost:9090");
    // Check whether the server has started. 
    //test:assertTrue(serviceStarted, msg = "Unable to start the service");
    json payload = { "hello": "world" };
    http:Request req = new;
    req.setJsonPayload(payload);
    // Send a `GET` request to the specified endpoint.
    var response = httpEndpoint->post("/foo/bar", req);
    match response {
        var resp if resp is http:Response => {
            var jsonRes = check resp.getJsonPayload();
            test:assertEquals(jsonRes, payload);
        }
        var err if err is error => test:assertFail(msg = "Failed to call the endpoint:");
    }
}

function stopService() {
    //test:stopServices("base-path-and-path");
}
