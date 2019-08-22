/**
 * Created by YuriiDyvak on 15.08.2019.
 */

trigger TrackTimeTrigger on TrackTime__c (before insert, before update, before delete, after insert, after update, after delete) {
    TriggerHandlerExecutor.execute(TrackTimeHandler.UpdateSpendTimeHandler.class);
}