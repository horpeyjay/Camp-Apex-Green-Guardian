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
        Map<Id, Decimal> maxPlantCountMap = new Map<Id, Decimal>();
        if(gardenIds.size() > 0){

            // Query for the gardens by ID
            List<CAMPX__Garden__c> gardenList = [SELECT Id, CAMPX__Total_Plant_Count__c, CAMPX__Max_Plant_Count__c FROM CAMPX__Garden__c WHERE Id IN :gardenIds];

            // Initialize each garden in the map with a count of 0
            for (CAMPX__Garden__c cg : gardenList) {
                countPlantMap.put(cg.Id, 0);
                maxPlantCountMap.put(cg.Id, cg.CAMPX__Max_Plant_Count__c);
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
                Decimal maxPlant = maxPlantCountMap.get(gardenId);

                Decimal capacity = (singleGarden.CAMPX__Total_Plant_Count__c / maxPlant) * 100;
                if(capacity <= 100){
                    singleGarden.CAMPX__Capacity__c = capacity;
                }
                gardenToUpdate.add(singleGarden);
            }
        }

        if(!gardenToUpdate.isEmpty()){
            update gardenToUpdate;
        }
    }

    public static void unhealthyPlantCount(List<CAMPX__Plant__c> unhealthyPlants, Map<Id, CAMPX__Plant__c> oldPlantMap){
        Set<Id> gardenIds = new Set<Id>();

        if(!unhealthyPlants.isEmpty()){
            for(CAMPX__Plant__c cp : unhealthyPlants){
                if(oldPlantMap != null){
                    CAMPX__Plant__c oldPlant = oldPlantMap.get(cp.Id);
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
        Map<Id, Integer> unhealthyPlantMap = new Map<Id, Integer>();
        if(!gardenIds.isEmpty()){

            List<CAMPX__Garden__c> gardenList = [Select Id, CAMPX__Total_Unhealthy_Plant_Count__c From CAMPX__Garden__c where Id in : gardenIds];

            for(CAMPX__Garden__c cg : gardenList){
                unhealthyPlantMap.put(cg.Id, 0);
            }

            List<CAMPX__Plant__c> plantList = [Select Id, CAMPX__Garden__c, CAMPX__Status__c From CAMPX__Plant__c where CAMPX__Garden__c in : gardenIds And CAMPX__Status__c in ('Sick', 'Deceased', 'Wilting')];

            for(CAMPX__Plant__c cp : plantList){
                if(unhealthyPlantMap.containsKey(cp.CAMPX__Garden__c)){
                    unhealthyPlantMap.put(cp.CAMPX__Garden__c, unhealthyPlantMap.get(cp.CAMPX__Garden__c)+ 1);
                }
            }
        }
        List<CAMPX__Garden__c> gardenToUpdate = new List<CAMPX__Garden__c>();
        if(unhealthyPlantMap != null && unhealthyPlantMap.size() > 0){
            for(Id gardenId : unhealthyPlantMap.keySet()){
                CAMPX__Garden__c singleGarden = new CAMPX__Garden__c();
                singleGarden.Id = gardenId;
                singleGarden.CAMPX__Total_Unhealthy_Plant_Count__c = unhealthyPlantMap.get(gardenId);
                gardenToUpdate.add(singleGarden);
            }
        }

        if(gardenToUpdate.size() > 0){
            update gardenToUpdate;
        }
    }
}    
