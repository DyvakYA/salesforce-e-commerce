/**
 * Created by dyvakyurii on 25.06.19.
 */

trigger AccountTrigger on Account (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            TerrUserHandler.setAccountAndContactPermissionsByAccount(Trigger.new);
        }
        if (Trigger.isUpdate) {
            // TerrUserHandler.setAccountAndContactPermissionsByAccount(Trigger.new);
        }
    }
}