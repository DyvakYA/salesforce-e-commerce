/**
 * Created by Vladimir on 19.06.2019.
 */

public with sharing class AdminOrderDataTableController {
    
    @AuraEnabled
    public static void deleteAllOrders() {

        Order[] orders = [SELECT Id, Status FROM Order
        WHERE Status = 'Draft'];
        try {
            delete orders;
        } catch (DmlException e) {
           System.debug(e);
        }
    }
}