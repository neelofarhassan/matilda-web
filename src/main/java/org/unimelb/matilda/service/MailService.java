package org.unimelb.matilda.service;

import org.unimelb.matilda.model.User;
import org.unimelb.matilda.model.UserFeedback;

public interface MailService {
	public void sendEmail(User user);
	public void emailUserFeedback(UserFeedback userFeedback);
}
