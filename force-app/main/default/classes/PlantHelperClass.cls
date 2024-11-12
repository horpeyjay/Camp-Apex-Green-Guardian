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
}    
