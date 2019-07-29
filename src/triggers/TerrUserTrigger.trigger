trigger TerrUserTrigger on TerrUser__c (after insert, after update) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            TerrUserHandler.setAccountAndContactPermissionsByTerrUser(Trigger.New);
        }
        if (Trigger.isUpdate) {
            TerrUserHandler.setAccountAndContactPermissionsByTerrUser(Trigger.New);
        }
    }
}