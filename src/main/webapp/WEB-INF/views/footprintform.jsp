<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en" class="no-js">
<head>

  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <meta content="IE=edge" http-equiv="X-UA-Compatible" />
  <title> Matilda </title>
  <link rel="stylesheet" href="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.css">
  <link rel="stylesheet" href="<c:url value="/resources/css/matilda.css" /> ">
  <script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script>
  <style>
  	#main_container {
  	padding-top:50px;
  	padding-bottom:50px;
  	}
  </style>
   <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
   <script>
	    jQuery(document).ready(function(){
    	 	$("#problem").change(function () {   
	   		var problemName = $(this).val();
	   		var algolist = $('#algorithms'), algo_checkboxes="";
	   		var featurelist = $('#features'), feature_checkboxes="";
	   		algolist.empty();
	   		featurelist.empty();
	 		$.ajax({
	 		     type: "POST",
	 		     url: "<c:url value="/showAlgosFeatures" />",
	 		     data: { problemName: problemName},
	 		    success: function (data) {
	 		          $.each(data, function(k, v) {
	 		        	 console.log(k+ ": " +v);
	 		        	  if(k=='algos'){
	 		        		 algo_checkboxes = algo_checkboxes + "<ul class='verticalRadios'>";
	 		        		algo_checkboxes = algo_checkboxes + "<li><input type='checkbox'  id='all_algos' value='all' checked >Select All</li>";
		 		        	  $.each(v, function(index, value){
		 	 		            algo_checkboxes = algo_checkboxes + "<li><input type='checkbox' id='algo' name='selected_algorithms' value='"+value+"' checked >"+value+"</li>";	  
		 		        	  });
	 		        	  }else if(k=='features'){
	 		        		 feature_checkboxes = feature_checkboxes + "<ul class='verticalRadios'>";
	 		        		feature_checkboxes = feature_checkboxes + "<li><input type='checkbox'  id='all_features' value='all' checked >Select All</li>";
	 		        		 $.each(v, function(index, value){
	 		        			feature_checkboxes = feature_checkboxes + "<li><input type='checkbox' id='feature' name='selected_features' value='"+value+"' checked >"+value+"</li>";	  
			 		        	  });
	 		        	  }
	 		         });  
	 		         algo_checkboxes = algo_checkboxes + "<li><input type='checkbox'  id='new_algo' name='new_algo' value='new_algo'>Add New Algorithm </li></ul>";
	 		        feature_checkboxes = feature_checkboxes + "<li><input type='checkbox'  id='new_feature' name='new_feature' value='new_feature'>Add New Features</li></ul>";
	 		         algolist.html(algo_checkboxes);
	 		         featurelist.html(feature_checkboxes);
	 		        $('#algorithms_div').removeClass('hidden_div').addClass('display_div');
	 		       	$('#features_div').removeClass('hidden_div').addClass('display_div');
	 		      	$('#more_config_choice').removeClass('hidden_div').addClass('display_div');
	 		      	$('#submit_div').removeClass('hidden_div').addClass('display_div');
	 		       }
	 			});	
   			});
    	 	
	      $( "body" ).on("change","#all_algos",function(){
	    	 $('input:checkbox[id="algo"]').prop('checked', this.checked);
	       });
	      
	      $( "body" ).on("change","#all_features",function(){
		    	 $('input:checkbox[id="feature"]').prop('checked', this.checked);
		       });
	      
	      $( "body" ).on("change","#new_algo",function(){
		    	if($(this).is(':checked')){
		    		$('#new_algo_performance_file_div').removeClass('hidden_div').addClass('display_div')
		    	}else{
		    		$('#new_algo_performance_file_div').removeClass('display_div').addClass('hidden_div')
		    	}
		     });
	      
	      $( "body" ).on("change","#new_feature",function(){
		    	if($(this).is(':checked')){
		    		$('#new_feature_file_div').removeClass('hidden_div').addClass('display_div')
		    	}else{
		    		$('#new_feature_file_div').removeClass('display_div').addClass('hidden_div')
		    	}
		     });
	 		      
    	 	$("#performance_criteria").change(function(){
    	 		var performanceCriteria = $(this).val();
    	 		if(performanceCriteria == 'abs'){
    	 			$('#performance_threshold').addClass('display_div');
//     	 			$('.hidden_div').css('display','inline');
    	 		}else{
    	 			$('#performance_threshold').removeClass('display_div').addClass('hidden_div');
    	 		}
    	 	});
    	 	
    	 	$("#advanced_settings_link").click(function(){
    	 		
    	 		$('#advanced_settings').addClass('display_div');
    	 		$('#advanced_settings_link').addClass('hidden_div');
    	 		$('#hide_more_config_choice').addClass('display_div');
    	 	});
    	 	
    	 	$("#hide_advanced_settings_link").click(function(){
    	 		
    	 		$('#advanced_settings').removeClass('display_div').addClass('hidden_div');
    	 		$('#advanced_settings_link').removeClass('hidden_div').addClass('display_div');
    	 		$('#hide_more_config_choice').addClass('hidden_div');
    	 		$('#hide_advanced_settings_link').addClass('hidden_div');
    	 	});
    	 	
    	 	$('input:radio[name="problem.libraryProblem"]').change(function(){
    	 		$('#advanced_settings').removeClass('display_div').addClass('hidden_div');
    	 		$('#hide_more_config_choice').removeClass('display_div').addClass('hidden_div');
    	 		
    	 		var problemType = $(this).val();
    	 		if(problemType == 'true'){
      				var selectSubProb = $('#problem'), option="";
      				selectSubProb.empty();
      				var target = '<%= request.getAttribute("optimizationProblems")%>';
      				option = option + "<option value='null' selected>Select a problem</option>";
      				option = option + "<option value='opt' disabled>Optimization Problems</option>";
      				$.each(JSON.parse(target), function (k, v) {
	      				 console.log(k + " "+ v);
	      				 option = option + "<option value='"+k+"'>&nbsp;&nbsp;&nbsp;&nbsp;"+v+"</option>";
      				});
      				target = '<%= request.getAttribute("modelLearning")%>';
      				option = option + "<option value='lmf' disabled>Learning and Model Fitting</option>";
      				$.each(JSON.parse(target), function (k, v) {
	      				 console.log(k + " "+ v);
	      				 option = option + "<option value='"+k+"'>&nbsp;&nbsp;&nbsp;&nbsp;"+v+"</option>";
      				});
      				selectSubProb.append(option);
      				$('#library_problems_div').removeClass('hidden_div').addClass('display_div');
      				$('#problem_div').removeClass('hidden_div').addClass('display_div');
      				$('#custom_problem_div').removeClass('display_div').addClass('hidden_div');
      				$('#more_config_choice').removeClass('display_div').addClass('hidden_div');
	 		      	$('#submit_div').removeClass('display_div').addClass('hidden_div');
      				
    	 		}else{
    	 			$('#algorithms_div').removeClass('display_div').addClass('hidden_div');
    	 			$('#features_div').removeClass('display_div').addClass('hidden_div');
    	 			$('#library_problems_div').removeClass('display_div').addClass('hidden_div');
    	 			$('#custom_problem_div').removeClass('hidden_div').addClass('display_div');
    	 			$('#more_config_choice').removeClass('hidden_div').addClass('display_div');
    	 			$('#submit_div').removeClass('hidden_div').addClass('display_div');
    	 			
    	 			
    	 		}
    	 	});
    	 	
	   	});
	</script>
</head>
<body>
	
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	  <%@include file="authheader.jsp" %>
      <div role="main">
		<%@include file="/menu.jsp" %>
			<header>
                <h1>Algorithm Analysis</h1>
        </header>
        <section>
        <div>
        <p>Visualize the strength and weakness of your solution through instance space. <a href="">Submission Guidelines</a>
        give you detailed description of how to submit your data for analysis.</p>
			<c:url var="action" value="/generate-footprint" />
			<form:form action="${action}" commandName="algorithmParams" method="POST" enctype="multipart/form-data">

					<div style="margin-bottom: 20px;">
 						<h2>What problem do you want to analyze?</h2>
						<form:radiobuttons name="libraryProblem" path="problem.libraryProblem"   items="${problemTypes}" element="br" />
					</div> 
					
					<div id="library_problems_div">
						<fieldset>
							<div id="problem_div" class="twocolumnform_firstcolumn hidden_div">
								<label for="problem" data-required="true"> <strong>Select a Problem </strong></label>
								<div>
									<form:select id="problem" path="problem.problemName">
									</form:select>
								</div>
							</div>
						</fieldset>
	
						<div id="algorithms_div" class="twocolumnform_firstcolumn hidden_div">
							<h2>Select the algorithms you want to use in your analysis</h2>
							<div id="algorithms"></div>
							<div id="new_algo_performance_file_div" class="hidden_div">
								<fieldset>
									<div>
										<label for="performanceFile"><strong>Upload Performance File</strong></label>
										<div>
											<form:input type="file" path="algorithm.performanceFile" id="performanceFile" />
											<div class="has-error">
					                            <form:errors path="algorithm.performanceFile" />
					              		    </div>
				              		    </div>
			              		    </div>
			              		    <div>
										<label for="optimization_criteria" data-required="true"> <strong>Optimization Criteria</strong></label>
										<div>
											<form:select id="optimization_criteria" path="algorithm.optimizationCriteria">
												<form:option selected="selected" value="null" label="Select Optimization Criteria"  />
												<form:options items="${optimizationCriteria}"/>
											</form:select>
										</div>
									</div>
								
									<div>
										<label for="performance_criteria" data-required="true"><strong>Performance Criteria</strong></label>
										<div>
											<form:select id="performance_criteria" path="algorithm.performanceCriteria">
												<option selected="selected" value="null" label="Select Performance Criteria" />
												<form:options items="${performanceCriteria}"/>
											</form:select>
										</div>
									</div>
									
									<div id="performance_threshold" class="hidden_div">
										<label for="threshold"><strong>Performance Threshold</strong></label>
										<div>
											<form:input id="threshold" path="algorithm.performanceThreshold" placeholder="--performance threshold--" style="width:99%;"/>
										</div>   
									</div>
								</fieldset>
							</div>
						</div>
						
						<div id="features_div" class="twocolumnform_secondcolumn hidden_div">
						<h2>Select the features you want to use in your analysis</h2>
						<div id="features"></div>
							<fieldset>
								<div id="new_feature_file_div" class="twocolumnform_secondcolumn hidden_div">
									<label for="feature_file"><strong>Upload Feature File</strong></label>
									<div>
										<form:input type="file" path="feature.featureFile" id="feature_file" />
										<div class="has-error">
				                            <form:errors path="feature.featureFile" />
				              		    </div>
			              		    </div>
								</div>
							</fieldset> 
						</div>
					</div>
					
					<div id="custom_problem_div" class="hidden_div">
						<fieldset>
							<div id="custom_problem_file_div" class="twocolumnform_firstcolumn">
								<label for="performanceFile"><strong>Upload Performance File</strong></label>
								<div id="custom_performance_file_div">
									<form:input type="file" path="algorithm.performanceFile" id="performanceFile" />
									<div class="has-error">
			                            <form:errors path="algorithm.performanceFile" />
			              		    </div>
		              		    </div>
	              		    </div>
	              		    <div id="custom_feature_file_div" class="twocolumnform_secondcolumn">
								<label for="feature_file"><strong>Upload Feature File</strong></label>
								<div>
									<form:input type="file" path="feature.featureFile" id="feature_file" />
									<div class="has-error">
			                            <form:errors path="feature.featureFile" />
			              		    </div>
		              		    </div>
							</div>
						</fieldset>
					</div>

					<fieldset>
					<div id="more_config_choice" class="twocolumnform_firstcolumn hidden_div" style="padding-top:30px;">
						<a id="advanced_settings_link" href="#" style="text-decoration:none;"><i class="arrow down"></i> Advanced Settings </a> 
					</div>
					
					<div id="hide_more_config_choice" class="twocolumnform_firstcolumn hidden_div" style="padding-top:30px;">
						<a id="hide_advanced_settings_link" href="#" style="text-decoration:none;"><i class="arrow up"></i> Use Defaults </a> 
					</div>
					
					<div id="advanced_settings" class="hidden_div">
						<div class="twocolumnform_firstcolumn">
							<div class="tooltip"><label>Beta Threshold</label>
	  							<span class="tooltiptext">What is Beta Value?</span>
							</div>
							<form:input path="betaThreshold" style="width:100%"/>
						</div>
						
						<div>
							<label><h2>Diversity</h2></label>
							<div class="twocolumnform_firstcolumn">
								<label>Diversity</label>
								<form:select path="diversity">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label>Diversity Threshold</label>
								<form:input path="diversityThreshold" style="width:100%;"/>
							</div>
						</div>
						
						<div>
							<label><h2>Correlation</h2></label>
							<div class="twocolumnform_firstcolumn">
								<label>Correlation</label>
								<form:select path="coorelation">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label>Correlation Threshold</label>
								<form:input path="correlationThreshold" style="width:100%"/>
							</div>
						</div>
						
						<div>
							<label><h2>Clustering</h2></label>
							<div class="twocolumnform_firstcolumn">
								<label>Clustering</label>
								<form:select path="clustering">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label>Maximum Clusters</label>
								<form:input path="defaultMaximumClusters" style="width:100%"/>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label>Silhoute Threshold</label>
								<form:input path="silhouteThreshold" style="width:100%"/>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label>Random Forest Trees</label>
								<form:input path="numberOfTrees" style="width:100%"/>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label>Maximum Iterations</label>
								<form:input path="maximumIterations" style="width:100%"/>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label>Cluster Replicates</label>
								<form:input path="replicates" style="width:100%"/>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label>Use Parallel</label>
								<form:select path="useParallel">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
						</div>
						<div>
							<label><h2>Other Settings</h2></label>
							<div class="twocolumnform_firstcolumn">
								<label>Density Threshold</label>
								<form:input path="densityThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_secondcolumn">
								<label>Purity Threshold</label>
								<form:input path="purityThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_firstcolumn">
								<label>Lower Distance Threshold</label>
								<form:input path="lowerDistanceThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_secondcolumn">
								<label>Higher Distance Threshold</label>
								<form:input path="higherDistanceThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_firstcolumn">
								<label>PBLDR Attempts</label>
								<form:input path="attemptsByPBLDR" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_secondcolumn">
								<label>Calculate Analytical Solution</label>
								<form:select path="calculateAnalytics">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
							
							<div class="twocolumnform_firstcolumn">
								<label>Stopping Criteria</label>
								<form:input path="stoppingCriteria" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_secondcolumn">
								<label>Maximum Multiple Restarts Allowed</label>
								<form:input path="maxRestartFunEvals" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_firstcolumn">
								<label>Maximum Evaluations</label>
								<form:input path="maxFunEvals" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_secondcolumn">
								<label>Parallel Evaluation</label>
								<form:select path="parallelEval">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
							
							<div class="twocolumnform_firstcolumn">
								<label>Keep BIPOP-CMA-ES Silent</label>
								<form:select path="DispFinal">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
						</div>
					</div>
<!-- 					<div class="hidden_div"> -->
<!-- 						<label for="performanceFile"><strong>Choose Performance File</strong></label> -->
<%-- 						<form:input type="file" path="algorithm.performanceFile" id="performanceFile" /> --%>
<!-- 						<div class="has-error"> -->
<%--                             <form:errors path="algorithm.performanceFile" /> --%>
<!--               		    </div> -->
<!-- 					</div>   -->
<!-- 					<div> -->
<!-- 						<label for="binaryFile"><strong>Choose Binary file</strong></label> -->
<%-- 						<form:input type="file" path="binaryFile" id="binaryFile" /> --%>
<!-- 						<div class="has-error"> -->
<%--                             <form:errors path="binaryFile" /> --%>
<!--               		    </div> -->
<!-- 					</div> -->
					<div id="submit_div" class="twocolumnform_firstcolumn hidden_div">
						<button type="submit" class="button cta">Submit</button>
					</div>
				</fieldset>
			</form:form>
			</div>
		</section>
        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>

</body>
</html>