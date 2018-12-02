package org.unimelb.matilda.service;

import org.unimelb.matilda.model.User;
import org.unimelb.matilda.model.UserFeedback;

public interface MailService {
	public void sendRegistrationEmail(User user);
	public void sendFeedbackEmail(UserFeedback feedback);
//	public void emailUserFeedback(UserFeedback userFeedback);
}
