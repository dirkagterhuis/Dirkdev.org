@isTest
private class OpportunityHandlerTest {

    @isTest
    private static void createCaseAndWorkOrderForInstallationOpportunity() {
        Opportunity o = [SELECT Id From Opportunity LIMIT 1];
        o.StageName = 'Closed Won';
        update o;
        System.assertEquals(1, [SELECT count() FROM Case]);
        System.assertEquals(1, [SELECT count() FROM WorkOrder]);
    }
    
    @TestSetup
    private static void setup() {
        Account a = new Account(Name = 'Westeros Inc', Active__c = 'Yes');
        insert a;
        insert new Opportunity(Name = 'Wholesale Dragon Leather Cloak', 
                               StageName = 'New', 
                               AccountId = a.Id, 
                               CloseDate = System.today(),
                               Type = 'Installation'
        );
    }
    
}