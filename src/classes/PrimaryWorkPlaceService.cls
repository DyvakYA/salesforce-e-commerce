/**
 * Created by YuriiDyvak on 11.07.2019.
 */

public with sharing class PrimaryWorkPlaceService {

    public void insertPrimaryWorkPlace(List<AccountContact__c> accountContacts) {

        Set<Id> ids = new Set<Id>();
        for (AccountContact__c accountContact : accountContacts) {
            ids.add(accountContact.Contact__c);
        }

        List<AccountContact__c> primaryAccountContacts = new AccountContactSelector()
                .getPrimaryAccountContactsByIds(ids);
        for (AccountContact__c item : primaryAccountContacts) {
            item.isPrimary__c = false;
        }

        List<AccountContact__c> result = new List<AccountContact__c>();
        for (AccountContact__c item : accountContacts) {

            // AccountContact__c accountContact = new AccountContact__c(Id = item.Id);
            item.isPrimary__c = true;
            result.add(item);
        }

        // insert records
        TriggerHandlerExecutor.bypassHandler(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
        update primaryAccountContacts;
        update result;
        TriggerHandlerExecutor.clearBypass(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
    }

    public void updatePrimaryWorkPlace(List<AccountContact__c> accountContacts) {

        // STEP #1 check if aou field isPrimary updated
        List<AccountContact__c> updated = this.checkIfIsPrimaryFieldUpdated(Trigger.old, accountContacts);

        // Execute method
        List<AccountContact__c> recordsForUpdating = executeUpdating(updated);

        // set all accountContact isPrimary field to false
        clearPrimaryList();

        // update records
        TriggerHandlerExecutor.bypassHandler(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
        update recordsForUpdating;
        TriggerHandlerExecutor.clearBypass(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
    }

    public void deletePrimaryWorkPlace(List<AccountContact__c> accountContacts) {

        List<AccountContact__c> recordsForUpdate = new List<AccountContact__c>();

        AccountContact__c accountContact = accountContacts.get(0);
        if (accountContact.isPrimary__c == true) {
            List<AccountContact__c> previousAccountContacts = new AccountContactSelector()
                    .getPreviousAccountContact(accountContact);
            if (!previousAccountContacts.isEmpty()) {
                AccountContact__c previousAccountContact = previousAccountContacts.get(0);
                previousAccountContact.isPrimary__c = true;
                recordsForUpdate.add(previousAccountContact);
            } else {
                System.debug(accountContact);
                List<AccountContact__c> allAccountContacts = new AccountContactSelector()
                        .getAccountContactsWithoutOne(accountContact.Id);
                System.debug(allAccountContacts);
                if (!allAccountContacts.isEmpty()) {
                    AccountContact__c previousAccountContact = allAccountContacts.get(0);
                    recordsForUpdate.add(new AccountContact__c(Id = previousAccountContact.Id, isPrimary__c = true));
                }
            }
        }

        // update records
        TriggerHandlerExecutor.bypassHandler(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
        update recordsForUpdate;
        TriggerHandlerExecutor.clearBypass(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
    }

    public List<AccountContact__c> executeUpdating(List<AccountContact__c> accountContacts) {

        // STEP #2 divide existing list by isPrimary field
        List<AccountContact__c> isPrimaryFalseList = new List<AccountContact__c>();
        List<AccountContact__c> isPrimaryTrueList = new List<AccountContact__c>();

        for (AccountContact__c accountContact : accountContacts) {
            if (accountContact.isPrimary__c == false) {
                isPrimaryFalseList.add(accountContact);
            }

            if (accountContact.isPrimary__c == true) {
                isPrimaryTrueList.add(accountContact);
            }
        }

        // list for updating records
        List<AccountContact__c> recordsForUpdating = new List<AccountContact__c>();

        // STEP #3 make manipulation for list where isPrimary = false
        if (!isPrimaryFalseList.isEmpty()) {
            AccountContact__c accountContact = isPrimaryFalseList.get(0);
            List<AccountContact__c> previousAccountContacts = new AccountContactSelector()
                    .getPreviousAccountContact(accountContact);
            if (!previousAccountContacts.isEmpty()) {
                AccountContact__c item = previousAccountContacts.get(0);
                item.isPrimary__c = true;
                recordsForUpdating.add(item);
            } else {
                AccountContact__c accountContact2 = new AccountContact__c(Id = accountContact.Id, isPrimary__c = true);
                recordsForUpdating.add(accountContact2);
            }
        }

        // STEP #4 make manipulation for list where isPrimary = true
        if (!isPrimaryTrueList.isEmpty()) {

            Datetime attachCreatedDate = null;
            Id attachId = null;
            for (AccountContact__c accountContact : isPrimaryTrueList) {

                if (attachCreatedDate == null || accountContact.CreatedDate > attachCreatedDate) {
                    attachCreatedDate = accountContact.CreatedDate;
                    attachId = accountContact.Id;
                }
            }
            AccountContact__c accountContact2 = new AccountContact__c(Id = attachId, isPrimary__c = true);
            recordsForUpdating.clear();
            recordsForUpdating.add(accountContact2);
        }

        return recordsForUpdating;
    }


    @TestVisible
    private void clearPrimaryList() {
        List<AccountContact__c> items = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        for (AccountContact__c item : items) {
            item.isPrimary__c = false;
        }

        TriggerHandlerExecutor.bypassHandler(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
        update items;
        TriggerHandlerExecutor.clearBypass(AccountContactHandler.UpdatePrimaryWorkPlaceHandler.class);
    }

    @TestVisible
    private List<AccountContact__c> checkIfIsPrimaryFieldUpdated(List<AccountContact__c> oldAccountContacts, List<AccountContact__c> newAccountContacts) {

        List<AccountContact__c> isPrimaryFieldUpdated = new List<AccountContact__c>();
        for (AccountContact__c oldAccountContact : oldAccountContacts) {

            for (AccountContact__c newAccountContact : newAccountContacts) {
                if (newAccountContact.Id == oldAccountContact.Id && newAccountContact.isPrimary__c != oldAccountContact.isPrimary__c) {
                    isPrimaryFieldUpdated.add(newAccountContact);
                    System.debug(newAccountContact);
                }
            }
        }
        return isPrimaryFieldUpdated;
    }

    private class AccountContactSelector {

        public List<AccountContact__c> getPreviousAccountContact(AccountContact__c accountContact) {
            return [
                    SELECT Id, isPrimary__c, CreatedDate
                    FROM AccountContact__c
                    WHERE CreatedDate < :accountContact.CreatedDate
                    ORDER BY CreatedDate DESC
                    LIMIT 1
            ];
        }

        public List<AccountContact__c> getPrimaryAccountContactsByIds(Set<Id> ids) {
            return [
                    SELECT Id
                    FROM AccountContact__c
                    WHERE Contact__c = :ids
                    AND isPrimary__c = TRUE
            ];
        }

        public List<AccountContact__c> getAccountContactsWithoutOne(Id id) {
            return [
                    SELECT Id
                    FROM AccountContact__c
                    WHERE Id != :id
                    ORDER BY CreatedDate DESC
            ];
        }
    }
}