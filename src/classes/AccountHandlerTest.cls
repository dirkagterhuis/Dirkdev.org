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
        Account a = (Account)TestFactory.createSObject(new Account());
        insert a;
        Opportunity o = (Opportunity)TestFactory.createSObject(new Opportunity(AccountId = a.Id));
        insert o;
    }
}