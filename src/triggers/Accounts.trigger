trigger Accounts on Account (before update, after update) {
    AccountHandler handler = new AccountHandler(Trigger.new, Trigger.oldMap);
    
    if (Trigger.isUpdate && Trigger.isBefore)
        handler.beforeUpdate();
 	if (Trigger.IsUpdate && Trigger.isAfter)
        handler.afterUpdate();
}
// woohoo