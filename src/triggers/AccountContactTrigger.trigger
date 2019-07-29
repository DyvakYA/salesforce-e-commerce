trigger AccountContactTrigger on AccountContact__c (after insert, after update, after delete) {

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            TriggerHandlerExecutor.execute(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
        }

        if (Trigger.isUpdate) {
            TriggerHandlerExecutor.execute(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
        }

        if (Trigger.isDelete) {
            TriggerHandlerExecutor.execute(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
        }
    }
}