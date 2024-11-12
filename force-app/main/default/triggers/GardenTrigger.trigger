trigger GardenTrigger on CAMPX__Garden__c (before insert, before update, after insert, after update) {
    if(trigger.isBefore){
        if(trigger.isInsert){
            GardenHelperClass.defaultValues(trigger.new);
            
        }

        if(trigger.isUpdate){

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