/**
 * Created by YuriiDyvak on 17.07.2019.
 */

@isTest
public with sharing class FieldSetServiceTest {

    @TestSetup
    static void setUp() {

        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User user = new User(Alias = 'standt', Email = 'standarduser@testorg.com',
                EmailEncodingKey = 'UTF-8', LastName = 'Testing', LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US', ProfileId = p.Id,
                TimeZoneSidKey = 'America/Los_Angeles', UserName = 'superman@gala.net');
        System.debug(user);

        insert user;
        System.debug(user);

        UserFieldSet__c userFieldSet = new UserFieldSet__c(User__c = user.Id, FieldSet__c = 'test');
        insert userFieldSet;

        UserFieldSet__c currentUserFieldSet = new UserFieldSet__c(User__c = UserInfo.getUserId(), FieldSet__c = 'test');
        insert currentUserFieldSet;

        Account account = new Account(Name = 'NewAccount');
        insert account;
    }

    @isTest
    static void getFieldsSetTest() {

        // when
        FieldSetService service = new FieldSetService();
        FieldSet result = service.getFieldsSet('test', Account.getSObjectType());

        // then
        System.assert(result != null);
    }

    @isTest
    static void getFieldsTest() {

        // when
        FieldSetService service = new FieldSetService();
        // String fieldSetName = service.getFieldSetName();
        List<String> fields = service.getFields('test', Account.getSObjectType());

        // then
        System.assert(fields.size() > 0);
    }

    @isTest
    static void getFieldServiceFieldsTest() {
        FieldSetService service = new FieldSetService();
        FieldSet fieldSet = service.getFieldsSet('test', Account.getSObjectType());
        System.assert(fieldSet != null);
    }

    @isTest
    static void getFieldServiceRecordsTest() {

        FieldSetService service = new FieldSetService();
        // String fieldSetName = service.getFieldSetName();
        FieldSet fieldSet = service.getFieldsSet('test', Account.getSObjectType());
        User user = [Select Id From user where LastName = 'Testing'];
        System.debug(user);
        // List<Account> accounts = new FieldSetService().getFieldsSetRecord(fieldSet, Account.getSObjectType(), user.Id);

        // System.assert(accounts.isEmpty());
    }

    @isTest
    static void getFieldRecordServiceTest() {
        // When
        List<Object> result = new FieldSetService().getFields('test', Account.getSObjectType());

        System.debug(result);

        // Then
        System.assert(!result.isEmpty());
    }

    @isTest
    static void getFieldSetRecordTest() {
        // Given
        FieldSetService service = new FieldSetService();
        // String fieldSetName = service.getFieldSetName();
        Account account = [SELECT Id from Account WHERE Name = 'NewAccount'];

        // When
        FieldSet fieldSet = service.getFieldsSet('test', Account.getSObjectType());
        System.debug(account);
        // List<SObject> result = service.getFieldsSetRecord(fieldSet, account);
        // Then
        // System.assert(!result.isEmpty());
    }

    @isTest
    static void getFieldSetRecordIdWithQuotesTest() {
        FieldSetService service = new FieldSetService();
        FieldSet fieldSet = service.getFieldsSet('test', Account.getSObjectType());
        User user = [Select Id From user where LastName = 'Testing'];
        System.debug(user);
        String userId = '\"' + String.valueOf(user.Id) + '\"';
        //List<Account> result = new FieldSetService().getFieldsSetRecord(fieldSet, Account.getSObjectType(), userId);

        //System.assert(result.isEmpty());
    }


}