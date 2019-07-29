/**
 * Created by YuriiDyvak on 22.07.2019.
 */

@isTest
public with sharing class RecordListComponentControllerTest {

    @TestSetup
    static void setUp() {

        Profile p = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        User user = new User(Alias = 'standt', Email = 'standarduser@testorg.com',
                EmailEncodingKey = 'UTF-8', LastName = 'Testing', LanguageLocaleKey = 'en_US',
                LocaleSidKey = 'en_US', ProfileId = p.Id,
                TimeZoneSidKey = 'America/Los_Angeles', UserName = 'superman@gala.net',
                City = 'Kyiv');
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
    public static void getFieldRecordsTest() {

        Account account = [SELECT Id FROM Account WHERE Name = 'NewAccount'];
        List<RecordListComponentService.FieldRecord> result = RecordListComponentController.getFieldRecords('Account', String.valueOf(account.Id), 'test');
        System.assert(result.size() > 0);
    }


}