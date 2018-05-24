trigger Opportunities on Opportunity (before insert, after update) {
    OpportunityHandler handler = new OpportunityHandler(Trigger.new, Trigger.oldMap);

}