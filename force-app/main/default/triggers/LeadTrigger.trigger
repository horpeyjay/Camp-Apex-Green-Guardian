trigger LeadTrigger on Lead (after insert) {
    if(trigger.isAfter && trigger.isInsert){
        CreateTriggerFromFlow.createTaskForlead(trigger.new);
    }
}