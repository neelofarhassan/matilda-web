package org.unimelb.matilda.config;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.unimelb.matilda.model.User;
import org.unimelb.matilda.service.UserService;
 


/**
 * @author Neelofar
 * 
 *
 */
@Component
public class CustomSuccessHandler2 extends SimpleUrlAuthenticationSuccessHandler {
	
 @Autowired
 UserService userService;
	
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    static final Logger logger = Logger.getLogger(CustomSuccessHandler.class);
    
    public CustomSuccessHandler2() {
//        super();
        super.setUseReferer(true);
    }
 
    @Override
    protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
            throws IOException {
        String targetUrl = determineTargetUrl(authentication, request);
 
        if (response.isCommitted()) {
            System.out.println("Can't redirect");
            return;
        }
 
        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
 
    /*
     * This method extracts the roles of currently logged-in user and returns
     * appropriate URL according to his/her role.
     */
    protected String determineTargetUrl(Authentication authentication, HttpServletRequest request) {
    	String userName="";
    	String status, url ="";
        Object principal = authentication.getPrincipal();
        if(principal instanceof UserDetails) {
        	userName = ((UserDetails) principal).getUsername();
        	if(userName != null && !userName.isEmpty() ) {
        	User user = userService.findBySSO(userName);
        	status = user.getStatus();
        	if(status.equals("waiting")) {
        		url = "/registrationpending";
        	}else {
        		url = "/";
        	}
        	}else {
        		logger.error("Could not retrieve username from principal.");
        	}
        }
        String lastURL = request.getHeader("Referer");
        System.out.println(lastURL);
        return url;
    }
 
 
    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }
 
    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }
 
}