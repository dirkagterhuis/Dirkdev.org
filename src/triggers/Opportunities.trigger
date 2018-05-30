trigger Opportunities on Opportunity (before insert, after update) {
    new OpportunityHandler(Trigger.new, Trigger.oldMap).run();
}