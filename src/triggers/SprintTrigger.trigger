/**
 * Created by YuriiDyvak on 15.08.2019.
 */

trigger SprintTrigger on Sprint__c (after update, after insert) {
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            TriggerHandlerExecutor.execute(SprintHandler.UpdateSprintHandler.class);
        }
        if(Trigger.isInsert){
            TriggerHandlerExecutor.execute(SprintHandler.UpdateSprintHandler.class);
        }
    }

}