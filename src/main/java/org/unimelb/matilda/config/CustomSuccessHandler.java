package org.unimelb.matilda.config;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.Priority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.unimelb.matilda.model.User;
import org.unimelb.matilda.service.UserService;

import com.mchange.v2.cfg.DelayedLogItem.Level;
 


/**
 * @author Neelofar
 * This class is not currently in use in this project. Added just for reference purpose. Must be removed before production
 *
 */
@Component
public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {
	
 @Autowired
 UserService userService;
	
    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
    static final Logger logger = Logger.getLogger(CustomSuccessHandler.class);
    
    public CustomSuccessHandler() {
        super();
        setUseReferer(true);
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
//        		url = request.getHeader("Referer");
        		url = "/";
        	}
        	}else {
        		logger.error("Could not retrieve username from principal.");
        	}
        }
        
        return url;
    }
 
 
    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }
 
    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }
 
}