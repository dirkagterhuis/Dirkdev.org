public with sharing class OpportunityHandler {
    
    List<Opportunity> newOpportunities;
    Map<Id, Opportunity> oldOpportunitiesMap;
    
    public Opportunityhandler(List<Opportunity> triggerNew, Map<Id, Opportunity> triggerOldMap) {
        this.newOpportunities = triggerNew;
        this.oldOpportunitiesMap = triggerOldMap;
    }
    
    public void beforeUpdate() {
        
    }
    
    public void afterUpdate() {
        createCasesAndWorkOrdersForClosedWonOpportunities();
    }

    private void createCasesAndWorkOrdersForClosedWonOpportunities() {
        Set<Id> opportunityIds = new Set<Id>();
		for (Opportunity newOpportunity : newOpportunities)
			if (isOpportunityClosedWon(newOpportunity, oldOpportunitiesMap.get(newOpportunity.Id)) && isOpportunityInstallation(newOpportunity)) opportunityIds.add(newOpportunity.Id);
		if (opportunityIds.size() > 0) createCaseandWorkOrder(opportunityIds);

    }

	private boolean isOpportunityClosedWon(Opportunity newVersion, Opportunity oldVersion) {
        return oldVersion.StageName != 'Closed Won' && newVersion.StageName == 'Closed Won';
    }

	private boolean isOpportunityInstallation(Opportunity newVersion) {
        return newVersion.Type == 'Installation';
    }

	private void createCaseandWorkOrder(Set<Id> opportunityIds) {
		List<Case> casesToBeCreated = new List<Case>();
		for (id opportunityId : opportunityIds) {
			Case caseToBeCreated = new Case(Status 			= 	'New',
											Origin 			= 	'Opportunity',
											Opportunity__c 	= 	opportunityId);
			casesToBeCreated.add(caseToBeCreated);
		}
		insert casesToBeCreated;
		List<WorkOrder> workOrdersToBeCreated = new List<WorkOrder>();
		for (Case caseToBeCreated : casesToBeCreated) {
			WorkOrder workOrderToBeCreated = new WorkOrder(	CaseId 			= 	caseToBeCreated.id,
															Opportunity__c 	= 	caseToBeCreated.Opportunity__c);
			workOrdersToBeCreated.add(workOrderToBeCreated);
		}
		insert workOrdersToBeCreated;		
	}	
}
// dirk is een baas, dit staat in branch 'assignment2' of niet
// helahola
// dit is de meest recente toevoeging
// he leo, negeer de 3 regels hierboven en check deze hele class!