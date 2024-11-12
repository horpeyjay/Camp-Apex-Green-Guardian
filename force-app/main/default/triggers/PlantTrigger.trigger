trigger PlantTrigger on CAMPX__Plant__c (before insert, before update, after insert, after update, after undelete, after delete) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            PlantHelperClass.plantDefaultValues(trigger.new);
        }

        if(trigger.isUpdate){

        }
    }

    if(trigger.isAfter){
        if(trigger.isInsert || trigger.isUndelete){
            PlantHelperClass.updateTotalPlantCount(trigger.new, null);
        }

        if(trigger.isUpdate){
            PlantHelperClass.updateTotalPlantCount(trigger.new, trigger.oldMap);
        }

        if(trigger.isDelete){
            PlantHelperClass.updateTotalPlantCount(trigger.old, null);
        }
    }
}