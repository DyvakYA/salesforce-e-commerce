/**
 * Created by dyvakyurii on 25.06.19.
 */

public with sharing class TerritoryService {

    public void checkIfTerritoryIsUnique(List<Territory__c> territories) {

        Territory__c territory = territories.get(0);

        List <Territory__c> terrList = [
                SELECT Name
                FROM Territory__c
                WHERE Name = :territory.Name
                AND Territory__c = :territory.Territory__c
        ];

        territory.Uniq_check__c = true;
        //insert territory;

        if (!terrList.isEmpty()) {
            Trigger.new[0].addError(' Already exists');
        }
    }
}