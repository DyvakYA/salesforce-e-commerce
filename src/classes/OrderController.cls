/**
 * Created by dyvakyurii on 19.06.19.
 */

@SuppressWarnings('ApexUnresolvableReference')
public with sharing class OrderController {

    @AuraEnabled
    public static void perform() {

        // make order isPerformed__c = true
        Id userId = UserInfo.getUserId();
        List<Order> newOrders = [SELECT Id FROM Order WHERE Name = :userId AND isPerformed__c = false];
        for (Order order : newOrders) {
            order.isPerformed__c = true;

            OrderItem orderItem = [SELECT Id, OrderId, Product2Id, Quantity FROM OrderItem WHERE OrderId = :order.Id];
            Product2 product = [SELECT Id, Name, Quantity__c FROM Product2 WHERE Id = :orderItem.Product2Id];
            Decimal quantity = product.Quantity__c - orderItem.Quantity;
            if (quantity < 0) {
                quantity = 5;
            }
            product.Quantity__c = quantity;
            update product;

        }
        update newOrders;
    }
}