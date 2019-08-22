/**
 * Created by YuriiDyvak on 15.08.2019.
 */

public with sharing class TrackTimeHandler {

    public class UpdateSpendTimeHandler extends TriggerHandler {

        public override void afterInsert(List<SObject> newList) {

            ScrumSubtaskService scrumSubtaskService = (ScrumSubtaskService) Application.Service.get(ScrumSubtaskService.class);
            scrumSubtaskService.updateSubtaskSpendTime(newList);

            //ScrumTaskService scrumTaskService = (ScrumTaskService) Application.Service.get(ScrumTaskService.class);
            //scrumTaskService.updateTaskSpendTime(newList);

            ScrumSprintService scrumSprintService = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
            scrumSprintService.updateSpendTime(newList);
        }

        public override void afterUpdate(List<SObject> newList) {
            ScrumSubtaskService scrumSubtaskService = (ScrumSubtaskService) Application.Service.get(ScrumSubtaskService.class);
            scrumSubtaskService.updateSubtaskSpendTime(newList);

            ScrumTaskService scrumTaskService = (ScrumTaskService) Application.Service.get(ScrumTaskService.class);
            scrumTaskService.updateTaskSpendTime(newList);

            ScrumSprintService scrumSprintService = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
            scrumSprintService.updateSpendTime(newList);
        }

        public override void afterDelete(List<SObject> newList) {
            ScrumSubtaskService scrumSubtaskService = (ScrumSubtaskService) Application.Service.get(ScrumSubtaskService.class);
            scrumSubtaskService.updateSubtaskSpendTime(newList);

//            ScrumTaskService scrumTaskService = (ScrumTaskService) Application.Service.get(ScrumTaskService.class);
//            scrumTaskService.updateTaskSpendTime(newList);

            ScrumSprintService scrumSprintService = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
            scrumSprintService.updateSpendTime(newList);
        }
    }

}