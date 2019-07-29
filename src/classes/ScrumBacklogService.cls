/**
 * Created by YuriiDyvak on 26.07.2019.
 */

public class ScrumBacklogService {

    public List<Task__c> getBacklogs() {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Task__c.getSObjectType());
        return (List<Task__c>) selector.queryBuilder()
                .querySelect()
                .queryFields('Id, Name')
                .queryFrom(Task__c.getSObjectType())
                .queryWhere('Project__c', EqSymbol.IS_NULL)
                .queryLimit(1)
                .execute();
    }
}