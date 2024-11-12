public with sharing class PlantHelperClass {
    public static void plantDefaultValues(List<CAMPX__Plant__c> plantList) {
        Set<Id> gardenIds = new Set<Id>();

        // Collect garden IDs for plants needing sunlight values
        if (!plantList.isEmpty()) {
            for (CAMPX__Plant__c cp : plantList) {
                if (cp.CAMPX__Garden__c != null && cp.CAMPX__Sunlight__c == null) {
                    gardenIds.add(cp.CAMPX__Garden__c);
                }
            }
        }

        // Query relevant gardens
        Map<Id, CAMPX__Garden__c> gardenMap = new Map<Id, CAMPX__Garden__c>(
            [SELECT Id, CAMPX__Sun_Exposure__c FROM CAMPX__Garden__c WHERE Id IN :gardenIds]
        );

        // Apply default values to plants
        for (CAMPX__Plant__c cp : plantList) {
            // Set Soil Type and Water if not provided
            if (cp.CAMPX__Soil_Type__c == null) {
                cp.CAMPX__Soil_Type__c = 'All Purpose Potting Soil';
            }
            if (cp.CAMPX__Water__c == null) {
                cp.CAMPX__Water__c = 'Once Weekly';
            }

            // Set Sunlight based on garden or default to Partial Sun
            if (cp.CAMPX__Sunlight__c == null) {
                CAMPX__Garden__c garden = gardenMap.get(cp.CAMPX__Garden__c);
                if (garden != null && garden.CAMPX__Sun_Exposure__c != null) {
                    cp.CAMPX__Sunlight__c = garden.CAMPX__Sun_Exposure__c;
                } else {
                    cp.CAMPX__Sunlight__c = 'Partial Sun';
                }
            }
        }
    }

    /*
        Acceptance Criteria:

        The garden's "Total Plant Count" (CAMPX__Total_Plant_Count__c) field should increase when a plant is associated to a garden and decrease when a plant is removed from the garden
        A plant is also considered removed from a garden when the plant is deleted
    */

    public static void updateTotalPlantCount(List<CAMPX__Plant__c> plantList, Map<Id, CAMPX__Plant__c> plantMap) {
        Set<Id> gardenIds = new Set<Id>();

        if(!plantList.isEmpty()){
            for(CAMPX__Plant__c cp : plantList){
                if(plantMap != null){
                    CAMPX__Plant__c oldPlant = plantMap.get(cp.Id);
                    if(cp.Id != null && oldPlant.CAMPX__Garden__c != cp.CAMPX__Garden__c){
                        gardenIds.add(oldPlant.CAMPX__Garden__c);
                        gardenIds.add(cp.CAMPX__Garden__c);
                    }else{
                        gardenIds.add(cp.CAMPX__Garden__c);
                    }
                }else{
                    gardenIds.add(cp.CAMPX__Garden__c);
                }
            }
        }
        Map<Id, Integer> countPlantMap = new Map<Id, Integer>();
        if(gardenIds.size() > 0){
            /*List<CAMPX__Plant__c> relatedPlantList = [Select Id, CAMPX__Garden__c From CAMPX__Plant__c where CAMPX__Garden__c In : gardenIds];

            List<CAMPX__Garden__c> gardenList = [Select Id, CAMPX__Total_Plant_Count__c From CAMPX__Garden__c where Id In : gardenIds];

            for(CAMPX__Garden__c cg : gardenList){

                for(CAMPX__Plant__c cp : relatedPlantList){
                    if(cp.CAMPX__Garden__c == null){
                        countPlantMap.put(cg.Id, 0);
                    }
                    if(cg.Id == cp.CAMPX__Garden__c){
                        if(countPlantMap.containsKey(cg.Id)){
                            countPlantMap.put(cg.Id, countPlantMap.get(cg.Id) + 1);
                        }else{
                            countPlantMap.put(cg.Id, 1);
                        }
                    }
                } 
            }*/

            // Query for the gardens by ID
            List<CAMPX__Garden__c> gardenList = [SELECT Id, CAMPX__Total_Plant_Count__c FROM CAMPX__Garden__c WHERE Id IN :gardenIds];

            // Initialize each garden in the map with a count of 0
            for (CAMPX__Garden__c cg : gardenList) {
                countPlantMap.put(cg.Id, 0);
            }

            // Query for plants associated with the specified garden IDs
            List<CAMPX__Plant__c> relatedPlantList = [SELECT Id, CAMPX__Garden__c FROM CAMPX__Plant__c WHERE CAMPX__Garden__c IN :gardenIds];

            // Increment the count for each plant found in relatedPlantList
            for (CAMPX__Plant__c cp : relatedPlantList) {
                if (countPlantMap.containsKey(cp.CAMPX__Garden__c)) {
                    countPlantMap.put(cp.CAMPX__Garden__c, countPlantMap.get(cp.CAMPX__Garden__c) + 1);
                }
            }
        }
        List<CAMPX__Garden__c> gardenToUpdate = new List<CAMPX__Garden__c>();
        if(countPlantMap != null && countPlantMap.size() > 0){
            for(Id gardenId : countPlantMap.keySet()){
                CAMPX__Garden__c singleGarden = new CAMPX__Garden__c();
                singleGarden.Id = gardenId;
                singleGarden.CAMPX__Total_Plant_Count__c = countPlantMap.get(gardenId);
                gardenToUpdate.add(singleGarden);
            }
        }

        if(!gardenToUpdate.isEmpty()){
            update gardenToUpdate;
        }
    }
}    
