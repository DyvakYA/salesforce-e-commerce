/**
 * Created by YuriiDyvak on 26.07.2019.
 */

public class ScrumSprintService {

    public List<Sprint__c> getSprintsForProject(String id) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Sprint__c.getSobjectType()) ;
        return (List<Sprint__c>) selector.queryBuilder()
                .querySelect()
                .queryFields('Id, Name, Date_finish__c, Project__c, Start_Day__c, Total_Estimate__c, Type__c')
                .queryFrom(Sprint__c.getSObjectType())
                .queryWhere('Project__c', id)
                .execute();
    }
}
