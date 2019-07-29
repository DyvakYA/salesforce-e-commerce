/**
 * Created by YuriiDyvak on 25.07.2019.
 */
@isTest
public with sharing class FactoryTest {

    @isTest
    public static void serviceFactoryTest() {
        Factory.ServiceFactory Service = new Factory.ServiceFactory(
                new Map<Type, Type>{
                        Account.class => Account.class
                });

        sObject result = (SObject) Service.get(Account.class);

        System.assert(result instanceof Account);
    }

    @isTest
    public static void serviceFactoryMockTest() {
        Factory.ServiceFactory Service = new Factory.ServiceFactory(
                new Map<Type, Type>{
                        Account.class => Account.class
                });

        Service.setMock(new Account(Name = 'NewName'));

        Account result = (Account) Service.get(Account.class);

        System.assert(result.Name.equals('NewName'));
    }

    @isTest
    public static void utilFactoryTest() {
        Factory.UtilFactory Util = new Factory.UtilFactory(
                new Map<Type, Type>{
                        Account.class => Account.class
                });

        sObject result = (SObject) Util.get(Account.class);

        System.assert(result instanceof Account);
    }

    @isTest
    public static void utilFactoryMockTest() {
        Factory.UtilFactory Util = new Factory.UtilFactory(
                new Map<Type, Type>{
                        Account.class => Account.class
                });

        Util.setMock(new Account(Name = 'NewName'));

        Account result = (Account) Util.get(Account.class);

        System.assert(result.Name.equals('NewName'));
    }

    @isTest
    public static void selectorFactoryTest() {
        Factory.SelectorFactory Selector = new Factory.SelectorFactory(
                new Map<sObjectType, Type>{
                        Account.getSObjectType() => UniversalSelector.class
                });

        UniversalSelector sel = (UniversalSelector) Selector.get(Account.getSObjectType());
        Account account = new Account(Name = 'NewAccount');

        sel.save(account);

        List<Account> accounts = [SELECT Id FROM Account WHERE Name = 'NewAccount'];

        System.assert(!accounts.isEmpty());
    }

    @isTest
    public static void selectorFactoryMockTest() {
        Factory.SelectorFactory Selector = new Factory.SelectorFactory(
                new Map<sObjectType, Type>{
                        Account.getSObjectType() => AbstractSelector.class
                });

        Selector.setMock(new UniversalSelector(Contact.getSObjectType()));

        UniversalSelector result = (UniversalSelector) Selector.get(Account.getSObjectType());
        Account account = new Account(Name = 'NewAccount');
        result.save(account);

        result.findById(account.Id);

    }
}