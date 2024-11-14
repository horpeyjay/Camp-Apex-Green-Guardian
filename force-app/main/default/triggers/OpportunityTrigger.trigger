trigger OpportunityTrigger on Opportunity (before insert, after update) {
    if(trigger.isAfter && trigger.isUpdate){
        OpportunityHandlerClass.renewalOpportunity(trigger.new, trigger.oldMap);
    }

    if(trigger.isBefore && trigger.isInsert){
        OpportunityHandlerClass.defaultOppName(trigger.new);
    }
}