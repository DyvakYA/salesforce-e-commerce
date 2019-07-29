/**
 * Created by YuriiDyvak on 11.07.2019.
 */

@isTest
public with sharing class PrimaryWorkPlaceServiceTest {

    @isTest(SeeAllData=true)
    static void testWhenInsert() {

        // given
        List<AccountContact__c> insertedList = new List<AccountContact__c>();
        AccountContact__c item = new AccountContact__c(Account__c = '0012p00002OXYXvAAP', Contact__c = '0032p00002TnGpoAAF');
        item.Name = 'NewName';
        //insert item;
        insertedList.add(item);

        // when
        Test.startTest();
//        PrimaryWorkPlaceService primaryWorkPlaceService = new PrimaryWorkPlaceService();
//        primaryWorkPlaceService.insertPrimaryWorkPlace(alist);
        insert insertedList;
        Test.stopTest();

        // then
        AccountContact__c result = [SELECT Id, isPrimary__c FROM AccountContact__c WHERE Name = 'NewName' LIMIT 1];
        System.debug(result);
        System.assert(result.isPrimary__c);

    }

    @isTest(SeeAllData=true)
    static void testWhenUpdate() {

        Test.startTest();
        // given
        List<AccountContact__c> accountContacts = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        System.debug(accountContacts);
        AccountContact__c accountContact;
        if (!accountContacts.isEmpty()) {
            accountContact = accountContacts.get(0);
        }

        // when

        update new AccountContact__c(Id = accountContact.Id, isPrimary__c = false);
        Test.stopTest();

        // then
        List<AccountContact__c> accountContacts2 = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        System.assert(accountContacts2.size() == 1);
    }

    @isTest(SeeAllData=true)
    static void testWhenDelete() {

        Test.startTest();
        // given
        List<AccountContact__c> accountContacts = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        System.debug(accountContacts);
        AccountContact__c accountContact;
        if (!accountContacts.isEmpty()) {
            accountContact = accountContacts.get(0);
        }

        // when
        delete accountContact;
        Test.stopTest();

        // then
        List<AccountContact__c> accountContacts2 = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        System.assert(accountContacts2.size() == 1);
    }

    @isTest
    static void testWhenDeleteLast() {

        Test.startTest();

        // given
        AccountContact__c accountContact = new AccountContact__c(isPrimary__c = true);
        insert accountContact;

        // when
        delete accountContact;
        Test.stopTest();

        // then
        List<AccountContact__c> accountContacts2 = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        System.assert(accountContacts2.size() == 0);
    }

    @isTest(SeeAllData=true)
    static void testWhenChangeAllPrimaryWorkPlaces() {

        Test.startTest();

        List<AccountContact__c> listForUpdate = new List<AccountContact__c>();
        // given
        List<AccountContact__c> accountContacts = [SELECT Id, isPrimary__c FROM AccountContact__c];
        System.debug(accountContacts);
        if (!accountContacts.isEmpty()) {
            for (AccountContact__c item : accountContacts) {
                if (item.isPrimary__c == true) {
                    listForUpdate.add(new AccountContact__c(Id = item.Id, isPrimary__c = false));
                }

                if (item.isPrimary__c == false) {
                    listForUpdate.add(new AccountContact__c(Id = item.Id, isPrimary__c = true));
                }
            }
        }

        // when
        System.debug(listForUpdate);
        update listForUpdate;
        Test.stopTest();

        // then
        List<AccountContact__c> accountContacts2 = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];

        System.assert(accountContacts2.size() == 1);
    }

    @isTest(SeeAllData=true)
    static void clearPrimaryFieldsTest() {
        Test.startTest();
        // given
        List<AccountContact__c> accountContacts = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];


        // when
        new PrimaryWorkPlaceService().clearPrimaryList();
        Test.stopTest();

        // then
        List<AccountContact__c> accountContacts2 = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        System.assert(accountContacts.size() > accountContacts2.size());
    }

    @isTest(SeeAllData=true)
    static void checkIfPrimaryFieldsUpdatedTest() {
        Test.startTest();
        // given
        List<AccountContact__c> accountContacts = [SELECT Id, isPrimary__c FROM AccountContact__c WHERE isPrimary__c = true];
        System.debug(accountContacts);
        AccountContact__c accountContact;
        if (!accountContacts.isEmpty()) {
            accountContact = accountContacts.get(0);
        }

        List<AccountContact__c> oldList = new List<AccountContact__c>();
        oldList.add(accountContact);

        List<AccountContact__c> newList = new List<AccountContact__c>();
        // accountContact.isPrimary__c = false;
        newList.add(new AccountContact__c(Id = accountContact.Id, isPrimary__c = false));

        // when
        System.debug(oldList);
        System.debug(newList);
        List<AccountContact__c> result = new PrimaryWorkPlaceService().checkIfIsPrimaryFieldUpdated(oldList, newList);
        Test.stopTest();

        // then
        System.assert(result.size() == 1);
    }

    @isTest(SeeAllData=true)
    static void checkIfPrimaryFieldsNotUpdatedTest() {
        Test.startTest();
        // given
        List<AccountContact__c> accountContacts = [SELECT Id, isPrimary__c FROM AccountContact__c];
        // when
        List<AccountContact__c> result = new PrimaryWorkPlaceService().checkIfIsPrimaryFieldUpdated(accountContacts, accountContacts);
        Test.stopTest();
        System.debug(result);
        // then
        System.assert(result.size() == 0);
    }

    @isTest(SeeAllData=true)
    static void checkIfPrimaryFieldsUpdatedAllListOfRecordsTest() {
        Test.startTest();
        // given
        List<AccountContact__c> listForUpdate = new List<AccountContact__c>();
        // given
        List<AccountContact__c> accountContacts = [SELECT Id, isPrimary__c FROM AccountContact__c];
        System.debug(accountContacts);
        if (!accountContacts.isEmpty()) {
            for (AccountContact__c item : accountContacts) {
                if (item.isPrimary__c == true) {
                    listForUpdate.add(new AccountContact__c(Id = item.Id, isPrimary__c = false));
                }

                if (item.isPrimary__c == false) {
                    listForUpdate.add(new AccountContact__c(Id = item.Id, isPrimary__c = true));
                }
            }
        }

        // when
        System.debug(listForUpdate);
        List<AccountContact__c> result = new PrimaryWorkPlaceService().checkIfIsPrimaryFieldUpdated(accountContacts, listForUpdate);
        Test.stopTest();
        System.debug(result);
        // then
        System.assert(result.size() == 5);
    }

    @isTest
    static void testIFIsPrimaryFalseLast() {
        Test.startTest();
        // given
        AccountContact__c accountContact = new AccountContact__c();
        insert accountContact;
        // when
        update new AccountContact__c(Id = accountContact.Id, isPrimary__c = false);
        Test.stopTest();
        List<AccountContact__c> result = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        // then
        System.assert(result.size() == 1);
    }

    @isTest(SeeAllData=true)
    static void testIfDeleteElementAndPreviousElementIsNone() {
        Test.startTest();

        // given
        AccountContact__c accountContact2;

        List<AccountContact__c> accountContacts = [SELECT Id, isPrimary__c, CreatedDate FROM AccountContact__c];
        if (!accountContacts.isEmpty()) {

            Datetime attachCreatedDate = null;
            Id attachId = null;
            for (AccountContact__c accountContact : accountContacts) {

                if (attachCreatedDate == null || accountContact.CreatedDate < attachCreatedDate) {
                    attachCreatedDate = accountContact.CreatedDate;
                    attachId = accountContact.Id;
                }
            }
            accountContact2 = new AccountContact__c(Id = attachId, isPrimary__c = true);
            update accountContact2;
        }

        // when
        delete accountContact2;

        Test.stopTest();

        List<AccountContact__c> result = [SELECT Id FROM AccountContact__c WHERE isPrimary__c = true];
        // then
        System.assert(result.size() == 1);
    }
}