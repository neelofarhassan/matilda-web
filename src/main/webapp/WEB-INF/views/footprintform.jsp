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
  <%@include file="/includes.jsp" %>
<!--   <title> Matilda </title> -->
<!--   <link rel="stylesheet" href="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.css"> -->
<%--   <link rel="stylesheet" href="<c:url value="/resources/css/matilda.css" /> "> --%>
<!--   <script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script> -->
<!--   <script src="https://code.jquery.com/jquery-1.9.1.min.js"></script> -->
  <script type="text/javascript">
   	var algoFeaturesURL = "<c:url value="/showAlgosFeatures" />";
   	var optimizationProblemsList = '<%= request.getAttribute("optimizationProblems")%>';
   	var modelLearningList = '<%= request.getAttribute("modelLearning")%>';
  </script>
  <script type="text/javascript" src="<c:url value="/resources/scripts/matilda.js" /> "></script>
</head>
<body>
<!-- 	function scrollToAnchor(aid){ -->
<!--     var aTag = $("a[name='"+ aid +"']"); -->
<!--     $('html,body').animate({scrollTop: aTag.offset().top},'slow'); -->
<!-- } -->
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	  <%@include file="authheader.jsp" %>
      <div role="main">
		<%@include file="/menu.jsp" %>
		<div>
			<header>
                <h1>Algorithm Analysis</h1>
        	</header>
        
        </div>
       
        <section>
        
        <div id="footprint_form_container">
       <div id="loader" class="hidden_div"></div>
	        <p>Visualize the strengths and weaknesses of an algorithm across instance space. <a href="<c:url value="/submission-guidelines" />">Submission Guidelines</a>
	        provide a detailed description of how to submit your data for analysis.</p>
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
									<form:input type="file" path="customPerformanceFile" id="performance_file_custom" />
									<div class="error" id="custom_performance_file_error"></div>
		              		    </div>
	              		    </div>
	              		    <div id="custom_feature_file_div" class="twocolumnform_secondcolumn">
								<label for="feature_file"><strong>Upload Feature File</strong></label>
								<div>
									<form:input type="file" path="customFeatureFile" id="feature_file_custom" />
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
								<label for="optimization_criteria" data-required="true"> <strong>Optimization Criteria</strong><span class="tooltip"><img src="<c:url value="/resources/images/info.png" />" width="20" height="20" >
 								<span class="tooltiptext">Select whether your performance measure is cost to be minimized or utility to be maximized. </span></span></label>
<!-- 								select if the good performance is independent of algorithm results i.e. in absolute terms considering non-optimal solutions. or, in relative terms compared to other algorithms. -->
								<div>
									<form:select id="optimization_criteria" path="algorithm.optimizationCriteria">
										<form:option selected="selected" value="" label="Select Optimization Criteria"  />
										<form:options items="${optimizationCriteria}"/>
									</form:select>
								</div>
								<div class="error" id="optimization_criteria_error"></div>
							</div>
						
						
							<div class="twocolumnform_secondcolumn">
								<label for="performance_criteria" data-required="true"><strong>Performance Criteria</strong><span class="tooltip"><img src="<c:url value="/resources/images/info.png" />" width="20" height="20" >
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
							
							<div id="performance_metric" class="twocolumnform_firstcolumn">
								<label for="performance_metric_label"><strong>Performance Metric Label</strong><span class="tooltip"><img src="<c:url value="/resources/images/info.png" />" width="20" height="20" >
 								<span class="tooltiptext">Please give a meaningful label to your performance metric, for instance, Number of colours, Normalized number of colors, accuracy, error etc.</span></span></label>
								<div>
									<form:input id="performance_metric_label" path="algorithm.performanceMetricLabel" rows="5" class="metric_description"/>
								</div> 
								<div class="error" id="performance_metric_label_error"></div>  
							</div>
							
							<div id="performance_threshold" class="hidden_div twocolumnform_secondcolumn">
								<label for="threshold"><strong>Performance Threshold</strong><span class="tooltip"><img src="<c:url value="/resources/images/info.png" />" width="20" height="20" >
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
						 	<img id="hide_advanced_settings" alt="close" src="<c:url value="/resources/images/close.jpeg" />" width="50px" height="50px">
					 	</div>
					 	
						<div class="full_available_width">
							<label><span class="tooltip">Beta Threshold<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Please indicate the minimal fraction of good performing algorithms within the portfolio 
							which will make the instance easy overall.</span></span></label>
							<form:input path="betaThreshold" style="width:47%"/>
						</div>
						
						<div>
							<div class="full_available_width">
								<h2 style="display:inline;">Diversity</h2><span class="tooltip"><img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Checks whether there is a low number of unique values for a given feature. 
								if this number is lower than a diversity threshold, discard the feature. </span></span>
								</div>
							<div class="twocolumnform_firstcolumn">
								<label>Apply Diversity</label>
								<form:select path="diversity">
									<form:option value="true">Yes</form:option>
									<form:option value="false">No</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Diversity Threshold<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">What is the minimum percentage allowed of repeated values?</span></span></label>
								<form:input path="diversityThreshold" style="width:100%;"/>
							</div>
						</div>
						
						<div>
							<div class="full_available_width">
								<h2 style="display:inline;">Correlation</h2><span class="tooltip"><img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Compares the correlation between features and algorithm performance. Keep only the 
								highest correlated features per algorithm. </span></span>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label>Apply Correlation</label>
								<form:select path="coorelation">
									<form:option value="true">Yes</form:option>
									<form:option value="false">No</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Correlation Threshold<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Top N features (by correlation) per algorithm that are selected</span></span></label>
								<form:input path="correlationThreshold" style="width:100%"/>
							</div>
						</div>
						
						<div>
							<div class="full_available_width">
								<h2 style="display:inline;">Clustering</h2><span class="tooltip"><img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Calculates the correlation between features and use it as a distance matrix to find clusters of features. Uses silhoute 
								analysis to determine the smallest number of clusters. To determine which features to use, we train a random forest model that takes one feature per cluster, and predict
								whether the performance of an algorithm is good or bad. The subset of features which produce most accurate model will be selected. </span></span>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label>Apply Clustering</label>
								<form:select path="clustering">
									<form:option value="true">Yes</form:option>
									<form:option value="false">No</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Use Parallel<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Use parallel computing to best clustering</span></span></label>
								<form:select path="useParallel">
									<form:option value="true">Yes</form:option>
									<form:option value="false">No</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Maximum Clusters<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Maximum number of clusters allowed</span></span></label>
								<form:input path="defaultMaximumClusters" style="width:100%"/>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Silhoute Threshold<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Minimum accepted value for the average silhoute value</span></span></label>
								<form:input path="silhouteThreshold" style="width:100%"/>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Random Forest Trees<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Number of trees a model has </span></span></label>
								<form:input path="numberOfTrees" style="width:100%"/>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Maximum Iterations<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Number of iterations to train the clustering</span></span></label>
								<form:input path="maximumIterations" style="width:100%"/>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Cluster Replicates<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Number of time the clustering is attempted </span></span></label>
								<form:input path="replicates" style="width:100%"/>
							</div>

						</div>
						<div>
							<div class="full_available_width">
								<h2 style="display:inline;">Dimensionality Reduction</h2>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Keep the optimization routine Silent?<span class="tooltiptext"></span></span></label>
								<form:select path="DispFinal">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">PBLDR Attempts<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Number of attempts made to find the best dimensionality reduction</span></span></label>
								<form:input path="attemptsByPBLDR" style="width:100%"/>
							</div>
														
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Calculate Analytical Solution<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Calculate the analytical solution of the dimensionality reduction</span></span></label>
								<form:select path="calculateAnalytics">
									<form:option value="true">True</form:option>
									<form:option value="false">False</form:option>
								</form:select>
							</div>
							<div class="full_available_width">
								<h2 style="display:inline;">FootPrint Settings</h2>
							</div>
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Density Threshold<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext"> Minimum density an area can have to be considered as part of a footprint</span></span></label>
								<form:input path="densityThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Purity Threshold<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Minimum purity an area can have to be considered as part of a footprint </span></span></label>
								<form:input path="purityThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_firstcolumn">
								<label><span class="tooltip">Lower Distance Threshold<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Size of the smallest edge of an area</span></span></label>
								<form:input path="lowerDistanceThreshold" style="width:100%"/>
							</div>
							
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Higher Distance Threshold<img src="<c:url value="/resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">Size of the largest edge of an area</span></span></label>
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
							
							<div class="twocolumnform_secondcolumn">
								<label><span class="tooltip">Maximum Evaluations<span class="tooltiptext">Maximum number of evaluations</span></span></label>
								<form:input path="maxFunEvals" style="width:100%"/>
							</div>
						</div>
						</fieldset>
					</div>
					<div id="submit_div" class="twocolumnform_firstcolumn hidden_div">
						<button id="footprint_submit" type="submit" class="button cta">Submit</button>
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