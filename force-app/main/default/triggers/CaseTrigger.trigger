trigger CaseTrigger on Case (before insert) {
    if(trigger.isBefore && trigger.isInsert){
        CaseHandlerClass.triageNewCases(trigger.new);
    }
}