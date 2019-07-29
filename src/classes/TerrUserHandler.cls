public with sharing class TerrUserHandler {

    public static void setAccountAndContactPermissionsByTerrUser(List<TerrUser__c> terrUsers) {
        if (!terrUsers.isEmpty()) {
            SharingService service = new SharingService();
            for (TerrUser__c terrUser : terrUsers) {
                service.shareAccountsAndContactsByTerrUser(terrUser);
            }
        }
    }

    public static void setAccountAndContactPermissionsByAccount(List<Account> accounts) {
        if (!accounts.isEmpty()) {
            SharingService service = new SharingService();
            for (Account account : accounts) {
                service.shareAccountsAndContactsByAccount(account);
            }
        }
    }

}