/**
 * Created by Dyvak Yurii on 06/16/2019.
 */


public with sharing class OrderDataTableController {

    @AuraEnabled
    public static List<OrderItemRecord> getProducts() {
        return new ProductRecordGetter().getProductRecords();
    }

    @AuraEnabled
    public static List<OrderItemRecord> updateQuantities(String products) {
        List<OrderItemRecord> orderItemRecords = (List<OrderItemRecord>) JSON.deserialize(products, List<OrderItemRecord>.class);
        OrderItemsService orderItemsService = new OrderItemsService();
        orderItemsService.updateOrderItems(orderItemRecords);
        return new ProductRecordGetter().getProductRecords();
    }

    class OrderItemsService {

        private void updateOrderItems(List<OrderItemRecord> orderItemRecords) {
            Id userId = UserInfo.getUserId();

            List<Order> orders = this.getOrders(userId);
            if (!orders.isEmpty()) {
                Order order = orders.get(0);
                for (OrderItemRecord item : orderItemRecords) {
                    List<OrderItem> orderItems = this.getOrderItems(order.Id, item.productId);
                    if (!orderItems.isEmpty()) {
                        OrderItem orderItem = orderItems.get(0);
                        orderItem.Quantity = item.quantity;
                        update orderItem;
                    }
                }
            }
        }

        private List<Order> getOrders(String userId) {
            return [
                    SELECT Id
                    FROM Order
                    WHERE Name = :userId
                    AND isPerformed__c = false
            ];
        }

        private List<OrderItem> getOrderItems(String orderId, String productId) {
            return [
                    SELECT Id
                    FROM OrderItem
                    WHERE OrderId = :orderId
                    AND Product2Id = :productId
            ];
        }
    }

    class ProductRecordGetter {

        public List<OrderItemRecord> getProductRecords() {
            Id userId = UserInfo.getUserId();
            List<OrderItemRecord> result = new List<OrderItemRecord>();
            List<Order> orders = this.getOrders(userId);
            if (!orders.isEmpty()) {
                Order order = orders.get(0);

                List<OrderItem> orderItems = this.getOrderItems(order.Id);
                for (OrderItem orderItem : orderItems) {
                    Product2 product = this.getProduct(orderItem.Product2Id);
                    result.add(new OrderItemRecord(product.Name, product.Id, orderItem.Quantity));
                }
            }
            return result;
        }

        private List<Order> getOrders(String userId) {
            return [
                    SELECT Id
                    FROM Order
                    WHERE Name = :userId
                    AND isPerformed__c = false
            ];
        }

        private List<OrderItem> getOrderItems(String orderId) {
            return [
                    SELECT Id, Product2Id, Quantity
                    FROM OrderItem
                    WHERE OrderId = :orderId
            ];
        }

        private Product2 getProduct(String productId) {
            return [
                    SELECT Id, Name, Price__c, Image_128_128__c, Description, Quantity__c
                    FROM Product2
                    WHERE Product2.Id = :productId
            ];
        }
    }

    class OrderItemRecord {

        @AuraEnabled
        public String product {
            get;
            set;
        }

        @AuraEnabled
        public String productId {
            get;
            set;
        }

        @AuraEnabled
        public Decimal quantity {
            get;
            set;
        }

        public OrderItemRecord(String product, String productId, Decimal quantity) {
            this.product = product;
            this.productId = productId;
            this.quantity = quantity;
        }
    }
}