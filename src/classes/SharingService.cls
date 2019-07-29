/**
 * Created by dyvakyurii on 25.06.19.
 */

@SuppressWarnings('ApexUnresolvableReference')
public with sharing class SharingService {


    public void shareAccountsAndContactsByTerrUser(TerrUser__c terrUser) {

        String id = terrUser.Territory__c;

        List<Territory__c> territories = [SELECT Id FROM Territory__c WHERE Id = :id];

        List<Territory__c> terr;
        if (!territories.isEmpty()) {
            //List<Territory__c> all = [SELECT Id, Territory__c FROM Territory__c];
            //getTerritoryHierarchyList(all, territories.get(0), 3);
            terr = this.getTerritoryHierarchyListOld(territories.get(0));
        }

        Set<Account> accounts = new Set<Account>();
        for (Territory__c territory : terr) {
            accounts.addAll([SELECT Id FROM Account WHERE Territory__c = :territory.Id]);
        }

        List<AccountShare> accountShares = new List<AccountShare>();
        List<ContactShare> contactShares = new List<ContactShare>();

        accountShares.addAll(makeAccountShares(accounts, terrUser.User__c));
        for (AccountShare accountShare : accountShares) {

            List<Reference__c> references = [SELECT Id, Contact__c FROM Reference__c WHERE Account__c = :accountShare.AccountId];
            if (!references.isEmpty()) {
                Set<Id> contactIds = new Set<Id>();
                for (Reference__c reference : references) {
                    contactIds.add(reference.Contact__c);
                }
                List<Contact> contacts = [SELECT Id FROM Contact WHERE Id = :contactIds];
                List<ContactShare> shares = makeContactShares(contacts, terrUser.User__c);
                contactShares.addAll(shares);
            }
        }

        this.deleteOldAccountShare(terrUser.User__c);
        insert accountShares;
        this.deleteOldContactShare(terrUser.User__c);
        insert contactShares;
    }

    private List<AccountShare> makeAccountShares(Set<Account> accounts, String userId) {
        List<AccountShare> accountShares = new List<AccountShare>();
        for (Account account : accounts) {
            AccountShare accountShare = new AccountShare();
            accountShare.AccountId = account.Id;
            accountShare.UserOrGroupId = userId;
            accountShare.AccountAccessLevel = 'Edit';
            accountShare.OpportunityAccessLevel = 'Edit';
            accountShare.RowCause = 'Manual';
            accountShares.add(accountShare);
        }
        return accountShares;
    }

    private List<ContactShare> makeContactShares(List<Contact> contacts, String userId) {

        List<ContactShare> contactShares = new List<ContactShare>();
        for (Contact contact : contacts) {
            ContactShare contactShare = new ContactShare();
            contactShare.ContactId = contact.Id;
            contactShare.UserOrGroupId = userId;
            contactShare.ContactAccessLevel = 'Edit';
            contactShare.RowCause = 'Manual';
            contactShares.add(contactShare);
        }
        return contactShares;
    }

    public void shareAccountsAndContactsByAccount(Account account) {
        List<Territory__c> territories = [SELECT Id FROM Territory__c WHERE Id = :account.Territory__c];
        if (!territories.isEmpty()) {
            Territory__c territory = territories.get(0);
            List<TerrUser__c> terrUsers = [SELECT Id, Territory__c, User__c FROM TerrUser__c WHERE TerrUser__c.Territory__c = :territory.Id];
            for (TerrUser__c item : terrUsers) {
                this.shareAccountsAndContactsByTerrUser(item);
            }
        }
    }

    public void shareAccountsAndContactsByContact(List<Contact> contacts) {

        Contact contact = contacts.get(0);

        List<Id> ids = new List<Id>();
        for (Reference__c reference : [SELECT Id, Account__c FROM Reference__c WHERE Contact__c = :contact.Id]) {
            ids.add(reference.Account__c);
        }
        for (Account account : [SELECT Id FROM Account WHERE Id = :ids]) {
            shareAccountsAndContactsByAccount(account);
        }
    }

    private void deleteOldAccountShare(String userId) {
        delete [SELECT Id FROM AccountShare WHERE UserOrGroupId = :userId AND RowCause = 'Manual'];
    }

    private void deleteOldContactShare(String userId) {
        delete [SELECT Id FROM ContactShare WHERE UserOrGroupId = :userId AND RowCause = 'Manual'];
    }

    private List<Territory__c> getTerritoryHierarchyListOld(Territory__c territory) {

        List<Territory__c> result = new List<Territory__c>();
        result.add(territory);
        List<Territory__c> territories = [SELECT Id FROM Territory__c WHERE Territory__c = :territory.Id];
        result.addAll(territories);
        for (Territory__c item : territories) {
            List<Territory__c> childs = [SELECT Id FROM Territory__c WHERE Territory__c = :item.Id];
            result.addAll(childs);
        }
        System.debug('Result ' + result);
        return result;
    }
}