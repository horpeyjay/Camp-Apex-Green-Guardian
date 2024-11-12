trigger PlantTrigger on CAMPX__Plant__c (before insert, before update, after insert, after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            PlantHelperClass.plantDefaultValues(trigger.new);
        }

        if(trigger.isUpdate){

        }
    }

    if(trigger.isAfter){
        if(trigger.isInsert){

        }

        if(trigger.isUpdate){

        }
    }
}