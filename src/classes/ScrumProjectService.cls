/**
 * Created by YuriiDyvak on 26.07.2019.
 */

public class ScrumProjectService {

    public Project__c getProject(String id) {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Project__c.getSObjectType());
        return (Project__c) selector.findById(id);
    }

    public List<Project__c> getProjects() {
        UniversalSelector selector = (UniversalSelector) Application.Selector.get(Project__c.getSObjectType());
        return (List<Project__c>) selector.findAll();
    }
}