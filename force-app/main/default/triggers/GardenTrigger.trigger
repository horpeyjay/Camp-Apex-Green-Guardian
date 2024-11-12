trigger GardenTrigger on CAMPX__Garden__c (before insert, before update, before delete, after insert, after update) {
    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUndelete){
            GardenHelperClass.defaultValues(trigger.new);
            GardenHelperClass.setManagerDate(trigger.new);
            GardenHelperClass.capacityCalculation(trigger.new);
            GardenHelperClass.healthIndex(trigger.new);
        }

        if(trigger.isUpdate){
            GardenHelperClass.setManagerDate(trigger.new);
            GardenHelperClass.capacityCalculation(trigger.new);
            GardenHelperClass.healthIndex(trigger.new);
        }
    }

    if(trigger.isAfter){
        if(trigger.isInsert){
            GardenHelperClass.createTaskForManager(trigger.new, null);
        }

        if(trigger.isUpdate){
            GardenHelperClass.createTaskForManager(trigger.new, trigger.oldMap);
            GardenHelperClass.reassignTask(trigger.new, trigger.oldMap);
            GardenHelperClass.deleteTasks(trigger.new, trigger.oldMap);
        }
    }
}