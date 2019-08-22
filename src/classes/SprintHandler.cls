/**
 * Created by YuriiDyvak on 15.08.2019.
 */

public with sharing class SprintHandler {

    public class UpdateSprintHandler extends TriggerHandler {

        public override void afterUpdate(List<SObject> newList) {
            ScrumSprintService scrumSprintService = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
            scrumSprintService.recalculateTotalEstimateOfTasks(newList);
            scrumSprintService.isNotPossibleHaveTwoActiveSprints(newList);
        }

        public override void afterInsert(List<SObject> newList) {
            ScrumSprintService scrumSprintService = (ScrumSprintService) Application.Service.get(ScrumSprintService.class);
            scrumSprintService.isNotPossibleHaveTwoActiveSprints(newList);
        }
    }

}