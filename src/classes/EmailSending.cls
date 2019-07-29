/**
 * Created by YuriiDyvak on 22.07.2019.
 */

public class EmailSending {

    public  EmailBuilder email() {
        return new EmailBuilder();
    }

    public class EmailBuilder {

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();

        private List<String> toMail = new List<String>();
        private List<String> ccMail = new List<String>();

        public EmailBuilder to(String to) {
            toMail.add(to);
            email.setToAddresses(toMail);
            return this;
        }

        public EmailBuilder cc(String cc) {
            ccMail.add(cc);
            email.setToAddresses(ccMail);
            return this;
        }

        public EmailBuilder rep(String rep) {
            email.setReplyTo(rep);
            return this;
        }

        public EmailBuilder subject(String subject) {
            email.setSubject(subject);
            return this;
        }

        public EmailBuilder body(String body) {
            email.setHtmlBody(body);
            return this;
        }

        public boolean send() {
            try {
                Messaging.sendEmail(new Messaging.SingleEmailMessage[]{
                        email
                });
                return true;
            } catch (exception e) {
                apexpages.addmessage(new apexpages.message(apexpages.severity.error, e.getMessage()));
                return false;
            }
        }
    }
}