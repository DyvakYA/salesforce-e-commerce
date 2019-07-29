/**
 * Created by dyvakyurii on 26.06.19.
 */

public with sharing class TerritoryHandler {

    public static void checkIfTerritoryIsUnique(List<Territory__c> territories) {

        if (!territories.isEmpty()) {
            TerritoryService territoryService = new territoryService();
            territoryService.checkIfTerritoryIsUnique(territories);
        }
    }

}