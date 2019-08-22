/**
 * Created by YuriiDyvak on 08.08.2019.
 */

public  class ScrumBacklogController {

    @AuraEnabled
    public static void deleteBacklog(String backlogId) {
        ScrumBacklogService service = (ScrumBacklogService) Application.Service.get(ScrumBacklogService.class);
        service.deleteById(backlogId);
    }
}