/**
 * Created by Vladimir on 18.06.2019.
 */

public with sharing class TabSetController {

    @AuraEnabled
    public static List<ProductRecord> getLaptops() {
        return new ProductRecordGetter().getProductRecords('Laptop');
    }

    @AuraEnabled
    public static List<ProductRecord> getOthers() {
        return new ProductRecordGetter().getProductRecords('Other');
    }

    class ProductRecordGetter {

        public List<ProductRecord> getProductRecords(String category) {
            List<ProductRecord> result = new List<ProductRecord>();

            List<Product2> products = this.getProducts(category);
            for (Product2 product : products) {
                result.add(new ProductRecord(product));
            }

            return result;
        }

        private List<Product2> getProducts(String category) {
            return [
                    SELECT Id, Name, Price__c, Image_128_128__c, Description, Quantity__c, Family
                    FROM Product2
                    WHERE Family = :category
                    LIMIT 12
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