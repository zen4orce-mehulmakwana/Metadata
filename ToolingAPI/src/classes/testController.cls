public class testController {

    public JsonTest containerResponse;
    public JsonTest classMemberJson;
    public JsonTest containerAsyncJson;
    public Boolean pollClassMember;
    JsonGET currentClass;    
    public String value;
    public testController(){

        System.Debug('****************************** Constructor initialized!');

        //pre-Step 1
        pollCurrentClass();
    }

    public void pollCurrentClass(){

        List<ApexClass> classlist = new List<ApexClass>([SELECT Id,Body FROM ApexClass where Name= 'ToolingAPIWSDL']); 
        value = classlist[0].id;
    
        //Request
        HttpRequest apexClassRequest = new HttpRequest();
        apexClassRequest.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionID());
        apexClassRequest.setHeader('Content-Type', 'application/json');
        apexClassRequest.setEndpoint(URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v36.0/tooling/sobjects/ApexClass/'+value);      
        apexClassRequest.setMethod('GET');

        //Response
        Http httpResponse = new Http();
        HttpResponse apexClassResponse = httpResponse.send(apexClassRequest);
        System.Debug('**************************** ApexClass Poll Response: ' + apexClassResponse.getBody());
       
        
        currentClass = new JsonGET();
        currentClass = (JsonGET)JSON.Deserialize(apexClassResponse.getBody(),JsonGET.class);
        //System.Debug('**************************** Body of the class: ' + currentClass.body);
    }



    public class JsonTest{
        Public String Id{get;set;}
    }

    Public class JsonGET {
        public String body {get;set;}
    }
}