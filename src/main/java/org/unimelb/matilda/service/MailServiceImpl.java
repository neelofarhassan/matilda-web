package org.unimelb.matilda.service;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;
import org.unimelb.matilda.model.User;
import org.unimelb.matilda.model.UserFeedback;

@PropertySource("classpath:application.properties")
@Service("mailService")
public class MailServiceImpl implements MailService {
 
    @Autowired
    JavaMailSender mailSender;
    
    @Value("${admin.email}")
    private String adminEmail;
    
    static final Logger logger = Logger.getLogger(MailServiceImpl.class);
//    @Override
//    public void sendEmail(User user) {
// 
//        MimeMessagePreparator preparator = getMessagePreparator(user);
// 
//        try {
//            mailSender.send(preparator);
//            System.out.println("Message Send...Hurrey");
//        } catch (MailException ex) {
//            System.err.println(ex.getMessage());
//        }
//    }
 
    public void emailUserFeedback(UserFeedback userFeedback) {
    	MimeMessagePreparator preparator = prepareUserFeedbackMessage(userFeedback);
    	mailSender.send(preparator);
    }
    
    public MimeMessagePreparator getMessagePreparator(User user) {
        MimeMessagePreparator preparator = new MimeMessagePreparator() {
 
            public void prepare(MimeMessage mimeMessage) throws Exception {
                mimeMessage.setFrom("matilda.unimelb@gmail.com");
                mimeMessage.setRecipient(Message.RecipientType.TO,
                        new InternetAddress("neelofar.eme@gmail.com"));
                String message = "Dear Neelofar, <br> A new registration request from Matilda is waiting for your approval. <br> <a href=\"http://formula.its.unimelb.edu.au/matilda/newuserslist\"> View Request</a>";
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
    
    public void sendFeedbackEmail(UserFeedback userFeedback) {

	    String subject = "User Query/Feedback";
	    String body = "<b>MATILDA Feedback/Query</b><br>";
	    		body+="User: " + userFeedback.getUserName() + "<br>";
	    		body+="Email: " + userFeedback.getEmail() + "<br>";
	    		body+="Message: " + userFeedback.getMessage();
	    
	    prepareAndSendEmail( adminEmail, subject, body);
    }
    
    public void sendRegistrationEmail(User user) {

	    String subject = "New Registration Request";
	    String body = "A new registration request from Matilda is waiting for your approval. <br>" ;
	    body += "<a href=\"http://localhost:8080/spring-mvc-hibernate-example/newuserslist\"> View Request</a>";
	    
	    prepareAndSendEmail( adminEmail, subject, body);
	}
    
    public void sendRegistrationApprovalEmail(User user) {
    	String subject = "MATILDA: Registration Approval";
    	String body = "<p>Dear "+user.getFirstName() + " " + user.getLastName() +", <br><br>You have registered successfully on"
    			+ "<a href=\"http://formula.its.unimelb.edu.au/matilda\"> MATILDA</a> platform. You can now log-in any time to our website.</p>";
    	String toEmail = user.getEmail();
    	prepareAndSendEmail(toEmail, subject, body);
    }
    
    private void prepareAndSendEmail( String toEmail, String subject, String body){
		try
	    {
	      String smtpHostServer = "smtp.unimelb.edu.au";
	      Properties props = System.getProperties();
	      props.put("mail.smtp.host", smtpHostServer);
	      Session session = Session.getInstance(props, null);
	      MimeMessage msg = new MimeMessage(session);
	      //set message headers
	      msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
	      msg.addHeader("format", "flowed");
	      msg.addHeader("Content-Transfer-Encoding", "8bit");

	      msg.setFrom(new InternetAddress("no_reply@matilda.unimelb.edu.au", "MATILDA"));

	      msg.setReplyTo(InternetAddress.parse("no_reply@matilda.unimelb.edu.au", false));

	      msg.setSubject(subject, "UTF-8");
	      msg.setContent(body, "text/html");

	      msg.setSentDate(new Date());

	      msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail, false));
	      
	      System.out.println("Message is ready");
	      logger.info("message prepared");
    	  Transport.send(msg);  
    	  logger.info("email sent successfully");
	      System.out.println("EMail Sent Successfully!!");
	    }
	    catch (Exception e) {
	    	logger.error(e);
	    }
	}
 
}
