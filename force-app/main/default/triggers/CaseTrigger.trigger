trigger CaseTrigger on Case (before insert, before delete) {
    if(trigger.isBefore && trigger.isInsert){
        CaseHandlerClass.triageNewCases(trigger.new);
    }

    if(trigger.isBefore && trigger.isDelete){
        CaseHandlerClass.preventDelete(trigger.old);
    }
}