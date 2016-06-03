public class TestCommentClass 
{
    public JsonTest containerResponse;
    public JsonTest containerAsyncJson;
    public Boolean pollClassMember;
    String regExp = '*/';
    String replacement = '*//*---- Commented by OrgCleaner -----';
	public String classBody = '/*---- Commented by OrgCleaner -----*/';
    
    public TestCommentClass(){

        System.Debug('****************************** Constructor initialized!');
        containerResponse = new JsonTest();

        //Step 1 - Create MetadataContainer
        containerResponse = createMetadataContainer();	

        //Step 2 - Create ApexClassMember
        createApexClassMember();

        //Step 3 - Create ContainerAsyncRequest
        createContainerAsyncRequest();
    }

    public JsonTest createMetadataContainer(){

        //Request
        HttpRequest containerRequest = buildHttpRequest(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v36.0/tooling/sobjects/MetadataContainer/', 'POST');
        containerRequest.setBody('{"Name":"TestContainer53"}');  

        //Response
        HttpResponse containerResponse = buildHttpResponse(containerRequest);

        System.Debug('**************************** Metadata Container Response: ' + containerResponse.getBody());
        return (JsonTest)JSON.Deserialize(containerResponse.getBody(), JsonTest.class);
    }

    public void createApexClassMember(){
        Map<ID, ApexClass> ApexClassBody = new Map<ID, ApexClass>([SELECT Id,Body FROM ApexClass where Name= 'dsfsd']); 
        
        //Request
        HttpRequest apexClassRequest = buildHttpRequest(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v36.0/tooling/sobjects/ApexClassMember/', 'POST');
        
        for (ID idKey : ApexClassBody.keyset()) 
        {  
            ApexClass a = ApexClassBody.get(idKey);
            String s1 = a.Body.substringBefore('{');
            String s2 = a.Body.substringAfter('{');
            s2 ='{ /*'+ s2;
           	s2 = s2.replace(regExp, replacement);
            s2 =s2 + '*/ }';
            classBody = classBody + s1 + s2;   
                Map<String, Object> payload = new Map<String, Object> {
                'ContentEntityId' => a.id,
                'MetadataContainerId' => containerResponse.id,
                'Body' => classBody
                };
            String jsonBody = JSON.serialize(payload);
        	apexClassRequest.setBody(jsonBody);
        }
        //Response
        HttpResponse apexClassResponse = buildHttpResponse(apexClassRequest);

        System.Debug('**************************** ApexClassMember Response: ' + apexClassResponse.getBody());
    }

    public void createContainerAsyncRequest(){
        //Request
        HttpRequest containerAsyncRequest = buildHttpRequest(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v36.0/tooling/sobjects/ContainerAsyncRequest/', 'POST');
        containerAsyncRequest.setBody('{"IsCheckOnly": false, "MetadataContainerId": "'+ containerResponse.id +'"}');

        //Response
        HttpResponse containerAsyncResponse = buildHttpResponse(containerAsyncRequest);

        System.Debug('**************************** ContainerAsync Response: ' + containerAsyncResponse.getBody());
        containerAsyncJson = (JsonTest)JSON.Deserialize(containerAsyncResponse.getBody(), JsonTest.class);
    }
    
	public HttpRequest buildHttpRequest(String endpoint, String method){
        HttpRequest request = new HttpRequest();
        request.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        request.setHeader('Content-Type', 'application/json');
        request.setEndpoint(endpoint);
        request.setMethod(method);
        return request;
    }

    public HttpResponse buildHttpResponse(HttpRequest sendRequest){
        Http poll = new Http();
        HttpResponse pollResponse = poll.send(sendRequest);
        return pollResponse;
    }

    public class JsonTest{
        Public String Id;
    }

    Public class JsonGET {
        public String body;
    }   

}