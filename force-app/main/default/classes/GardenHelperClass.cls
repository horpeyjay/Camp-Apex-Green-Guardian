public with sharing class GardenHelperClass {
    public static void defaultValues(List<CAMPX__Garden__c> gardenList){
        List<CAMPX__Garden__c> insertList = new List<CAMPX__Garden__c>();
        if(!gardenList.isEmpty()){
            for(CAMPX__Garden__c g : gardenList){
                if(g.CAMPX__Status__c == null){
                    g.CAMPX__Status__c = 'Awaiting Resources';
                }

                if(g.CAMPX__Max_Plant_Count__c == null){
                    g.CAMPX__Max_Plant_Count__c = 100;
                }

                if(g.CAMPX__Minimum_Plant_Count__c == null){
                    g.CAMPX__Minimum_Plant_Count__c = 1;
                }

                if(g.CAMPX__Total_Plant_Count__c == null){
                    g.CAMPX__Total_Plant_Count__c = 0;
                }

                if(g.CAMPX__Total_Unhealthy_Plant_Count__c == null){
                    g.CAMPX__Total_Unhealthy_Plant_Count__c = 0;
                }

                insertList.add(g);
            }
        }
    }

    public static void createTaskForManager(List<CAMPX__Garden__c> gardenList, Map<Id, CAMPX__Garden__c> gardenMap){
        List<Task> taskList = new List<Task>();
        if(!gardenList.isEmpty()){
            for(CAMPX__Garden__c g : gardenList){
                CAMPX__Garden__c oldGarden = new CAMPX__Garden__c();
                if(gardenMap != null){
                    oldGarden = gardenMap.get(g.Id);
                }
                
                if(g.CAMPX__Manager__c != null && oldGarden.CAMPX__Manager__c == null){
                    Task t = new Task();
                    t.OwnerId = g.CAMPX__Manager__c;
                    t.Subject = 'Acquire Plants' ;
                    t.WhatId = g.Id;
                    taskList.add(t);
                }
            }
        }
        if(!taskList.isEmpty()){

            insert taskList;
        }
    }

    /**
     * When a garden's manager is updated to reassign a manager, any task record that meets this criteria should also be reassigned
        Status: Not "Completed"
        OwnerId: The previous manager
        Subject: Acquire Plants
        WhatId: The garden's Id 
    */
    public static void reassignTask(List<CAMPX__Garden__c> gList, Map<Id, CAMPX__Garden__c>gMap){

        Set<Id> recordIds = new Set<Id>();
        Map<Id, Id> prevToNewManagerMap = new Map<Id, Id>();
        if(!gList.isEmpty()){
            for(CAMPX__Garden__c g : gList){
                CAMPX__Garden__c oldG = gMap.get(g.Id);
                if(oldG.CAMPX__Manager__c != g.CAMPX__Manager__c && g.CAMPX__Manager__c != null){
                    prevToNewManagerMap.put(oldG.CAMPX__Manager__c, g.CAMPX__Manager__c);
                    recordIds.add(g.Id);
                }
            }
        }
        List<Task> taskToUpdate = new List<Task>();
        if(prevToNewManagerMap != null){
            List<Task> prevManagerTask = [Select Id, WhatId, OwnerId From Task where OwnerId In : prevToNewManagerMap.keySet() and Status != 'Completed' and Subject = 'Acquire Plants' And WhatId In : recordIds];
            
            for(Task t : prevManagerTask){
                t.OwnerId = prevToNewManagerMap.get(t.OwnerId);
                taskToUpdate.add(t);
            }
        }

        if(!taskToUpdate.isEmpty()){
            update taskToUpdate;
        }
    }  
    
    /**When a garden's manager is unassigned and no immediate replacement is named, its open "Acquire Plants" tasks should be deleted
        Any task record that meets this criteria should be deleted:
        Status: Not "Completed"
        OwnerId: The previous manager
        Subject: Acquire Plants
        WhatId: The garden's Id 
    */
    public static void deleteTasks(List<CAMPX__Garden__c> gList, Map<Id, CAMPX__Garden__c>gMap){

        Set<Id> prevManagerId = new Set<Id>();
        Set<Id> recordId = new Set<Id>();
        if(!gList.isEmpty()){
            for(CAMPX__Garden__c g : gList){
                CAMPX__Garden__c oldG = gMap.get(g.Id);
                if(oldG.CAMPX__Manager__c != g.CAMPX__Manager__c && g.CAMPX__Manager__c == null){
                    prevManagerId.add(oldG.CAMPX__Manager__c);
                    recordId.add(g.Id);
                }
            }
        }
        
        if(prevManagerId.size() > 0){
            List<Task> tasksToDelete = [Select Id From Task where Status != 'Completed' and Subject = 'Acquire Plants' and OwnerId In : prevManagerId and WhatId In : recordId];

            if(!tasksToDelete.isEmpty()){
                delete TasksToDelete;
            }
        }
    }

    /**
     * The "Manager Start Date" (CAMPX__Manager_Start_Date__c) should be set in the following scenarios:
        When a manager is assigned, the field must be set with the current date
        When a manager is unassigned and no replacement is named, the field must be cleared
    */

    public static void setManagerDate(List<CAMPX__Garden__c> newList){

        if(!newList.isEmpty()){
            for(CAMPX__Garden__c g : newList){
                if(g.CAMPX__Manager__c != null){
                    g.CAMPX__Manager_Start_Date__c = System.today();
                }else{
                    g.CAMPX__Manager_Start_Date__c = null;
                }
            }
        }
    }
}