/**
 * Created by YuriiDyvak on 22.07.2019.
 */

@isTest
public with sharing class EmailSendingTest {

    @isTest
    public static void emailSendingWhenInsertTest() {

        EmailSending mock = (EmailSending) MockUtil.createMock(EmailSending.class);

        EmailSendingService service = new EmailSendingService();
        service.setMock(mock);
        System.assertEquals(true, service.sendEmailWhenAccountContactInsert());
    }

    @isTest
    public static void emailSendingWhenUpdateTest() {

        EmailSending mock = (EmailSending) MockUtil.createMock(EmailSending.class);

        EmailSendingService service = new EmailSendingService();
        service.setMock(mock);
        System.assertEquals(true, service.sendEmailWhenAccountContactUpdate());
    }

    @isTest
    public static void emailSendingEmailMethodTest() {

        EmailSending emailSending = new EmailSending();
        Object obj = emailSending.email();

        System.assert(obj instanceOf EmailSending.EmailBuilder);
    }
}