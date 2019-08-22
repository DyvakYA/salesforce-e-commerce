/**
 * Created by YuriiDyvak on 24.07.2019.
 */

public class EmailSendingService {

    private EmailSending emailSending = new EmailSending();

    public void setMock(EmailSending mock) {
        this.emailSending = mock;
    }

    public boolean sendEmailWhenAccountContactInsert() {
        return emailSending.email()
                .to(UserInfo.getUserEmail())
                .cc(UserInfo.getUserEmail())
                .rep('salesforce@gmail.com')
                .subject('Object inserted')
                .body('Object inserted')
                .send();
    }

    public boolean sendEmailWhenAccountContactUpdate() {

        return emailSending.email()
                .to(UserInfo.getUserEmail())
                .cc(UserInfo.getUserEmail())
                .rep('salesforce@gmail.com')
                .subject('Object updated')
                .body('Object updated')
                .send();
    }
}