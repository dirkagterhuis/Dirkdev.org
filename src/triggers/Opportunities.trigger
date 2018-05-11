trigger Opportunities on Opportunity (before insert, after update) {
    OpportunityHandler handler = new OpportunityHandler(Trigger.new, Trigger.oldMap);
   
    if (Trigger.isUpdate && Trigger.isBefore)
        handler.beforeUpdate();
 	if (Trigger.IsUpdate && Trigger.isAfter)
        handler.afterUpdate();  
}