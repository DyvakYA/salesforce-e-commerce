/**
 * Created by YuriiDyvak on 23.07.2019.
 */

public class Application {

    public static final Factory.ServiceFactory Service = new Factory.ServiceFactory(
            new Map<Type, Type>{
                    RecordListComponentService.class => RecordListComponentService.class,
                    FieldSetService.class => FieldSetService.class,
                    ScrumProjectService.class => ScrumProjectService.class,
                    ScrumSprintService.class => ScrumSprintService.class,
                    ScrumBacklogService.class => ScrumBacklogService.class,
                    ScrumSubtaskService.class => ScrumSubtaskService.class,
                    ScrumTrackTimeService.class => ScrumTrackTimeService.class,
                    ScrumTaskService.class => ScrumTaskService.class,
                    OrgIntegrationService.class => OrgIntegrationService.class
            });

    public static final Factory.UtilFactory Util = new Factory.UtilFactory(
            new Map<Type, Type>{
                    SchemaUtil.class => SchemaUtil.class
            });

    public static final Factory.SelectorFactory Selector = new Factory.SelectorFactory(
            new Map<SObjectType, Type>{
                    Account.getSObjectType() => UniversalSelector.class,
                    Contact.getSObjectType() => UniversalSelector.class,
                    Sprint__c.getSObjectType() => UniversalSelector.class,
                    Project__c.getSObjectType() => UniversalSelector.class,
                    Task__c.getSObjectType() => UniversalSelector.class,
                    TrackTime__c.getSObjectType() => UniversalSelector.class,
                    Subtask__c.getSObjectType() => UniversalSelector.class
            });

}