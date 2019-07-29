/**
 * Created by dyvakyurii on 17.06.19.
 */

public with sharing class ProductCardController {

    @AuraEnabled
    public static void getOrder(String product) {

        Product2 product1 = (Product2) JSON.deserialize(product, Product2.class);

        OrderRecordSetter setter = new OrderRecordSetter();
        setter.createOrderRecords(product1);
    }

    class OrderRecordSetter {

        public void createOrderRecords(Product2 product) {
            // get current user id from user info
            Id userId = UserInfo.getUserId();

            // get partner account
            Account account = this.getNewPartnerAccount();

            // First insert a price for the standard price book
            Pricebook2 standardPB = this.getStandardPB();

            PricebookEntry standardPBE = this.getStandardPBEorCreate(standardPB, product);

            // get order from db or create new
            Order order = this.getOrderOrCreate(userId, account, standardPB);

            List<OrderItem> orderItems = this.getOrderItems(order, product);

            OrderItem orderItem;
            if (!orderItems.isEmpty()) {
                orderItem = orderItems.get(0);
                orderItem.Quantity = orderItem.Quantity + 1;
                update orderItem;
            } else {
                // create order item
                orderItem = new OrderItem(OrderId = order.Id, Product2Id = product.Id, Quantity = 1, UnitPrice = product.Price__c, PricebookEntryId = standardPBE.Id);
                insert orderItem;
            }
        }

        private PricebookEntry getStandardPBEorCreate(Pricebook2 standardPB, Product2 product) {
            List<PricebookEntry> standardPBEList = this.getStandardPBEList(standardPB, product);

            // get from db or create new standard PBE
            PricebookEntry standardPBE;
            if (standardPBEList.isEmpty()) {
                standardPBE = new PricebookEntry(Pricebook2Id = standardPB.Id, Product2Id = product.Id, UnitPrice = 1000, IsActive = true);
                insert standardPBE;
            } else {
                standardPBE = standardPBEList.get(0);
            }
            return standardPBE;
        }

        private Order getOrderOrCreate(String userId, Account account, Pricebook2 standardPB) {
            List<Order> orders = this.getNotPerformedOrders(userId);
            Order order;
            if (orders.isEmpty()) {
                order = new Order(name = userId, EffectiveDate = system.today(), AccountId = account.Id, status = 'draft', Pricebook2Id = standardPB.Id);
                insert order;
            } else {
                order = orders.get(0);
            }
            return order;
        }


        private Account getNewPartnerAccount() {
            return [
                    SELECT Id, Name
                    FROM Account
                    WHERE Name = 'NewPartner'
            ];
        }

        private List<PricebookEntry> getStandardPBEList(PriceBook2 standardPB, Product2 product) {
            return [
                    SELECT Id
                    FROM PricebookEntry
                    WHERE Pricebook2Id = :standardPB.Id
                    AND Product2Id = :product.Id
                    LIMIT 1
            ];
        }

        private List<OrderItem> getOrderItems(Order order, Product2 product) {
            return [
                    SELECT Id, Quantity
                    FROM OrderItem
                    WHERE OrderId = :order.Id
                    AND Product2Id = :product.Id
                    LIMIT 1
            ];
        }

        private Pricebook2 getStandardPB() {
            return [
                    SELECT id
                    FROM Pricebook2
                    WHERE isStandard = true
            ];
        }

        private List<Order> getNotPerformedOrders(String userId) {
            return [
                    SELECT Id
                    FROM Order
                    WHERE Name = :userId
                    AND isPerformed__c = false
            ];
        }


    }

    class AccountRecord {

        @AuraEnabled
        public Account sobj;

        public AccountRecord(Account sobj) {
            this.sobj = sobj;

        }
    }
}