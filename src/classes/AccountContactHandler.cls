/**
 * Created by YuriiDyvak on 11.07.2019.
 */

public without sharing class AccountContactHandler {

    public class UpdatePrimaryWorkPlaceHandler extends TriggerHandler {

        public override void afterInsert(List<SObject> newList) {
            PrimaryWorkPlaceService primaryWorkPlaceService = new PrimaryWorkPlaceService();
            primaryWorkPlaceService.insertPrimaryWorkPlace(newList);
            EmailSendingService emailSendingService = new EmailSendingService();
            emailSendingService.sendEmailWhenAccountContactInsert();
        }

        public override void afterUpdate(List<SObject> newList) {
            PrimaryWorkPlaceService primaryWorkPlaceService = new PrimaryWorkPlaceService();
            primaryWorkPlaceService.updatePrimaryWorkPlace(newList);
            EmailSendingService emailSendingService = new EmailSendingService();
            emailSendingService.sendEmailWhenAccountContactUpdate();
        }

        public override void afterDelete(List<SObject> oldList) {
            PrimaryWorkPlaceService primaryWorkPlaceService = new PrimaryWorkPlaceService();
            primaryWorkPlaceService.deletePrimaryWorkPlace(oldList);
        }
    }

}