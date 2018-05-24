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
        Account a = (Account)TestFactory.createSObject(new Account());
        insert a;
        Opportunity o = (Opportunity)TestFactory.createSObject(new Opportunity(AccountId = a.Id, type = 'installation'));
        insert o;
    }
    
}