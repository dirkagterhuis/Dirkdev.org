@isTest
private class AccountHandlerTest {
	
    @isTest
    static void cancelOpenOpportunitiesInactiveAccount() {
        Account a = [SELECT id from Account LIMIT 1];
        a.Active__c = 'No';
        update a;
        Opportunity o = [SELECT StageName FROM Opportunity WHERE AccountId =: a.Id LIMIT 1];
        System.assertEquals('Closed Lost', o.StageName);
    }
    
    @isTest
    static void wasAccountDeactivated() {
        Account oldVersion = new Account(Active__c = 'Yes');
        Account newVersion = new Account(Active__c = 'No');
        System.assertEquals(true, new AccountHandler(null, null).wasAccountDeactivated(newversion, oldVersion));
    }
    
    @TestSetup
    static void setup() { 
    	Account a = new Account(Name = 'Westeros Inc', Active__c = 'Yes');
        insert a;
        Opportunity o = new Opportunity(Name = 'Wholesale Dragon Leather Cloak', StageName = 'New', AccountId = a.Id, CloseDate = System.today());
        insert o;
    }
}