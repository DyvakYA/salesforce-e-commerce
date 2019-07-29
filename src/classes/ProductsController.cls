/**
 * Created by Dyvak Yurii on 06/14/2019.
 */

public with sharing class ProductsController {

    @AuraEnabled
    public static List<ProductRecord> getProducts() {
        return new ProductRecordGetter().getProductRecords();
    }

    class ProductRecordGetter {

        public List<ProductRecord> getProductRecords() {
            List<ProductRecord> result = new List<ProductRecord>();

            List<Product2> products = this.getProducts();
            for (Product2 product : products) {
                result.add(new ProductRecord(product));
            }

            return result;
        }

        private List<Product2> getProducts() {
            return [
                    SELECT Id, Name, Price__c, Image_128_128__c, Description, Quantity__c, Family
                    FROM Product2
                    LIMIT 10
            ];
        }
    }

    class ProductRecord {

        @AuraEnabled
        public Product2 sobj;

        public ProductRecord(Product2 sobj) {
            this.sobj = sobj;
        }
    }
}