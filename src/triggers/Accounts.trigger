trigger Accounts on Account (before update, after update) {
    new AccountHandler(Trigger.new, Trigger.oldMap).run();
}