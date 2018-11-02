package org.unimelb.matilda.controller;


import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.codehaus.jackson.JsonFactory;
import org.codehaus.jackson.JsonGenerator;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.MediaType;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.unimelb.matilda.model.ALgorithmicFootPrint;
import org.unimelb.matilda.model.Algorithm;
import org.unimelb.matilda.model.Feature;
import org.unimelb.matilda.model.Problem;
import org.unimelb.matilda.model.User;
import org.unimelb.matilda.model.UserFeedback;
import org.unimelb.matilda.model.UserProfile;
import org.unimelb.matilda.service.MailService;
import org.unimelb.matilda.service.UserProfileService;
import org.unimelb.matilda.service.UserService;
import org.unimelb.matilda.util.FileUtil;


 
 
 
@Controller
@PropertySource("classpath:users.properties")
@RequestMapping("/")
@SessionAttributes("roles")
public class AppController {
 
    @Autowired
    UserService userService;
     
    @Autowired
    UserProfileService userProfileService;
     
    @Autowired
    MessageSource messageSource;
 
    @Autowired
    PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;
     
    @Autowired
    AuthenticationTrustResolver authenticationTrustResolver;
    
    @Autowired
    MailService mailService;
    
    @Value("${userdata.path}")
    private String userDataPath;

     
    /**
     * This method will list all existing users.
     */
    @RequestMapping(value = { "/", "/list" }, method = RequestMethod.GET)
    public String listUsers(ModelMap model) {
 
    	List<User> users = userService.findAllUsers();
        model.addAttribute("users", users);
        model.addAttribute("loggedinuser", getPrincipal());
        return "userslist";
    }
 
    @RequestMapping(value= {"/newuserslist"}, method=RequestMethod.GET)
    public String listNewUsers(ModelMap model) {
    	List<User> users = userService.findUsersByStatus("waiting");
    	model.addAttribute("users", users);
    	model.addAttribute("loggedinuser", getPrincipal());
    	model.addAttribute("userapproval", true);
    	return "userslist";
    }
    
    
    /**
     * This method will provide the medium to add a new user.
     */
    @RequestMapping(value = { "/newuser" }, method = RequestMethod.GET)
    public String newUser(ModelMap model) {
        User user = new User();
        model.addAttribute("user", user);
        model.addAttribute("edit", false);
        model.addAttribute("loggedinuser", getPrincipal());
        return "registration";
    }
 
    /**
     * This method will be called on form submission, handling POST request for
     * saving user in database. It also validates the user input
     */
    @RequestMapping(value = { "/newuser" }, method = RequestMethod.POST)
    public String saveUser(@Valid User user, BindingResult result,
            ModelMap model) {
 
        if (result.hasErrors()) {
            return "registration";
        }
 
        /*
         * Preferred way to achieve uniqueness of field [sso] should be implementing custom @Unique annotation 
         * and applying it on field [sso] of Model class [User].
         * 
         * Below mentioned peace of code [if block] is to demonstrate that you can fill custom errors outside the validation
         * framework as well while still using internationalized messages.
         * 
         */
        if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
            FieldError ssoError =new FieldError("user","ssoId",messageSource.getMessage("non.unique.ssoId", new String[]{user.getSsoId()}, Locale.getDefault()));
            result.addError(ssoError);
            return "registration";
        }
         
        userService.saveUser(user);
 
        model.addAttribute("success", "User " + user.getFirstName() + " "+ user.getLastName() + " registered successfully");
        model.addAttribute("loggedinuser", getPrincipal());
        //return "success";
        return "registrationsuccess";
    }
 
    @RequestMapping(value= "/feedback", method= RequestMethod.POST)
    public String submitUserFeedback(@Valid @ModelAttribute("usermessage")UserFeedback userFeedback, BindingResult result, ModelMap model) {
    	System.out.println(userFeedback);
    	mailService.emailUserFeedback(userFeedback);
    	
    	return "feedbacksubmission-success";
    }
    

    @RequestMapping(value= {"/approveuser-{ssoId}"}, method=RequestMethod.GET)
    public String approveNewUser(@PathVariable String ssoId) {
    	User user = userService.findBySSO(ssoId);
    	user.setStatus("approved");
    	userService.updateUser(user);
    	return "redirect:/list";
    }
    
    
 
    /**
     * This method will provide the medium to update an existing user.
     */
    @RequestMapping(value = { "/edit-user-{ssoId}" }, method = RequestMethod.GET)
    public String editUser(@PathVariable String ssoId, ModelMap model) {
        User user = userService.findBySSO(ssoId);
        model.addAttribute("user", user);
        model.addAttribute("edit", true);
        model.addAttribute("loggedinuser", getPrincipal());
        return "registration";
    }
     
    /**
     * This method will be called on form submission, handling POST request for
     * updating user in database. It also validates the user input
     */
    @RequestMapping(value = { "/edit-user-{ssoId}" }, method = RequestMethod.POST)
    public String updateUser(@Valid User user, BindingResult result,
            ModelMap model, @PathVariable String ssoId) {
 
        if (result.hasErrors()) {
            return "registration";
        }
 
        /*//Uncomment below 'if block' if you WANT TO ALLOW UPDATING SSO_ID in UI which is a unique key to a User.
        if(!userService.isUserSSOUnique(user.getId(), user.getSsoId())){
            FieldError ssoError =new FieldError("user","ssoId",messageSource.getMessage("non.unique.ssoId", new String[]{user.getSsoId()}, Locale.getDefault()));
            result.addError(ssoError);
            return "registration";
        }*/
 
 
        userService.updateUser(user);
 
        model.addAttribute("success", "User " + user.getFirstName() + " "+ user.getLastName() + " updated successfully");
        model.addAttribute("loggedinuser", getPrincipal());
        return "registrationsuccess";
    }
 
     
    /**
     * This method will delete an user by it's SSOID value.
     */
    @RequestMapping(value = { "/delete-user-{ssoId}" }, method = RequestMethod.GET)
    public String deleteUser(@PathVariable String ssoId) {
        userService.deleteUserBySSO(ssoId);
        return "redirect:/list";
    }
     
 
    /**
     * This method will provide UserProfile list to views
     */
    @ModelAttribute("roles")
    public List<UserProfile> initializeProfiles() {
        return userProfileService.findAll();
    }
     
    /**
     * This method handles Access-Denied redirect.
     */
    @RequestMapping(value = "/Access_Denied", method = RequestMethod.GET)
    public String accessDeniedPage(ModelMap model) {
        model.addAttribute("loggedinuser", getPrincipal());
        return "accessDenied";
    }
 
    /**
     * This method handles login GET requests.
     * If users is already logged-in and tries to goto login page again, will be redirected to list page.
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage() {
        if (isCurrentAuthenticationAnonymous()) {
            return "login";
        } else {
            return "redirect:/list";  
        }
    }
    
    @RequestMapping(value="registrationpending", method = RequestMethod.GET)
    public String pendingRequestLogin(HttpServletRequest request, HttpServletResponse response, Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        Object principal = auth.getPrincipal();
        if(principal instanceof UserDetails) {
        	String userName = ((UserDetails) principal).getUsername();	
        	model.addAttribute("username", userName);
		}
        
        if (auth != null){    
            //new SecurityContextLogoutHandler().logout(request, response, auth);
            persistentTokenBasedRememberMeServices.logout(request, response, auth);
            SecurityContextHolder.getContext().setAuthentication(null);
        }
    	return "registrationpending";
    }
 
    /**
     * This method handles logout requests.
     * Toggle the handlers if you are RememberMe functionality is useless in your app.
     */
    @RequestMapping(value="/logout", method = RequestMethod.GET)
    public String logoutPage (HttpServletRequest request, HttpServletResponse response){
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null){    
            //new SecurityContextLogoutHandler().logout(request, response, auth);
            persistentTokenBasedRememberMeServices.logout(request, response, auth);
            SecurityContextHolder.getContext().setAuthentication(null);
        }
        System.out.println("Into Logout Page");
        return "redirect:/login?logout";
    }
    
    @RequestMapping(value="/data-analytics", method=RequestMethod.GET)
    public String showFootprintGenerationForm(@ModelAttribute ALgorithmicFootPrint algorithm, Model model) {
//    	Algorithm algorithm = new Algorithm();
    	model.addAttribute("algorithmParams", algorithm);
    	
    	
    	HashMap<String, String> optimizationCriteria = new HashMap<String, String>();
    	optimizationCriteria.put("min", "Minimize");
    	optimizationCriteria.put("max", "Maximize");
    	model.addAttribute("optimizationCriteria", optimizationCriteria);
    	
    	HashMap<String, String> performanceCriteriaList = new HashMap<String, String>();
    	performanceCriteriaList.put("rel", "Relative");
    	performanceCriteriaList.put("abs", "Absolute");
    	model.addAttribute("performanceCriteria", performanceCriteriaList);
    	
    	HashMap<String, String> mainProblemsList = new HashMap<>();
    	mainProblemsList.put("opt", "Optimization");
    	mainProblemsList.put("lmf", "Learning & Model Fitting");
    	model.addAttribute("mainProbmensLIst", mainProblemsList);
    	
    	HashMap<String, String> optimizationProblems = new HashMap<>();
    	optimizationProblems.put("tsp", "Travelling Salesman Problem");
    	optimizationProblems.put("gcp", "Graph Coloring Problem");
    	optimizationProblems.put("ksp", "Knapsack Problem");
    	optimizationProblems.put("lp", "Linear Programming");
    	optimizationProblems.put("Mip", "Mixed Integer Programming");
    	optimizationProblems.put("bb-single", "Black-Box Single Objective");
    	optimizationProblems.put("bb-multi", "Black-Box Multi-Objective");
    	
    	HashMap<String, String> modelLearning = new HashMap<>();
    	modelLearning.put("regression", "Regression");
    	modelLearning.put("classification", "Classification");
    	modelLearning.put("anomaly", "Anomaly Detection");
    	modelLearning.put("tsf", "Time Series Forecasting");
    	
    	HashMap<Boolean, String> problemType = new HashMap<>();
    	problemType.put(true, "Problem from our library");
    	problemType.put(false, "Custom problem");
    	model.addAttribute("problemTypes", problemType);
    	
    	Writer writer;
    	JsonGenerator jsonGenerator;
    	String optimizationAlogs = null;
    	String learningTechniques = null;
    	ObjectMapper mapper;
    	try {
    		writer =  new StringWriter();
    		jsonGenerator = new JsonFactory().createJsonGenerator(writer);
    		mapper = new ObjectMapper();
    		mapper.writeValue(jsonGenerator, optimizationProblems);
    		jsonGenerator.close();
    		optimizationAlogs = writer.toString();
    		
    		writer =  new StringWriter();
    		jsonGenerator = new JsonFactory().createJsonGenerator(writer);
    		mapper = new ObjectMapper();
    		mapper.writeValue(jsonGenerator, modelLearning);
    		jsonGenerator.close();
    		learningTechniques = writer.toString();
    	} catch (Exception e) {
    		e.printStackTrace();
    	}
    	model.addAttribute("optimizationProblems", optimizationAlogs);
    	model.addAttribute("modelLearning", learningTechniques);
    	return "footprintform";
    }
    

    
//Form submission without bean mapping
    
//    @RequestMapping(value="/generate-footprint", method=RequestMethod.POST, consumes=MediaType.APPLICATION_FORM_URLENCODED_VALUE)
//    @ResponseStatus(value=HttpStatus.OK)
//    public @ResponseBody String generateFootPrint(@RequestBody MultiValueMap<String, String> formParams) {
//    	 System.out.println("form params received " + formParams);
//    	return "";
//    }
        
    @RequestMapping(value="/generate-footprint", method=RequestMethod.POST)
    public String generateFootPrint(HttpServletRequest servletRequest, @ModelAttribute ALgorithmicFootPrint algorithm, Model model) throws IOException {
    	String problemName = algorithm.getProblem().getProblemName();
    	Boolean isLibraryProblem = algorithm.getProblem().getLibraryProblem();
    	System.out.println(problemName + ":" + isLibraryProblem);
    	String[] selectedAlgos = servletRequest.getParameterValues("selected_algorithms");

    	System.out.println(selectedAlgos);
//    	if(isCurrentAuthenticationAnonymous()) { 
//    		return "redirect:/login";
//    	}else {
//    		String userName = getPrincipal();
//        	System.out.println(algorithm);
//        	File performanceFile = new File(userDataPath + "/" + userName + "/" + problemName + "/user-input-files/performance.csv");
//        	if(!performanceFile.exists()) {
//        		performanceFile.mkdirs();
//        	}
//        	algorithm.getPerformanceFile().transferTo(performanceFile);
//        	File binaryFile = new File(userDataPath + "/" + userName + "/" + problemName + "/user-input-files/binary.csv");
//        	if(!binaryFile.exists()) {
//        		binaryFile.mkdirs();
//        	}
//        	algorithm.getBinaryFile().transferTo(binaryFile);
//        	System.out.println("performance file submitted");
//        	String algorithmFootPrint = userDataPath + "/" + userName + "/" + problemName +  "/user-output-files/footprint_portfolio.png";
//        	model.addAttribute("footprint", algorithmFootPrint);
//        	return "Algorithmic-footprints";	
//    	}
    	System.out.println(algorithm);
    	return "";
    }
    
    @RequestMapping(value="/showgraph", method=RequestMethod.GET)
    public String showGraph(Model model) {
    	model.addAttribute("algorithm", new Algorithm());
    	return "graph";
    }
    
//    @RequestMapping(value = "/showAlgosFeatures", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
//    public @ResponseBody
//    List<Algorithm> showAlgorithmsAndFeatures(@RequestParam("problemName") String problemName) {
//    	FileUtil fileUtil = new FileUtil();
//    	String filePath = "files/algorithm-features-list.txt";
//    	List<Problem> problems = fileUtil.JSONToProblemConverter(filePath);
//    	List<Algorithm> algorithms = new ArrayList<>();
//    	for(Problem problem:problems) {
//    		if(problem.getProblemCode().equals(problemName)) {
//    			algorithms = problem.getLibraryAlgorithms();
//    		}
//    	}
//    	return algorithms;
//    }
    
    @RequestMapping(value = "/showAlgosFeatures", method = RequestMethod.POST,produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody
    Map<String, List<String>> showAlgorithmsAndFeatures(@RequestParam("problemName") String problemName) {
    	FileUtil fileUtil = new FileUtil();
    	String filePath = "files/algorithm-features-list.txt";
    	List<Problem> problems = fileUtil.JSONToProblemConverter(filePath);
    	List<Algorithm> algorithms = new ArrayList<>();
    	List<Feature> features = new ArrayList<>();
    	List<String> algoNames  = new ArrayList<>();
    	List<String> featureNames = new ArrayList<>();
    	for(Problem problem:problems) {
    		if(problem.getProblemCode().equals(problemName)) {
    			algorithms = problem.getLibraryAlgorithms();
    			features = problem.getFeatures();
    			for(Algorithm algorithm:algorithms) {
    				algoNames.add(algorithm.getAlgorithmName());
    			}
    			for(Feature feature:features) {
    				featureNames.add(feature.getFeatureName());
    			}
    		}
    	}
    	Map<String, List<String>> algosFeaturesMap = new HashMap<>();
    	algosFeaturesMap.put("algos", algoNames);
    	algosFeaturesMap.put("features", featureNames);
    	return algosFeaturesMap;
    }
 
    /**
     * This method returns the principal[user-name] of logged-in user.
     */
    private String getPrincipal(){
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
 
        if (principal instanceof UserDetails) {
            userName = ((UserDetails)principal).getUsername();
        } else {
            userName = principal.toString();
        }
        return userName;
    }
     
    /**
     * This method returns true if users is already authenticated [logged-in], else false.
     */
    private boolean isCurrentAuthenticationAnonymous() {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        return authenticationTrustResolver.isAnonymous(authentication);
    }
 
}
