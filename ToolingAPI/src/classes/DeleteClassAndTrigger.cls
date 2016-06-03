public class DeleteClassAndTrigger 
{
    public DeleteClassAndTrigger(){
        
        System.Debug('****************************** Constructor initialized!');
        
        //Call ApexClass Delete Method 
        deleteApexClass();
        
        //Call ApexTrigger Delete Method 
        //deleteApexTrigger();
        
        //Call ApexPage Delete Method
        //deleteApexPage();
    }

    public void deleteApexClass(){
        
        //Query for ID
        Map<ID, ApexClass> ApexClassBody = new Map<ID, ApexClass>([SELECT Id,Body FROM ApexClass where Name= 'ToolingAPIWSDLMetadata']); 
 
        for (ID idKey : ApexClassBody.keyset()) 
        {  
            ApexClass a = ApexClassBody.get(idKey);
            
            //Request
            HttpRequest classRequest = buildHttpRequest(URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v28.0/tooling/sobjects/ApexClass/'+ a.Id , 'DELETE');
        
            //Response
            HttpResponse classResponse = buildHttpResponse(classRequest);
            System.Debug('**************************** ApexClass Response: ' + classResponse.getStatus());  
        }    
    }
    
    public void deleteApexTrigger(){
        
        //Query for ID
        Map<ID, ApexTrigger> ApexTriggerBody = new Map<ID, ApexTrigger>([SELECT Id FROM ApexTrigger where Name= 'dsfsd']); 

        for (ID idKey : ApexTriggerBody.keyset()) 
        {   
            ApexTrigger a = ApexTriggerBody.get(idKey);
            //Request
            HttpRequest TriggerRequest = buildHttpRequest(URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v28.0/tooling/sobjects/ApexTrigger/'+ a.Id , 'DELETE');
            
            //Response
            HttpResponse TriggerResponse = buildHttpResponse(TriggerRequest);
            System.Debug('**************************** ApexTrigger Response: ' + TriggerResponse.getStatus());    
        }    
    }
    
    public void deleteApexPage(){
        
        //Query for ID
        Map<ID, ApexPage> ApexPageBody = new Map<ID, ApexPage>([SELECT Id FROM ApexPage where Name= 'dsfsd']); 

        for (ID idKey : ApexPageBody.keyset()) 
        {   
            ApexPage a = ApexPageBody.get(idKey);
            //Request
            HttpRequest PageRequest = buildHttpRequest(URL.getSalesforceBaseUrl().toExternalForm() +'/services/data/v28.0/tooling/sobjects/ApexPage/'+ a.Id , 'DELETE');
            
            //Response
            HttpResponse PageResponse = buildHttpResponse(PageRequest);
            System.Debug('**************************** ApexPage Response: ' + PageResponse.getStatus());    
        }    
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

}