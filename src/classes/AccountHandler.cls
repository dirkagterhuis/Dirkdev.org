public with sharing class AccountHandler {
    
    List<Account> newAccounts;
    Map<Id, Account> oldAccountsMap;
    
    public AccountHandler(List<Account> triggerNew, Map<Id, Account> triggerOldMap) {
        this.newAccounts = triggerNew;
        this.oldAccountsMap = triggerOldMap;
    }
    
    public void beforeUpdate() {
        
    }
    
    public void afterUpdate() {
        closeOpportunitiesForInactiveAccounts();
    }
    
    private void closeOpportunitiesForInactiveAccounts() {
        Set<Id> accountIds = new Set<Id>(); 
        for (Account newAccount : newAccounts) 
            if (wasAccountDeactivated(newAccount, oldAccountsMap.get(newAccount.Id))) accountIds.add(newAccount.Id);
        if (accountIds.size() > 0) closeRelevantOpportunities(accountIds);
    }
    
    
    @TestVisible
    private boolean wasAccountDeactivated(Account newVersion, account oldVersion) {
        return oldVersion.Active__c == 'Yes' && newVersion.Active__c == 'No';
    }
    
    private void closeRelevantOpportunities(Set<Id> accountIds) {
        List<Opportunity> opportunitiesToClose = [SELECT Id, StageName FROM Opportunity WHERE AccountId IN: accountIds AND IsClosed = false];
        for (Opportunity opportunityToClose : opportunitiesToClose) opportunityToClose.StageName = 'Closed Lost';    
        update opportunitiesToClose;
    }
    
}