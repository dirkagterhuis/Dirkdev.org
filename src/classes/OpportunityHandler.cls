public with sharing class OpportunityHandler {
    
    List<Opportunity> newOpportunities;
    Map<Id, Opportunity> oldOpportunitiesMap;
    
    public Opportunityndler(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerOldMap) {
        this.newOpportunities = triggerNew;
        this.oldOpportunitiesMap = triggerOldMap;
    }
    
    public void beforeUpdate() {
        
    }
    
    public void afterUpdate() {
        myMethod();
    }

    private void myMethod() {
        ;
    }