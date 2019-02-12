package org.unimelb.matilda.controller;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.apache.log4j.Logger;
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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
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
import org.unimelb.matilda.util.JSONUtil;
import org.unimelb.matilda.util.VerifyRecaptcha;

 
@Controller
@PropertySource("classpath:application.properties")
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
    
    @Value("${matlab.script.command}")
    private String matlabCommand;
    
    @Value("${user.job.cancellation}")
    private String userJobCancellationCommand;
    
    @Value("${max.wait}")
    private String maximumWaitForFileLoad;
    
    static final Logger logger = Logger.getLogger(AppController.class); 

    /**
     * This method will list all existing users.
     */
    @RequestMapping(value = { "/", "/list" }, method = RequestMethod.GET)
    public String listUsers(ModelMap model) {
 
    	List<User> users = userService.findAllUsers();
        model.addAttribute("users", users);
        model.addAttribute("loggedinuser", getPrincipal());
		boolean authenticationStatus=false;
		if(!isCurrentAuthenticationAnonymous()) {
			authenticationStatus=true;
		}
		model.addAttribute("authenticationStatus", authenticationStatus);
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
     * @throws IOException 
     */
    @RequestMapping(value = { "/newuser" }, method = RequestMethod.POST)
    public String saveUser(HttpServletRequest request, @Valid User user, BindingResult result,
            ModelMap model) throws IOException {
    			String gRecaptchaResponse = request
    					.getParameter("g-recaptcha-response");
    			if(gRecaptchaResponse == null || gRecaptchaResponse.isEmpty()) {
    				FieldError recaptchaError = new FieldError("user", "captchaError", "Please click the checkbox to confirm that you are not a robot. ");
    				result.addError(recaptchaError);
    			}else {
    				boolean verify = VerifyRecaptcha.verify(gRecaptchaResponse);
    				if(!verify) {
	    				FieldError recaptchaError = new FieldError("user", "captchaError", "User could not be identified as a human. Please try again. ");
	    				result.addError(recaptchaError);
    				}
    			}
	    			
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
    	mailService.sendRegistrationEmail(user);
    	
 
        model.addAttribute("success", "User " + user.getFirstName() + " "+ user.getLastName() + " registered successfully");
        model.addAttribute("username", user.getSsoId());
        model.addAttribute("loggedinuser", getPrincipal());
        return "registrationsuccess";
    }
 
    @RequestMapping(value= "/feedback", method= RequestMethod.POST)
    public String submitUserFeedback(@Valid @ModelAttribute("usermessage")UserFeedback userFeedback, BindingResult result, ModelMap model) {
    	System.out.println(userFeedback);
    	mailService.sendFeedbackEmail(userFeedback);
    	
    	return "feedbacksubmission-success";
    }
    

    @RequestMapping(value= {"/approveuser-{ssoId}"}, method=RequestMethod.GET)
    public String approveNewUser(@PathVariable String ssoId) {
    	User user = userService.findBySSO(ssoId);
    	user.setStatus("approved");
    	User updatedUser = userService.updateUserStatus(user);
    	if(updatedUser.getStatus().equals("approved")) {
    		mailService.sendRegistrationApprovalEmail(user);
    	}
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
    public String loginPage(HttpServletRequest request) {
    	String referrer = request.getHeader("Referer");
    	HttpSession session = request.getSession();
        if (isCurrentAuthenticationAnonymous()) {
//        	String referrer = request.getHeader("Referer");
        	System.out.println(referrer);
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
    public String showFootprintGenerationForm(@ModelAttribute ALgorithmicFootPrint algorithm, Model model, HttpServletRequest request) {
    	if(isCurrentAuthenticationAnonymous()) {
    		return "redirect:/login";
    	}
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
    	optimizationProblems.put("Travelling Salesman Problem", "Travelling Salesman Problem");
    	optimizationProblems.put("Graph Coloring Problem", "Graph Coloring Problem");
    	optimizationProblems.put("Knapsack Problem", "Knapsack Problem");
    	optimizationProblems.put("Linear Programming", "Linear Programming");
    	optimizationProblems.put("Mixed Integer Programming", "Mixed Integer Programming");
    	optimizationProblems.put("Black-Box Single Objective", "Black-Box Single Objective");
    	optimizationProblems.put("Black-Box Multi-Objective", "Black-Box Multi-Objective");
    	
    	HashMap<String, String> modelLearning = new HashMap<>();
    	modelLearning.put("Regression", "Regression");
    	modelLearning.put("Classification", "Classification");
    	modelLearning.put("Anomaly Detection", "Anomaly Detection");
    	modelLearning.put("Time Series Forecasting", "Time Series Forecasting");
    	
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
		boolean authenticationStatus=false;
		if(!isCurrentAuthenticationAnonymous()) {
			authenticationStatus=true;
		}
		model.addAttribute("authenticationStatus", authenticationStatus);
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
    public ModelAndView generateFootPrint(HttpServletRequest servletRequest, @ModelAttribute @Valid ALgorithmicFootPrint algorithm, BindingResult result, Model model) throws IOException {
     	if(isCurrentAuthenticationAnonymous()) { 
    		return new ModelAndView("redirect:/login");
    	}else {
    		
    		boolean authenticationStatus=true;
    		model.addAttribute("authenticationStatus", authenticationStatus);
    		String problemName="";
    		String userName = getPrincipal();
    		model.addAttribute("userName", userName);
        	Boolean isLibraryProblem = algorithm.getProblem().getLibraryProblem();

        	if(isLibraryProblem) {
	        	String userFriendlyProblemName = algorithm.getProblem().getProblemName();
	        	problemName = createOperatingSystemFriendlyProblemName(userFriendlyProblemName);
	        	model.addAttribute("problemName", problemName);
	        	model.addAttribute("userFriendlyProblemName", userFriendlyProblemName);
	        	String[] selectedAlgoParam = servletRequest.getParameterValues("selected_algorithms");
	        	List<String> selectedAlgorithms = new ArrayList<>();
	        	if(selectedAlgoParam != null && selectedAlgoParam.length > 0) {
	        		for(int i=0; i<selectedAlgoParam.length; i++) {
	        			selectedAlgorithms.add(selectedAlgoParam[i]);
	        		}
	        		algorithm.setSelectedAlgorithms(selectedAlgorithms);
	        	}
	        	
	        	String[] selectedFeaturesParam = servletRequest.getParameterValues("selected_features");
	        	List<String> selectedFeatures = new ArrayList<>();
	        	if(selectedFeaturesParam != null && selectedFeaturesParam.length > 0) {
	        		for(int i=0; i<selectedFeaturesParam.length; i++) {
	        			selectedFeatures.add(selectedFeaturesParam[i]);
	        		}
	        		algorithm.setSelectedFeatures(selectedFeatures);
	        	}
	        	
	        	File directory = new File(userDataPath + "/" + userName + "/" + problemName);
	        	if(!directory.exists()) {
	        		try {
	        		directory.mkdirs();
	        		}catch(Exception e) {
	        			logger.error("error making directory: " + directory.getAbsolutePath());
	        		}
	        	}else {
	        		boolean cleared = clearUserDirectory(directory);
	        		if(cleared) {
	        			logger.info("user directory cleared successfully: " + directory.getAbsolutePath());
	        		}
	        	}

	        	
	        	String newAlgorithm = servletRequest.getParameter("new_algo");
	        	String newFeature = servletRequest.getParameter("new_feature");
	        	if(newAlgorithm != null && !newAlgorithm.isEmpty()) {
	        		algorithm.setAddNewAlgorithm(true);
	        		MultipartFile file = algorithm.getPerformanceFile();
	        		logger.info("submitting performance file for library problem. ");
	            	File performanceFile = new File(userDataPath + "/" + userName + "/" + problemName + "/performance.csv");
	            	file.transferTo(performanceFile);
	        	}
	        	if(newFeature != null && !newFeature.isEmpty()) {
	        		algorithm.setAddNewFeature(true);
	        		MultipartFile file = algorithm.getFeatureFile();
	        		logger.info("subitting feature file for library problem");
	        		File featureFile = new File(userDataPath + "/" + userName + "/" + problemName + "/feature.csv");
	            	file.transferTo(featureFile);
	        	}
        	}else {
        		String customProblemName = algorithm.getCustomProblemName();
        		problemName = createOperatingSystemFriendlyProblemName(customProblemName);
        		model.addAttribute("problemName", problemName);
        		model.addAttribute("userFriendlyProblemName", customProblemName);
        		algorithm.getProblem().setProblemName(problemName);
        		
            	File directory = new File(userDataPath + "/" + userName + "/" + problemName);
            	if(!directory.exists()) {
            		try {
            		directory.mkdirs();
            		}catch(Exception e) {
            			logger.error("error making directory: " + directory.getAbsolutePath());
            		}
            	}else {
            		boolean cleared = clearUserDirectory(directory);
            		if(cleared) {
            			logger.info("user directory cleared successfully: " + directory.getAbsolutePath());
            		}
            	}
        		
        		MultipartFile customPerformanceFile = algorithm.getCustomPerformanceFile();
        		logger.info("submitting performance file for custom problem. ");
            	File performanceFile = new File(userDataPath + "/" + userName + "/" + problemName + "/performance.csv");
            	customPerformanceFile.transferTo(performanceFile);
            	
            	MultipartFile customFeatureFile = algorithm.getCustomFeatureFile();
        		logger.info("submitting feature file for custom problem. ");
            	File featureFile = new File(userDataPath + "/" + userName + "/" + problemName + "/feature.csv");
            	customFeatureFile.transferTo(featureFile);
        	}
        		JSONUtil jsonUtil = new JSONUtil();
        		jsonUtil.createConfigurationJSON(userName, userDataPath, algorithm, problemName);
        	
        	
        	String algorithmFootPrint = userDataPath + "/" + userName + "/" + problemName +  "/footprint_portfolio.png";
        	model.addAttribute("footprint", algorithmFootPrint);
        	model.addAttribute("PerformanceMetricLabel", algorithm.getAlgorithm().getPerformanceMetricLabel());
        	
        	
        	String[] jobOutput = executeFootprintGenerationMatlabCode(userName, problemName);
        	boolean success = Boolean.parseBoolean(jobOutput[0]);
//        	String[] jobOutput = {"true", "1"};
//        	boolean success = true;
        	if(success) {
            	File file = new File(userDataPath + "/" + userName + "/" + problemName + "/matilda_logs.txt");
            	int initialWait = 2000;
            	while(!file.exists()) {
            		try {
        				Thread.sleep(2000);
        				if(initialWait >= Integer.parseInt(maximumWaitForFileLoad)) {
        					break;
        				}
        				initialWait += 1000;
        			} catch (InterruptedException e) {
        				e.printStackTrace();
        			}
            	}
            	if(!file.exists()) {
            		model.addAttribute("error", "Sorry, some problem occured while executing your code. Please contact website administation. ");
            		return new ModelAndView("Algorithmic-footprints-failure");
            	}else {
            		if(jobOutput[1] != null && !jobOutput[1].isEmpty()) {
            			model.addAttribute("jobId", jobOutput[1]);
            		}
            		return new ModelAndView("Algorithmic-footprints");
        		}
        	}else {
        		model.addAttribute("error", "Sorry, some problem occured while executing your code. Please contact website administation. ");
        		return new ModelAndView("Algorithmic-footprints-failure");
        	}
    	}
    }
    
    @RequestMapping(value="/showgraph", method=RequestMethod.GET)
    public String showGraph(Model model) {
    	model.addAttribute("algorithm", new Algorithm());
    	return "graph";
    }
    @RequestMapping(value={"/cancelUserJob/{jobId}/{problemName}"}, method=RequestMethod.GET)
    private String cancelUserJob(@PathVariable("jobId") int jobId, @PathVariable("problemName") String problemName) {
    	String userName = getPrincipal();
    	logger.info("user name: " + userName +" User job cancellation id: " + jobId + "" );
    	if(isCurrentAuthenticationAnonymous()) { 
    		return "redirect:/login";
    	}else {
    	String[] command = {"/bin/bash", "-c", "cd /servers/slurm/spool ;" + userJobCancellationCommand + " " + String.valueOf(jobId)};
    	ProcessBuilder p = new ProcessBuilder(command);
    	BufferedReader br= null;
    	    try {  
    	        Process p2 = p.start(); 
//    	        p2.waitFor();
    	        br = new BufferedReader(new InputStreamReader(p2.getInputStream()));
    	        String line;
    	        logger.info("Output of running " + command.toString() + " is: ");
    	        while ((line = br.readLine()) != null) {
    	        	logger.info(line);
    	        }
    	    }catch(Exception e) {
    	    	logger.error(e.getMessage());
    	    }finally {
    	    	try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
    	    }
    	return "redirect:/data-analytics";
    }
    }

    
    @RequestMapping(value = "/showAlgosFeatures", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
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

    @RequestMapping(value="/test", method=RequestMethod.GET)
    public ModelAndView dummyMethodForConsoleOutputTesting() {
    	return new ModelAndView("Algorithmic-footprints");
    }
    
    public String[] executeFootprintGenerationMatlabCode(String userName, String problemName){
    	String path = userDataPath+ "/"+userName + "/" + problemName;
    	String[] jobOutput = new String[2];
    	boolean success = true;
    	String[] command = {"/bin/bash", "-c", "cd /servers/slurm/spool ;" +matlabCommand + " " + path};
    	logger.info("submitted command is: " + Arrays.toString(command));
    	System.out.println("complete command is : " + Arrays.toString(command));
    	ProcessBuilder p = new ProcessBuilder(command);
    	BufferedReader br= null;
    	    try {  
    	        Process p2 = p.start(); 
//    	        p2.waitFor();
    	        br = new BufferedReader(new InputStreamReader(p2.getInputStream()));
    	        String line;
    	        StringBuilder commandOutput = new StringBuilder();
    	        while ((line = br.readLine()) != null) {
    	        	commandOutput.append(line);
    	        	System.out.println("output from submitting job: " + line);
    	            String[] lineTokens = line.split(" ");
    	            int numberOfTokens = lineTokens.length;
    	            jobOutput[1] = lineTokens[numberOfTokens - 1];
    	        }
    	        logger.info("output from submitting job by user " + userName + ": " + commandOutput.toString() );
    	    }catch(Exception e) {
    	    	logger.error(e.getMessage());
    	    	success = false;
    	    }finally {
    	    	try {
					br.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
    	    }

		jobOutput[0]=String.valueOf(success);
		return jobOutput;
	}
    
    
/*  This method returns a map to the view, based on which jsp decides whether to call this method again or not. 
    Key of a map is a boolean, true means there is new contents, false means contents is not updated in log file.
    string[] has 5 elements
    1. End of File (true/false)
    2. Last read line number
    3. Actual file contents
    4. Modification time
    5. Does the content represent failure or success of script
*/    
    @RequestMapping(value = "/readMatlabLogFileRecursively", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody Map<Boolean, String[]> readFileContentsRecursively(@RequestParam ("lastModified") long lastModified, @RequestParam("lastLineRead") int lastLineNumberRead, @RequestParam ("userName") String userName, @RequestParam ("problemName") String problemName){
//
    	//    	yes/no -- does it have update contents
//    	[EOF, lastReadLine, contents, lastModified] -- more contents
//    	[contents]
    	problemName = createOperatingSystemFriendlyProblemName(problemName);
    	String[] mapArray = new String[5];
    	Map<Boolean, String[]> fileContents = new HashMap<>();
    	long currentModified = 0;
    	int lineNumber=0;
    	StringBuilder fileContent= new StringBuilder();
    	boolean isModified=false;
    	File file = new File(userDataPath + "/" + userName + "/" + problemName + "/matilda_logs.txt");
    	if(!file.exists()) {
    		fileContents = null;
    	}else {
    		BufferedReader reader = null;
    		try {
    			currentModified = file.lastModified();
    			isModified = currentModified != lastModified;
				reader = new BufferedReader(new FileReader(file));
				int startingLine = lastLineNumberRead+1;
				String line="";
				String lastLine="";
				boolean scriptSuccess = true;
				
				while((line = reader.readLine()) != null) {
					if(line.equals("EOF:ERROR")) {
						scriptSuccess = false;
					}
					lastLine = line;
					lineNumber++;
					if(lastModified == 0) {
						fileContent.append(line);
						fileContent.append("<br>");
						
					} else if(isModified) {
						if(lineNumber >= startingLine) {
							fileContent.append(line);
							fileContent.append("<br>");
						}
					}else {
						isModified=false;
					}
					
				}
				if(lastLine.equals("EOF")) {
					mapArray[0]="true";
					
				}else {
					mapArray[0]="false";
				}
				mapArray[1] = String.valueOf(lineNumber);
				mapArray[2] = fileContent.toString();
				mapArray[3] = Long.toString(currentModified);
				mapArray[4] = String.valueOf(scriptSuccess);
				fileContents.put(isModified, mapArray);
    		}
    	catch(Exception e) {
    	}finally {
    		if(reader != null) {
    		try {
				reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
    		}
    	}
    	}
    	System.out.println("time last modified: " + lastModified + "\ttime current modified: " + currentModified + "\tline Number: "+ lineNumber + "\tstarting line: " + lastLineNumberRead + "\tis Modified: " + isModified + "\tfile Contents: " + fileContent.toString());
    	return fileContents;
    } 
    
   @RequestMapping(value="/readPerformanceTable", method=RequestMethod.GET, produces=MediaType.APPLICATION_JSON_VALUE)
    public @ResponseBody Map<Integer, String[]> readPerformanceTable(@RequestParam("userName") String userName, @RequestParam("problemName") String problemName){
    	Map<Integer, String[]> performanceMap = new HashMap<>();
    	problemName = createOperatingSystemFriendlyProblemName(problemName);
    	String performanceFilePath = userDataPath + "/" + userName + "/" + problemName + "/footprint_performance.csv";
    	File file = new File(performanceFilePath);
    	if(!file.exists()) {
    		logger.error("footprint_performance.csv doesn't exist for " + userName + " for " + problemName);
    		return null;
    	}else {
    		BufferedReader reader=null;
    		try {
    			String line="";
    			int rowCount =0;
				 reader = new BufferedReader(new FileReader(file));
				 while((line=reader.readLine())!=null) {
					 rowCount++;
					 String[] performanceTokens = line.split(",");
					 performanceMap.put(rowCount, performanceTokens);
				 }
			} catch (IOException e) {
				e.printStackTrace();
				logger.error(e);
				return null;
			}finally {
				try {
					reader.close();
				} catch (IOException e) {
					e.printStackTrace();
					logger.error(e);
				}
			}
    		
    	}
    	return performanceMap;
    }
    
    @GetMapping("/test-highcharts")
    public String test(){
    	return "highcharts-test";
    }
    
    @GetMapping("/index1")
    public String homeTest() {
    return "index1";	
    }
    @GetMapping("/index2")
    public String homeTest2() {
    return "index2";	
    }
    @GetMapping("/index3")
    public String homeTest3() {
    return "index3";	
    }
    @GetMapping("/index4")
    public String homeTest4() {
    return "index4";	
    }
    @GetMapping("/index5")
    public String homeTest5() {
    return "index5";	
    }
    @GetMapping("/index6")
    public String homeTest6() {
    return "index6";	
    }
    @GetMapping("/index7")
    public String homeTest7() {
    return "index7";	
    }
    @GetMapping("/index8")
    public String homeTest8() {
    return "index8";	
    }
    private boolean clearUserDirectory(File directory) {
    		File[] directoryContents = directory.listFiles();
    		for(File file: directoryContents) {
    			try {
    				file.delete();
    			}catch(Exception e) {
    				logger.error("Problem deleting file: " + file.getAbsolutePath());
    				return false;
    			}
    		}
    		return true;
    }
    
    private String createOperatingSystemFriendlyProblemName(String userFriendlyProblemName) {
    	String[] problemNameTokens = userFriendlyProblemName.split(" ");
		StringBuilder problemName= new StringBuilder();
		int iterator = 0;
		for(String token: problemNameTokens) {
			if(!token.isEmpty()) {
				if(iterator > 0) {
					problemName.append("_");
				}
				problemName.append(token);
			}
			iterator++;
		}
		return problemName.toString();
    }
    
    private String createUserFriendlyProblemName(String systemFriendlyProblemName) {
    	String[] problemNameTokens = systemFriendlyProblemName.split("_");
    	StringBuilder problemName = new StringBuilder();
    	int iterator = 0;
    	for(String token: problemNameTokens) {
    		problemName.append(token);
    		if(iterator < (problemNameTokens.length -1)) {
    			problemName.append(" ");
    		}
    		iterator++;
    	}
    	return problemName.toString();
    }

}
