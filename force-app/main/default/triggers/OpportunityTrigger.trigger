trigger OpportunityTrigger on Opportunity (after update) {
    if(trigger.isAfter && trigger.isUpdate){
        OpportunityHandlerClass.renewalOpportunity(trigger.new, trigger.oldMap);
    }
}