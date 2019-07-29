trigger TerritoryTrigger on Territory__c (before insert, before update) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            TerritoryHandler.checkIfTerritoryIsUnique(Trigger.new);
        }
        if (Trigger.isUpdate) {
            TerritoryHandler.checkIfTerritoryIsUnique(Trigger.new);
        }
    }
}