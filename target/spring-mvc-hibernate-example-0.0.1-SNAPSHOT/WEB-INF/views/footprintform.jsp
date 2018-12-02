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
	 		        		algo_checkboxes = algo_checkboxes + "<li><input type='checkbox'  id='new_algo' name='new_algo' value='new_algo'>Add New Algorithm </li>";
	 		        		 algo_checkboxes = algo_checkboxes + "<li><input type='checkbox'  id='all_algos' value='all' checked >Select All</li>";
		 		        	  $.each(v, function(index, value){
		 	 		            algo_checkboxes = algo_checkboxes + "<li><input type='checkbox' id='algo' name='selected_algorithms' value='"+value+"' checked >"+value+"</li>";	  
		 		        	  });
	 		        	  }else if(k=='features'){
	 		        		 feature_checkboxes = feature_checkboxes + "<ul class='verticalRadios'>";
	 		        		feature_checkboxes = feature_checkboxes + "<li><input type='checkbox'  id='new_feature' name='new_feature' value='new_feature'>Add New Features</li>";
	 		        		 feature_checkboxes = feature_checkboxes + "<li><input type='checkbox'  id='all_features' value='all' checked >Select All</li>";
	 		        		 $.each(v, function(index, value){
	 		        			feature_checkboxes = feature_checkboxes + "<li><input type='checkbox' id='feature' name='selected_features' value='"+value+"' checked >"+value+"</li>";	  
			 		        	  });
	 		        	  }
	 		         });  
	 		         algo_checkboxes = algo_checkboxes + "</ul>";
	 		        feature_checkboxes = feature_checkboxes + "</ul>";
	 		         algolist.html(algo_checkboxes);
	 		         featurelist.html(feature_checkboxes);
	 		        $('#algorithms_div').removeClass('hidden_div').addClass('display_div');
	 		       	$('#features_div').removeClass('hidden_div').addClass('display_div');
	 		      	$('#more_config_choice').removeClass('hidden_div').addClass('display_div');
	 		      	$('#submit_div').removeClass('hidden_div').addClass('display_div');
	 		      	$('#common_params_div').removeClass('hidden_div').addClass('display_div');
	 		      	$('#more_config_choice').removeClass('hidden_div').addClass('display_div');
	 		       }
	 			});	
   			});
    	 	
	      $( "body" ).on("change","#all_algos",function(){
	    	 $('input:checkbox[id="algo"]').prop('checked', this.checked);
	       });
	      
	      $("body").on("change", "#algo", function(){
	    	 if(!this.checked){
	    		 $("#all_algos").prop('checked', false);
	    	 } 
	      });
	      
	      $( "body" ).on("change","#all_features",function(){
		    	 $('input:checkbox[id="feature"]').prop('checked', this.checked);
		       });
	      $("body").on("change", "#feature", function(){
		    	 if(!this.checked){
		    		 $("#all_features").prop('checked', false);
		    	 } 
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
    	 		$('#advanced_settings_link').removeClass('display_div').addClass('hidden_div');
    	 	});
    	 	
    	 	$("#hide_advanced_settings").click(function(){
    	 		
    	 		$('#advanced_settings').removeClass('display_div').addClass('hidden_div');
    	 		$('#advanced_settings_link').removeClass('hidden_div').addClass('display_div');

    	 	});
    	 	
    	 	$('input:radio[name="problem.libraryProblem"]').change(function(){
    	 		$('#advanced_settings').removeClass('display_div').addClass('hidden_div');
    	 		$('#hide_more_config_choice').removeClass('display_div').addClass('hidden_div');
    	 		reset_common_settings();
    	 		reset_custom_problem_settings();
    	 		reset_library_problem_settings();
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
      				});$('#common_params_div').removeClass('hidden_div').addClass('display_div');
      				selectSubProb.append(option);
      				$('#library_problems_div').removeClass('hidden_div').addClass('display_div');
      				$('#problem_div').removeClass('hidden_div').addClass('display_div');
      				$('#custom_problem_div').removeClass('display_div').addClass('hidden_div');
      				$('#more_config_choice').removeClass('display_div').addClass('hidden_div');
	 		      	$('#submit_div').removeClass('display_div').addClass('hidden_div');
	 		      	$('#common_params_div').addClass('hidden_div').removeClass('display_div');
      				
    	 		}else{
    	 			$('#algorithms_div').removeClass('display_div').addClass('hidden_div');
    	 			$('#features_div').removeClass('display_div').addClass('hidden_div');
    	 			$('#library_problems_div').removeClass('display_div').addClass('hidden_div');
    	 			$('#custom_problem_div').removeClass('hidden_div').addClass('display_div');
    	 			$('#more_config_choice').removeClass('hidden_div').addClass('display_div');
    	 			$('#submit_div').removeClass('hidden_div').addClass('display_div');
    	 			$('#common_params_div').removeClass('hidden_div').addClass('display_div');
    	 		}
    	 	});
    	 	
    	 			$('#foorprint_form').submit(function(){
    	 				 valid = true;
    	 				 problem_type = $('input[name="problem.libraryProblem"]:checked').val();
    	 				 if(problem_type == 'true'){
    	 					 if ($('#new_algo').prop('checked') == true){
    		 				     if($("#performance_file_library").val() == ''){
    		 				         $('#library_performance_file_error').html('Please upload performance file.');
    		 				        	valid = false;
    		 				     }else if($('#performance_file_library').val().toLowerCase().lastIndexOf(".csv")==-1){
    		 				    	$('#library_performance_file_error').html('Only CSV files are allowed.');
    		 				    	valid = false;
    		 				    }else{
    		 				    	$('#library_performance_file_error').html('');
    		 				    } 
    		 				     
    	 					 }
    	 					 if($('#new_feature').prop('checked') == true){
    	 						 if($("#feature_file_library").val() == ''){
    	 							 $('#library_feature_file_error').html('Please upload features file');
    	 							 valid = false;
    	 						 }else if($('#feature_file_library').val().toLowerCase().lastIndexOf(".csv")==-1){
    		 				    	$('#library_feature_file_error').html('Only CSV files are allowed.');
    		 				    	valid = false;
    		 				    }else{
        	 						$('#library_feature_file_error').html('');    		 				    	
    		 				    } 
    	 					 }
    	 				 }else{
    	 					 if($('#problem_name').val() == ''){
    	 						$('#problem_name_error').html('Please specify the name of the problem. ')	 
    	 					 }else{
    	 						$('#problem_name_error').html('')
    	 					 }
    	 					 
    	 					 
		 				     if($("#performance_file_custom").val() == ''){
		 				         $('#custom_performance_file_error').html('Please upload performance file.');
		 				        	valid = false;
		 				     }else if($('#performance_file_custom').val().toLowerCase().lastIndexOf(".csv")==-1){
		 				    	$('#custom_performance_file_error').html('Only CSV files are allowed.');
		 				    	valid = false;
		 				    }else{
		 				    	$('#custom_performance_file_error').html('');
		 				    } 
	 						 if($("#feature_file_custom").val() == ''){
	 							 $('#custom_feature_file_error').html('Please upload features file');
	 							 valid = false;
	 						 }else if($('#feature_file_custom').val().toLowerCase().lastIndexOf(".csv")==-1){
		 				    	$('#custom_feature_file_error').html('Only CSV files are allowed.');
		 				    	valid = false;
		 				    }else{
		 				    	$('#custom_feature_file_error').html('');
		 				    } 
    	 				 }
    	 				 if($('#optimization_criteria').val() == ''){
    	 					$('#optimization_criteria_error').html('Please select Optimization Criteria.');
    	 					valid = false;
    	 				 }else{
    	 					$('#optimization_criteria_error').html('');
    	 				 }
    	 				 
//     	 			    jQuery('html, body').stop().animate({
//     	 			       'scrollTop': $target.offset().top - offset}, // set offset value here i.e. 50
//     	 			       900, 
//     	 			       'swing',function () {
//     	 			       window.location.hash = target ;
//     	 			       });
    	 			    
    	 				 if($('#performance_criteria').val() == ''){
    	 					$('#performance_criteria_error').html('Please select Performance Criteria. ');
    	 					valid = false;
    	 				 }else{
    	 					$('#performance_criteria_error').html('');
    	 					if($('#performance_criteria').val() == 'abs'){
    	 						if($('#threshold').val() == ''){
    	 							$('#performance_threshold_error').html('Please define a threshold value.');
    	 							valid = false;
    	 						}else{
    	 							$('#performance_threshold_error').html('');
    	 						}
    	 					}
    	 				 }
	 				    return valid;
    	 			});
    	 			
    	 				$("#advanced_settings_link").click(function() {
    	 				   scrollToAnchor('advanced_settings');
    	 				});
    	 				
    	 				$("#hide_advanced_settings").click(function() {
     	 				   scrollToAnchor('page_start_anchor');
     	 				});
    	 				  
    	 						    
   				});
	    
    	 				function scrollToAnchor(aid){
    	 				    var aTag = $("a[id='"+ aid +"']");
    	 				    $('html,body').animate({scrollTop: aTag.offset().top},'slow');
    	 				}
    	 				
    	    	 	function reset_common_settings(){
    	    	 		$('#optimization_criteria').prop('selectedIndex',0);
    	    	 		$('#optimization_criteria_error').html('');
    	    	 		$('#performance_criteria').prop('selectedIndex',0);
    	    	 		$('#performance_criteria_error').html('');
    	    	 		$("#threshold").val("0.05");
    	    	 		$('#threshold_error').html('');
    	    	 		$("#performance_threshold").removeClass('display_div').addClass('hidden_div');
    	    	 		$('#more_config_choice').removeClass('hidden_div').addClass('display_div');
    	    	 	}
    	    	 	function reset_custom_problem_settings(){
    	    	 		$('#problem_name').val('');
    	    	 		$('#problem_name_error').html('');
    	    	 		$('#performance_file_custom').val('');
    	    	 		$('#custom_performance_file_error').html('');
    	    	 		$('#feature_file_custom').val('');
    	    	 		$('#custom_feature_file_error').html('');
    	    	 	}
    	    	 	
    	    	 	function reset_library_problem_settings(){
    	    	 		$('#common_params_div').removeClass('display_div').addClass('hidden_div');
    	    	 		$('#performance_file_library').val('');
    	    	 		$('#feature_file_library').val('');
    	    	 		$('#library_performance_file_error').html('');
    	    	 		$('#library_feature_file_error').html('');
    	    	 		$('#new_feature_file_div').removeClass('display_div').addClass('hidden_div');
    	    	 		$('#new_algo_performance_file_div').removeClass('display_div').addClass('hidden_div');
    	    	 	}


	</script>
</head>
<body>
	function scrollToAnchor(aid){
    var aTag = $("a[name='"+ aid +"']");
    $('html,body').animate({scrollTop: aTag.offset().top},'slow');
}
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
			<form:form id="foorprint_form" action="${action}" commandName="algorithmParams" method="POST" enctype="multipart/form-data" >
					<a id="page_start_anchor"></a>
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
							<div id="algorithms" class="algoandfeature_div"></div>
							<div id="new_algo_performance_file_div" class="hidden_div">
								<fieldset>
									<div>
										<label for="performanceFile"><strong>Upload Performance File</strong></label>
										<div>
											<form:input type="file" path="performanceFile" id="performance_file_library"  />
											<div id="library_performance_file_error" class="error ">
					                            <form:errors path="performanceFile" />
					              		    </div>
				              		    </div>
			              		    </div>
								</fieldset>
							</div>
						</div>
						<div id="features_div" class="twocolumnform_secondcolumn hidden_div" >
						<h2>Select the features you want to use in your analysis</h2>
						<div id="features" class="algoandfeature_div"></div>
							<fieldset>
								<div id="new_feature_file_div" class="hidden_div">
									<label for="feature_file"><strong>Upload Feature File</strong></label>
									<div>
										<form:input type="file" path="featureFile" id="feature_file_library" />
										<div id="library_feature_file_error" class="error"></div>
			              		    </div>
								</div>
							</fieldset> 
						</div>
					</div>
					
					<div id="custom_problem_div" class="hidden_div">
						<fieldset>
							<div>
								<label for="problem_name"><strong>Problem Name</strong></label>
								<form:input id="problem_name" path="customProblemName" type="text" />
								<div class="error" id="problem_name_error"></div>
							</div>
							<div id="custom_problem_file_div" class="twocolumnform_firstcolumn">
								<label for="performanceFile"><strong>Upload Performance File</strong></label>
								<div id="custom_performance_file_div">
									<form:input type="file" path="performanceFile" id="performance_file_custom" />
									<div class="error" id="custom_performance_file_error"></div>
		              		    </div>
	              		    </div>
	              		    <div id="custom_feature_file_div" class="twocolumnform_secondcolumn">
								<label for="feature_file"><strong>Upload Feature File</strong></label>
								<div>
									<form:input type="file" path="featureFile" id="feature_file_custom" />
									<div class="error" id="custom_feature_file_error">
			                            <form:errors path="featureFile" />
			              		    </div>
		              		    </div>
							</div>
						</fieldset>
					</div>
					
					<div id="common_params_div" class="hidden_div">
						<fieldset>
						  	<div class="twocolumnform_firstcolumn">
								<label for="optimization_criteria" data-required="true"> <strong>Optimization Criteria</strong><span class="tooltip"><img src="<c:url value="resources/images/info.png" />" width="20" height="20" >
 						<span class="tooltiptext">Select whether your performance measure is cost to be minimized or utility to be maximized. </span></span></label>
								
								<div>
									<form:select id="optimization_criteria" path="algorithm.optimizationCriteria">
										<form:option selected="selected" value="" label="Select Optimization Criteria"  />
										<form:options items="${optimizationCriteria}"/>
									</form:select>
								</div>
								<div class="error" id="optimization_criteria_error"></div>
							</div>
						
							<div class="twocolumnform_secondcolumn">
								<label for="performance_criteria" data-required="true"><strong>Performance Criteria</strong><span class="tooltip"><img src="<c:url value="resources/images/info.png" />" width="20" height="20" >
 						<span class="tooltiptext">Select whether good performance is considered independent of available results, i.e. in absolute terms, or considering
 						the best performance result available i.e. in relative terms. </span></span></label>
								<div>
									<form:select id="performance_criteria" path="algorithm.performanceCriteria">
										<option selected="selected" value="" label="Select Performance Criteria" />
										<form:options items="${performanceCriteria}"/>
									</form:select>
								</div>
								<div class="error" id="performance_criteria_error"></div>
							</div>
							
							<div id="performance_threshold" class="hidden_div twocolumnform_firstcolumn">
								<label for="threshold"><strong>Performance Threshold</strong><span class="tooltip"><img src="<c:url value="resources/images/info.png" />" width="20" height="20" >
 						<span class="tooltiptext">Please indicate a value that represents the boundary between good and bad performance</span></span></label>
								<div>
									<form:input id="threshold" path="algorithm.performanceThreshold" style="width:99%;"/>
								</div> 
								<div class="error" id="performance_threshold_error"></div>  
							</div>
						</fieldset>
					</div>

					
					<div id="more_config_choice" class="twocolumnform_firstcolumn hidden_div" style="padding-top:30px;">
						<a id="advanced_settings_link" href="#" style="text-decoration:none;"><i class="arrow down"></i> Advanced Settings </a> 
					</div>
					
					<div id="advanced_settings" class="hidden_div">
					<a id="advanced_settings"></a>
					<fieldset class="bordered_fieldset">
					 	<legend class="bordered_legend">Advanced Settings</legend>
					 	<div style="float: right; clear:both;">
					 	
					 	<img id="hide_advanced_settings" alt="close" src="<c:url value="/resources/images/close.jpeg"/>" width="50px" height="50px">
					 	</div>
					 	
						<div class="twocolumnform_firstcolumn">
							<label><span class="tooltip">Beta Threshold<span class="tooltiptext">Please indicate the minimal fraction of good performing algorithms within the portfolio 
							which will make the instance easy overall.</span></span></label>
							<form:input path="betaThreshold" style="width:100%"/>
						</div>
						
						<div>
							<label><span class="tooltip"><h2>Diversity</h2><span class="tooltiptext">Checks whether there is a low number of unique values for a given feature. 
								if this number is lower than a diversity threshold, discard the feature. </span></span></label>
							<div class="twocolumnform_firstcolumn">
								<label>Apply Diversity</label>
								<form:select path="diversity">
									<form:option value="true">Yes</form:option>
									<form:option value="false">No</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Diversity Threshold<span class="tooltiptext">What is the minimum percentage allowed of repeated values?</span></span></label>
								<form:input path="diversityThreshold" style="width:100%;"/>
							</div>
						</div>
						
						<div>
							<label><span class="tooltip"><h2>Correlation</h2><span class="tooltiptext">Compares the correlation between features and algorithm performance. Keep only the 
								highest correlated features per algorithm. </span></span></label>
							<div class="twocolumnform_firstcolumn">
								<label>Apply Correlation</label>
								<form:select path="coorelation">
									<form:option value="true">Yes</form:option>
									<form:option value="false">No</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Correlation Threshold<span class="tooltiptext">Top N features (by correlation) per algorithm that are selected</span></span></label>
								<form:input path="correlationThreshold" style="width:100%"/>
							</div>
						</div>
						
						<div>
							<label><span class="tooltip"><h2>Clustering</h2><span class="tooltiptext">Calculates the correlation between features and use it as a distance matrix to find clusters of features. Uses silhoute 
								analysis to determine the smallest number of clusters. To determine which features to use, we train a random forest model that takes one feature per cluster, and predict
								whether the performance of an algorithm is good or bad. The subset of features which produce most accurate model will be selected. </span></span></label>
							<div class="twocolumnform_firstcolumn">
								<label>Apply Clustering</label>
								<form:select path="clustering">
									<form:option value="true">Yes</form:option>
									<form:option value="false">No</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Use Parallel<span class="tooltiptext">Use parallel computing to best clustering</span></span></label>
								<form:select path="useParallel">
									<form:option value="true">Yes</form:option>
									<form:option value="false">No</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Maximum Clusters<span class="tooltiptext">Maximum number of clusters allowed</span></span></label>
								<form:input path="defaultMaximumClusters" style="width:100%"/>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Silhoute Threshold<span class="tooltiptext">Minimum accepted value for the average silhoute value</span></span></label>
								<form:input path="silhouteThreshold" style="width:100%"/>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Random Forest Trees<span class="tooltiptext">Number of trees a model has </span></span></label>
								<form:input path="numberOfTrees" style="width:100%"/>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Maximum Iterations<span class="tooltiptext">Number of iterations to train the clustering</span></span></label>
								<form:input path="maximumIterations" style="width:100%"/>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Cluster Replicates<span class="tooltiptext">Number of time the clustering is attempted </span></span></label>
								<form:input path="replicates" style="width:100%"/>
							</div>

						</div>
						<div>
							<label><h2>Dimensionality Reduction</h2></label>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Keep the optimization routine Silent<span class="tooltiptext"></span></span></label>
								<form:select path="DispFinal">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">PBLDR Attempts<span class="tooltiptext">Number of attempts made to find the best dimensionality reduction</span></span></label>
								<form:input path="attemptsByPBLDR" style="width:100%"/>
							</div>
														
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Calculate Analytical Solution<span class="tooltiptext">Calculate the analytical solution of the dimensionality reduction</span></span></label>
								<form:select path="calculateAnalytics">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
<!-- 							<div class="twocolumnform_firstcolumn"> -->
<!-- 								<label><span class="tooltip">Parallel Evaluation<span class="tooltiptext">What does it mean... </span></span></label> -->
<%-- 								<form:select path="parallelEval"> --%>
<%-- 									<form:option value="true">True</form:option> --%>
<%-- 									<form:option value="false">False</form:option> --%>
<%-- 								</form:select> --%>
<!-- 							</div> -->
							<h2>FootPrint Settings</h2>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Density Threshold<span class="tooltiptext"> Minimum density an area can have to be considered as part of a footprint</span></span></label>
								<form:input path="densityThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Purity Threshold<span class="tooltiptext">Minimum purity an area can have to be considered as part of a footprint </span></span></label>
								<form:input path="purityThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Lower Distance Threshold<span class="tooltiptext">Size of the smallest edge of an area</span></span></label>
								<form:input path="lowerDistanceThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Higher Distance Threshold<span class="tooltiptext">Size of the largest edge of an area</span></span></label>
								<form:input path="higherDistanceThreshold" style="width:100%"/>
							</div>
							


							
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Stopping Criteria<span class="tooltiptext">Stop if the fitness is <i>n</i> </span></span></label>
								<form:input path="stoppingCriteria" style="width:100%"/>
							</div>
							
<!-- 							<div class="twocolumnform_secondcolumn"> -->
<!-- 								<label><span class="tooltip">Maximum Multiple Restarts Allowed<span class="tooltiptext">Allow multiple restarts?</span></span></label> -->
<%-- 								<form:input path="maxRestartFunEvals" style="width:100%"/> --%>
<!-- 							</div> -->
							
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Maximum Evaluations<span class="tooltiptext">Maximum number of evaluations</span></span></label>
								<form:input path="maxFunEvals" style="width:100%"/>
							</div>
						</div>
						</fieldset>
					</div>
					<div id="submit_div" class="twocolumnform_firstcolumn hidden_div">
						<button type="submit" class="button cta">Submit</button>
					</div>
			</form:form>
			</div>
		</section>
        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>