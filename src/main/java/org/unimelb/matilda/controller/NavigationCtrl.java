package org.unimelb.matilda.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.unimelb.matilda.model.User;
import org.unimelb.matilda.model.UserFeedback;
import org.unimelb.matilda.service.MailService;
import org.unimelb.matilda.service.UserService;

@Controller
public class NavigationCtrl {
	
	@Autowired
    AuthenticationTrustResolver authenticationTrustResolver;
    @Autowired
    UserService userService;
    @Autowired
    MailService mailService;

	@RequestMapping(value="/about-us", method=RequestMethod.GET)
	public String showAboutUs(Model model) {
		boolean authenticationStatus=false;
		if(!isCurrentAuthenticationAnonymous()) {
			authenticationStatus=true;
		}
		model.addAttribute("authenticationStatus", authenticationStatus);
		return "about";
	}
	
	@RequestMapping(value="/contact-us", method=RequestMethod.GET)
	public String showContactUs(Model model) {
		UserFeedback userMessgae = new UserFeedback();
		model.addAttribute("usermessage", userMessgae);
		boolean authenticationStatus=false;
		if(!isCurrentAuthenticationAnonymous()) {
			authenticationStatus=true;
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			Object principal = auth.getPrincipal();
			if(principal instanceof UserDetails) {
				String userName = ((UserDetails) principal).getUsername();
				User user = userService.findBySSO(userName);
				model.addAttribute("name", user.getLastName() + ", " + user.getFirstName());
				model.addAttribute("email", user.getEmail());
			}
		}
		model.addAttribute("authenticationStatus", authenticationStatus);
		return "contact-us";
	}
	
	@RequestMapping(value="/terms-of-use", method=RequestMethod.GET)
	public String showTermsOfUse(Model model) {
		boolean authenticationStatus=false;
		if(!isCurrentAuthenticationAnonymous()) {
			authenticationStatus=true;
		}
		model.addAttribute("authenticationStatus", authenticationStatus);
		return "usage-policy";
	}
	
	@RequestMapping(value="/submission-guidelines", method=RequestMethod.GET)
	public String showSubmissionGuidelines(Model model) {
		boolean authenticationStatus=false;
		if(!isCurrentAuthenticationAnonymous()) {
			authenticationStatus=true;
		}
		model.addAttribute("authenticationStatus", authenticationStatus);
		return "submission-guidelines";
	}
	
	@RequestMapping(value="/about-matilda", method=RequestMethod.GET)
	public ModelAndView showProjectDetails() {
		return new ModelAndView("about-matilda");
	}
	
	@GetMapping("/combinatorial-problem/**")
	public String showCombinatorialOptimization(HttpServletRequest request, Model	model) {
		boolean authenticationStatus=false;
		if(!isCurrentAuthenticationAnonymous()) {
			authenticationStatus=true;
		}
		model.addAttribute("authenticationStatus", authenticationStatus);
		String requestedUri = request.getRequestURI();
		String[] urlPaths = requestedUri.split("/");
		String anchor = urlPaths[urlPaths.length -1];
		model.addAttribute("anchor", "#"+anchor);
		return "combinatorial-optimization";
	}
	
	@GetMapping("/submit")
	public String submitAlgorithm(Model model) {
		boolean authenticationStatus=false;
		if(!isCurrentAuthenticationAnonymous()) {
			authenticationStatus=true;
		}
		model.addAttribute("authenticationStatus", authenticationStatus);
		return "submit-code";		
	}
	
    /**
     * This method returns true if users is already authenticated [logged-in], else false.
     */
    private boolean isCurrentAuthenticationAnonymous() {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authenticationTrustResolver.isAnonymous(authentication);
    }
		
}
