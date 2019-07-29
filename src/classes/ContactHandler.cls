/**
 * Created by dyvakyurii on 28.06.19.
 */

public with sharing class ContactHandler {

    public static SharingService sharingService = new SharingService();

    public static void onAfterInsert(List<Contact> contacts) {
        sharingService.shareAccountsAndContactsByContact(contacts);
    }

    public static void onAfterUpdate(List<Contact> contacts) {
        sharingService.shareAccountsAndContactsByContact(contacts);
    }

}