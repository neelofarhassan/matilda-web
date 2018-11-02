package org.unimelb.matilda.service;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.unimelb.matilda.model.User;
import org.unimelb.matilda.model.UserFeedback;

@Service("mailService")
public class MailServiceImpl implements MailService {
 
    @Autowired
    JavaMailSender mailSender;
 
    @Override
    public void sendEmail(User user) {
 
        MimeMessagePreparator preparator = getMessagePreparator(user);
 
        try {
            mailSender.send(preparator);
            System.out.println("Message Send...Hurrey");
        } catch (MailException ex) {
            System.err.println(ex.getMessage());
        }
    }
 
    public void emailUserFeedback(UserFeedback userFeedback) {
    	MimeMessagePreparator preparator = prepareUserFeedbackMessage(userFeedback);
    	mailSender.send(preparator);
    }
    
    private MimeMessagePreparator getMessagePreparator(User user) {
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
 
            public void prepare(MimeMessage mimeMessage) throws Exception {
                mimeMessage.setFrom("matilda.unimelb@gmail.com");
                mimeMessage.setRecipient(Message.RecipientType.TO,
                        new InternetAddress("neelofar.eme@gmail.com"));
                String message = "Dear Neelofar, <br> A new registration request from Matilda is waiting for your approval. <br> <a href=\"http://localhost:8080/spring-mvc-hibernate-example/newuserslist\"> View Request</a>";
                mimeMessage.setText(message, "UTF-8", "html");
                mimeMessage.setSubject("New Matilda Registration Request");
            }
        };
        return preparator;
    }
    
    private MimeMessagePreparator prepareUserFeedbackMessage(UserFeedback userFeedback) {
    	MimeMessagePreparator preparator = new MimeMessagePreparator() {
			
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				mimeMessage.setFrom("matilda.unimelb@gmail.com");
				mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress("neelofar.eme@gmail.com"));
				mimeMessage.setText("User: " + userFeedback.getUserName() + "</br> Email: " + userFeedback.getEmail() +
						"</br>" + userFeedback.getMessage(), "UTF-8", "html");
				mimeMessage.setSubject("Question/Feedback from MATILDA User");
				
			}
		};
    	return preparator;
    }
 
}
