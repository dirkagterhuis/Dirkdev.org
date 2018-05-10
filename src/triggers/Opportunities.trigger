trigger Opportunities on Opportunity (after update) {
    OpportunityHandler handler = new OpportunityHandler(Trigger.new, Trigger.oldMap);
    
 	if (Trigger.IsUpdate && Trigger.isAfter)
        handler.afterUpdate();
}