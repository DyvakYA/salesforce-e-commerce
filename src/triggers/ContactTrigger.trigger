/**
 * Created by dyvakyurii on 26.06.19.
 */

trigger ContactTrigger on Contact (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            ContactHandler.onAfterInsert(Trigger.New);
        }
        if (Trigger.isUpdate) {
            ContactHandler.onAfterUpdate(Trigger.New);
        }
    }
}