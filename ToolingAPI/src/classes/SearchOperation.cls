public class SearchOperation 
{
    //Search Keyword
    public String SearchKeyword = 'Confirmation_Keyword__c'; 
    
    Public void SearchClass()
    {
        //SOSL Dynamic Query
        String SearchQuery = 'FIND {' +SearchKeyword+ '} RETURNING ApexClass(name), ApexTrigger(name)';
        
        Search.SearchResults searchResults = Search.find(SearchQuery);
        List<Search.SearchResult> ClassSearchResult = searchResults.get('ApexClass');
        List<Search.SearchResult> TriggerSearchResult = searchResults.get('ApexTrigger');
        
        //Retriving Keyword Used in Class
        for (Search.SearchResult searchResult : ClassSearchResult) { 
        ApexClass Classes = (ApexClass) searchResult.getSObject(); 
        System.debug('******************************* Used in Class ' +Classes.Name); 
        }
        
        //Retriving Keyword Used in Triggers
        for (Search.SearchResult TriggersearchResults : TriggerSearchResult) { 
        ApexTrigger Triggers = (ApexTrigger) TriggersearchResults.getSObject(); 
        System.debug('******************************* Used in Triggers ' +Triggers.Name);
		} 
      
    }
    
    Public void SearchforPage(){
        
        //Retriving Keyword Used in Pages
        Map<ID, ApexPage> ApexpageBody = new Map<ID, ApexPage>([SELECT Id,Name,Markup FROM ApexPage]);
        List<String> PageNames = new List<String>();
        for (ID idKey : ApexpageBody.keyset()) 
        {
            ApexPage a = ApexpageBody.get(idKey);
            Boolean PageSearchResult = a.Markup.contains(SearchKeyword);
            if(PageSearchResult)
            {
                PageNames.add(a.Name);
            }  
        }
        System.debug('******************************* Received Page Name '+ PageNames); 
    }
}