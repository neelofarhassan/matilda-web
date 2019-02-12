
$(document).ready(function() {
	var chart1 = "";
	var chart2 = "";
	var option1 = "";
	var chart3="";
	var chart4="";
	EXPORT_WIDTH=800;
	$('#cancel_job').click( function(e) {
		e.preventDefault();
		if (confirm("Are you sure you want to cancel the current execution?")) {
			  window.location.href=jobCancellationURL;
			  } else {
			    
			  }
		return false; 
		});
	
		$('#feature_select').change(function(){
			var feature = $(this).val();
			alert(feature);
		});
		
	      $( "body" ).on("change","#feature_select",function(){
		    	var selected_feature = $(this).val();
		    	showDemoGraph(userName, problemName, selected_feature);
		     });
	      
  	 	$("#problem").change(function () {
	   		var problemName = $(this).val();
	   		var algolist = $('#algorithms'), algo_checkboxes="";
	   		var featurelist = $('#features'), feature_checkboxes="";
	   		algolist.empty();
	   		featurelist.empty();
	 		$.ajax({
	 		     type: "POST",
	 		     url: algoFeaturesURL,
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
      				
      				option = option + "<option value='null' selected>Select a problem</option>";
      				option = option + "<option value='opt' disabled>Optimization Problems</option>";
      				$.each(JSON.parse(optimizationProblemsList), function (k, v) {
	      				 console.log(k + " "+ v);
	      				 option = option + "<option value='"+k+"'>&nbsp;&nbsp;&nbsp;&nbsp;"+v+"</option>";
      				});
      				option = option + "<option value='lmf' disabled>Learning and Model Fitting</option>";
      				$.each(JSON.parse(modelLearningList), function (k, v) {
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
    	 	
    	 				$('#footprint_submit').click(function(){
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
    	 						$('#problem_name_error').html('Please specify the name of the problem. ');
    	 						valid = false;
    	 					 }else{
    	 						 var validName = new RegExp('^[a-zA-Z0-9-\\s]+$');
    	 						 if(validName.test($('#problem_name').val())){
    	 							 $('#problem_name_error').html('');
    	 						}else{
    	 							console.log('error in problem name');
    	 							$('#problem_name_error').html('Only letters, numbers, hyphen and spaces are allowed.');
    	 							valid = false;
    	 						}
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
    	 				 if($('#performance_metric_label').val() == ''){
    	 					$('#performance_metric_label_error').html('Please give a meaningful label to your performance metric.');
    	 					 valid = false;
    	 				 }else{
    	 					$('#performance_metric_label_error').html('');
    	 				 }
    	 				 if(valid){
    	 					 console.log('before submit');
    	 					 $('#foorprint_form').submit();
    	 					 console.log('after submit');
    	 					 $('#footprint_form_container').css({opacity: 0.5});
     	 					 $("#foorprint_form :input").prop("disabled", true);
    	 						$('#loader').removeClass('hidden_div').addClass('display_div');
//    	 						$('#loader').scrollTop($('#loader').height());
    	 						var position = $("#footprint_form_container").position();
    	 						 $('html,body').animate({scrollTop: position.top},'slow');
    	 					
    	 				 }
    	 			});
    	 			
    	 				$("#advanced_settings_link").click(function() {
    	 				   scrollToAnchor('advanced_settings');
    	 				});
    	 				
    	 				$("#hide_advanced_settings").click(function() {
     	 				   scrollToAnchor('page_start_anchor');
     	 				});

    	 				
    	 				$('#export').click(function() {
//    	 				    Highcharts.exportCharts([chart1, chart2]);
//    	 					save_chart(chart1, 'chart');
    	 					$('#container').highcharts(settings);
    	 					console.log('into local export function');
    	 			        var chart = $('#container').highcharts();
    	 		            chart.exportChart({
    	 		            type: 'image/png',
    	 		            filename: 'chart1'
    	 		         });
    	 					
    	 					
//    	 					Highcharts.exportCharts([chart1, chart2], "");
    	 				});
    	 				
    	 				
   
    	 				
    	 				$('#export-test').click(function() {
//    	 				    Highcharts.exportCharts([chart1, chart2], {type: 'application/pdf'});
//    	 					console.log('into click function');
//    	 					exportZippedCharts();
//    	 					Highcharts.exportCharts([chart1, chart2]);
//    	 					$('#graph1').highcharts(chart1);
//    	 					console.log('into local export function');
//    	 			        var chart = $('#graph1').highcharts();
//    	 		            var exported_chart1 = chart.exportChart({
//    	 		            type: 'image/png',
//    	 		            filename: 'chart1'
//    	 		         });
    	 					exportZippedCharts();
    	 				});
  

    	 				$('#export-jpeg').click(function() {
    	 					console.log('jpg export');
//    	 					 Highcharts.exportCharts();
    	 					exportZippedCharts('image/jpeg');
    	 				});
    	 				
    	 				$('#export-pdf').click(function() {
    	 					console.log('pdf export');
//    	 					 Highcharts.exportCharts({
//    	 				        type: 'application/pdf'
//    	 				    });
    	 					exportZippedCharts('application/pdf');
    	 				});
    	 				
    	 			    $('#save_btn').click(function() {
    	 			    	save_chart($('#container').highcharts(), 'chart');
    	 			    });

    	 			});


var settings =  
{
 "chart": {
   "type":"line"
},
"xAxis": { 
  "endOnTick":true
},
"series":[
   {"name":"series1","data":[[1,1200],[2,2200],[3,3200],[4,1800],[5,1500]]},
   {"name":"series2","data":[[1,1050],[2,2050],[3,1650],[4,1450],[5,1350]]},
   {"name":"series3","data":[[1,1250],[2,2250],[3,1850],[4,1650],[5,1550]]}]
}


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

function showExecutionLogs(user, problem, modificationTime, lineNumber, logContents, methodCalls){
	var endOfFile = "";
	var scriptSuccess = "";
	var $logsdiv = $("#logs");
	var height;
	$.ajax({
		type: "get",
		url: logFileURL,
		data: {userName:user, problemName:problem, lastModified:modificationTime, lastLineRead:lineNumber},
		success: function(data){
			if(!$.trim(data)){
				$('#logs').html('<h2><font color="red"> Sorry, some problem occured while executing your code. Please <a href="<c:url value="/contact-us" />"> contact </a> website administation.</font><h2>');
			}else{
			console.log('returned data: ' + data);
			$.each(data, function(k,v){
				if(k == 'true'){
				console.log('inside true')
				endOfFile = v[0];
				lineNumber = v[1];
				currentLogContents = v[2];
				modificationTime = v[3];
				scriptSuccess = v[4];
				console.log('script Success message: ' + scriptSuccess);
				logContents = logContents + currentLogContents;
				console.log('method calls: ' + methodCalls + ', last read line: ' + lineNumber + ', modification time: ' + modificationTime + ', end of file: ' + endOfFile);
				}
			});
			logContents = '<div>' + logContents + '</div>';
			waitingDiv = '<div class="progress"><span></span><span></span><span></span><span></span><span></span><span></span><span></span><span></span></div>'; 
			
			$('#logs').html(logContents);
			$logsdiv.scrollTop($logsdiv.height());
			if(endOfFile != 'true' && scriptSuccess != 'false'){
				if(methodCalls > 0){
					$('#logs').append(waitingDiv);
				}
				$logsdiv.scrollTop($logsdiv.height());
				methodCalls = parseInt(methodCalls) + 1;
				 setTimeout(showExecutionLogs, 10000, user, problem, modificationTime, lineNumber, logContents, methodCalls);
			}else{
				
				$logsdiv.scrollTop($logsdiv.height());
				console.log('EOF and scrolling to bottom expected');
//				$('html, body').animate({scrollTop: height}, 'slow');
				hideExecutionCancellationButton();
				if(scriptSuccess == 'false'){
					$('#error_container').html('<p><font color="red"><h2>An error occured !!! </h2></font><br><br>Please see log window for details.</p> ');
				}else{
					showPerformanceTable(user, problem);
					$('#visibility_control_div').removeClass('hidden_div').addClass('display_div');
					showDemoGraph(user, problem, 'feature_1');
				}
			}
			
			
		}
		}
	});
}

function showPerformanceTable(user, problem){
	$.ajax({
		type: "get",
		url: performanceTableURL,
		data: {userName:user, problemName:problem},
		success: function(data){
			var rowCount = 0;
			var table = "<table id='performance_table'>";
			$.each(data, function(k, v){
				table = table + "<tr>";
				var length = v.length;
				if(rowCount == 0){
					$.each(v, function(index, value){
						table = table + "<th>" + value + "</th>";
					});
					table = table + "</tr>";
				}else{
					$.each(v, function(index, value){
						table = table + "<td>" + value + "</td>";
					});
					table = table + "</tr>";
				}
				rowCount = rowCount+1;
			})
			table = table + "</table>";
			$('#table_container').html(table);
		},
		error: function(){
			$('#table_container').html('<p><font color=red>Some error occured while generating footprint performance table. Please see execution logs for the details. </font><p>');
		}
	});
	
	
	$.ajax({
		type: "get",
		url: logFileURL,
		data: {userName:user, problemName:problem, lastModified:modificationTime, lastLineRead:lineNumber},
		success: function(data){
			if(!$.trim(data)){
				$('#logs').html('<h2><font color="red"> Sorry, some problem occured while executing your code. Please <a href="<c:url value="/contact-us" />">contact</a> website administation.</font><h2>');
			}else{
			$.each(data, function(k,v){
				if(k == 'true'){
				
				}
			});
		}
		}
	});
}

function showDemoGraph(userName, problemName, selectedFeature){
	console.log('selected feature: ' + selectedFeature);
	var dataArray = new Array();
	var headings = new Array();
	var features = new Array();
	var algorithms = new Array();
	var graphTitle = ''; 
	var x_label = '';
	var y_label = '';
	var tooltipText = '';
	var featureSelectionOptions='';
	var numberOfFeatures;
  	var numberOfAlgorithms;
  	var selectedFeatureName;
	 $.get(coordinatesPath, function(coordinatesData) {
		 $.get(featuresPath, function(featuresData){
			 features = featuresData.split('\n');
			 
			 $.get(algosPath, function(algosData){
				 algorithms = algosData.split('\n');
				 
			     var coordinates = coordinatesData.split('\n');
			     $.each(coordinates, function(lineNo, line) {
			    	 if(line){
			    		 var dataCounter = lineNo -1;
				    	 if(lineNo == 0){
				    		 headings = line.split(',');
				    		 x_label = headings[1];
				    		 y_label = headings[2];
				    		 
				    		 
				    		 featureNames = features[0].split(',');
				    		 
				    		 algorithmNames = algorithms[0].split(',');
				    		 
				    		 
				      		 numberOfFeatures = featureNames.length -1;
				      		 numberOfAlgorithms = algorithmNames.length - 1;
				      		 
				    		 tooltipText = x_label + ':{point.x}<br>' + y_label + ':{point.y} <br><br><b>Features</b><br>';
				    		 for(i=1; i<=numberOfFeatures; i++){
				      			 tooltipText = tooltipText + featureNames[i] + ":{point." + featureNames[i] + "}<br>";
				      		 }
				    		 tooltipText = tooltipText + '<br><b>Algorithms -- ' + performanceMetricLabel + '</b><br>';
				    		 for(i=1; i<=numberOfAlgorithms; i++){
				    			 tooltipText = tooltipText + algorithmNames[i] + ":{point." + algorithmNames[i] + "}<br>";
				    		 }
				    		 
				    	 }else{
				    		 var items = line.split(',');
				    		 var dataObject={
				      				 x: parseFloat(items[1]),
				      				 y: parseFloat(items[2])
				      		 };
				    		var colorSelectionCriteria=0;
				    		
					      	var selectedFeatureTokens = selectedFeature.split('_');
					      	var selectionIndex = parseFloat(selectedFeatureTokens[1]);
			    		 
				    		featureSelectionOptions = '<select id="feature_select"><option value=0 disabled> Features </option>';
				    		var featuresList = features[lineNo].split(',');
				      		for(i=1; i<=numberOfFeatures; i++){
				      			dataObject[featureNames[i]]= featuresList[i]; 
					      		featureSelectionOptions = featureSelectionOptions + '<option value=feature_'+i;
				      			if(selectedFeature.startsWith('feature') && selectionIndex == i){
				      				featureSelectionOptions = featureSelectionOptions + ' selected';
				      				selectedFeatureName = featureNames[selectionIndex];
				      			}
				      			featureSelectionOptions = featureSelectionOptions + '>'+featureNames[i]+'</option>';
				      		}
				      		 
				      		featureSelectionOptions = featureSelectionOptions + '<option value=0 disabled> Algorithms </option>';
				      		 var algorithmsList = algorithms[lineNo].split(',');
				      		 for(i=1; i<=numberOfAlgorithms; i++){
				      			 dataObject[algorithmNames[i]]= algorithmsList[i]; 
						      		featureSelectionOptions = featureSelectionOptions + '<option value=algorithm_'+i;
					      			if(selectedFeature.startsWith('algorithm') && selectionIndex == i){
					      				featureSelectionOptions = featureSelectionOptions + ' selected';
					      				selectedFeatureName = algorithmNames[selectionIndex];
					      			}
					      			featureSelectionOptions = featureSelectionOptions + '>'+algorithmNames[i]+'</option>';

				      		 }
				      		featureSelectionOptions = featureSelectionOptions + '</select>';
				      		
				      		if(selectedFeature.startsWith('feature')){
					      		colorSelectionCriteria = featuresList[selectionIndex];
					      	}else{
					      		colorSelectionCriteria = algorithmsList[selectionIndex];
					      	}
					      		 var color;
					      		 if(colorSelectionCriteria < 0.2){
					      			 color = 'indigo';
					      		 }else if(colorSelectionCriteria < 0.4){
					      			 color = 'DodgerBlue ';
					      		 }else if(colorSelectionCriteria < 0.6){
					      			 color = 'GreenYellow ';
					      		 }else if(colorSelectionCriteria < 0.8){
					      			 color= 'orange';
					      		 }else{
					      			 color='yellow';
					      		 }
					      		dataObject['color']=color; 					      		 
								dataArray[dataCounter]= dataObject;
								graphTitle = featureNames[selectedFeature];
				    	 }
			    	 }
			     });
////				  $('#graph_body').highcharts({
////			     chart1 = new Highcharts.Chart({
			     chart1 = {
				        chart: {
				        	renderTo: 'graph1',
				            type: 'scatter',
				            zoomType: 'xy'
				        },
				        colors: [
				            'indigo',
				            'DodgerBlue',
				            'GreenYellow',
				            'orange',
				            'yellow'
				        ],
				        colorAxis: {
//		 		            min: 0,
//		 		            max: 100,
//		 		            minColor: 'yellow',
//		 		            maxColor: 'red'             
				            dataClassColor: 'category',
						                    dataClasses: [{
						                        to: 0.2
						                    }, {
						                        from: 0.2,
						                        to: 0.4
						                    }, {
						                        from: 0.4,
						                        to: 0.6
						                    },{
						                    	from:0.6,
						                    	to:0.8
						                    },{
						                    	from:0.8,
						                    	to:1.0
						                    }]
				        },
				        series: [{
				        	name: 'Instance Space',
				            showInLegend: false,
				            color: 'red',
				            data: dataArray
				            
				        }],
				        plotOptions: {
				            scatter: {
				                tooltip: {
				                    headerFormat: '<b>Instance Space</b><br>',
				                    pointFormat: tooltipText
				                }
				            }
				        },
				        title: {
				        	text: ""
				        },
				 	   xAxis: {
				      	      title: {
				      	         enabled: true,
				      	         text: x_label
				      	      },
				      	    height: 700,            
				            width: 700,
				      	      startOnTick: true,
				      	      endOnTick: true,
				      	      showLastLabel: true
				      	   },
				      	   yAxis : {
				      		 height: 700,            
				             width: 700,
				             lineWidth: 1,
				      	      title: {
				      	         text: y_label
				      	      }
				      	   },
					      	 exporting: {
				      	    enabled: true,
				      	    sourceWidth: 800,
				      	    sourceHeight: 850
//				      	  fallbackToExportServer: false
				      	}
			     }
//
//			     
//			     chart2 = new Highcharts.Chart({
			     chart2 = {
				        chart: {
				        	renderTo: 'graph2',
				            type: 'scatter',
				            zoomType: 'xy'
				        },
				        colors: [
				            'indigo',
				            'DodgerBlue',
				            'GreenYellow',
				            'orange',
				            'yellow'
				        ],
				        colorAxis: {
//		 		            min: 0,
//		 		            max: 100,
//		 		            minColor: 'yellow',
//		 		            maxColor: 'red'             
				            dataClassColor: 'category',
						                    dataClasses: [{
						                        to: 0.2
						                    }, {
						                        from: 0.2,
						                        to: 0.4
						                    }, {
						                        from: 0.4,
						                        to: 0.6
						                    },{
						                    	from:0.6,
						                    	to:0.8
						                    },{
						                    	from:0.8,
						                    	to:1.0
						                    }]
				        },
				        series: [{
				        	name: 'Instance Space',
				            showInLegend: false,
				            color: 'red',
				            data: dataArray
				            
				        }],
				        plotOptions: {
				            scatter: {
				                tooltip: {
				                    headerFormat: '<b>Instance Space</b><br>',
				                    pointFormat: tooltipText
				                }
				            }
				        },
				        title: {
				        	text: ""
				        },
				 	   xAxis: {
				      	      title: {
				      	         enabled: true,
				      	         text: x_label
				      	      },
				      	    height: 700,            
				            width: 700,
				      	      startOnTick: true,
				      	      endOnTick: true,
				      	      showLastLabel: true
				      	   },
				      	   yAxis : {
				      		 height: 700,            
				             width: 700,
				             lineWidth: 1,
				      	      title: {
				      	         text: y_label
				      	      }
				      	   },
					      exporting: {
				      	    enabled: true,
				      	    sourceWidth: 800,
				      	    sourceHeight: 850
//				      	    fallbackToExportServer: false
				      	}
			     };
			     
				     
			     
//			        // Chart 1
			        $('#graph1').highcharts(chart1);
//			        
//			        // Chart 2
			        $('#graph2').highcharts(chart2);
			     
				    $('#graph_features').html(featureSelectionOptions);
			 });
		 });
	 });
}

function hideExecutionCancellationButton() {
    var tbl = document.getElementById('log_header_table');
    var rows = tbl.getElementsByTagName('tr');
    var cols = rows[0].children;
    var cell = cols[1];
    console.log('captured table data: ' + cell);
    if (cell.tagName == 'td'){
    	cell.style.display = 'none';
    	}
    $('#log_header_table td:nth-child(2)').hide();
    }


//
//Highcharts.getSVG = function(charts, options, callback) {
//    var svgArr = [],
//    		top = 0,
//        width = 0,
//        i,
//        svgResult = function (svgres) {
//            var svg = svgres.replace('<svg', '<g transform="translate(0,' + top + ')" ');
//            svg = svg.replace('</svg>', '</g>');
//            top += charts[i].chartHeight;
//            width = Math.max(width, charts[i].chartWidth);
//            svgArr.push(svg);
//            if (svgArr.length === charts.length) {
//              callback('<svg height="'+ top +'" width="' + width + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + svgArr.join('') + '</svg>');
//            }
//        };
//		for (i = 0; i < charts.length; ++i) {
//				charts[i].getSVGForLocalExport(options, {}, function () { 
//        	console.log("Failed to get SVG");
//       	}, svgResult);
//		}
//};

///**
// * Create a global exportCharts method that takes an array of charts as an argument,
// * and exporting options as the second argument
// */
//Highcharts.exportCharts = function(charts, options) {
//		// Merge the options
//    options = Highcharts.merge(Highcharts.getOptions().exporting, options);    
//		
//    var imageType = options && options.type || 'image/png';
  
//		// Get SVG asynchronously and then download the resulting SVG
//    Highcharts.getSVG(charts, options, function (svg) {
//      Highcharts.downloadSVGLocal(svg,
//        (options.filename || 'chart')  + '.' + (imageType === 'image/svg+xml' ? 'svg' : imageType.split('/')[1]),
//        imageType,
//        options.scale || 2,
//        function () {
//          console.log("Failed to export on client side");
//        });
//    });
//};

///**
// * Create a global getSVG method that takes an array of charts as an
// * argument
// */
//Highcharts.getSVG = function (charts) {
//	charts = [chart1, chart2];
//    var svgArr = [],
//        top = 0,
//        width = 0;
//
//    Highcharts.each(charts, function (chart) {
//        var svg = chart.getSVG(),
//            // Get width/height of SVG for export
//            svgWidth = +svg.match(
//                /^<svg[^>]*width\s*=\s*\"?(\d+)\"?[^>]*>/
//            )[1],
//            svgHeight = +svg.match(
//                /^<svg[^>]*height\s*=\s*\"?(\d+)\"?[^>]*>/
//            )[1];
//
//        svg = svg.replace(
//            '<svg',
//            '<g transform="translate(0,' + top + ')" '
//        );
//        svg = svg.replace('</svg>', '</g>');
//
//        top += svgHeight;
//        width = Math.max(width, svgWidth);
//
//        svgArr.push(svg);
//    });
//
//    return '<svg height="' + top + '" width="' + width +
//        '" version="1.1" xmlns="http://www.w3.org/2000/svg">' +
//        svgArr.join('') + '</svg>';
//};
//
///**
// * Create a global exportCharts method that takes an array of charts as an
// * argument, and exporting options as the second argument
// */
//Highcharts.exportCharts = function (charts, options) {
//
//    // Merge the options
//    options = Highcharts.merge(Highcharts.getOptions().exporting, options);
//
//    // Post to export server
//    Highcharts.post(options.url, {
//        filename: options.filename || 'chart',
//        type: options.type,
////        width: options.width,
//        width: 1000,
//        svg: Highcharts.getSVG(charts)
//    });
//};



///**
// * Create a global getSVG method that takes an array of charts as an argument. The SVG is returned as an argument in the callback.
// */
//Highcharts.getSVG = function(charts, options, callback) {
//    var svgArr = [],
//    		top = 0,
//        width = 0,
//        i,
//        svgResult = function (svgres) {
//            var svg = svgres.replace('<svg', '<g transform="translate(0,' + top + ')" ');
//            svg = svg.replace('</svg>', '</g>');
//            top += charts[i].chartHeight;
//            width = Math.max(width, charts[i].chartWidth);
//            svgArr.push(svg);
//            if (svgArr.length === charts.length) {
//              callback('<svg height="'+ top +'" width="' + width + '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + svgArr.join('') + '</svg>');
//            }
//        };
//		for (i = 0; i < charts.length; ++i) {
//				charts[i].getSVGForLocalExport(options, {}, function () { 
//        	console.log("Failed to get SVG");
//       	}, svgResult);
//		}
//};

///**
// * Create a global exportCharts method that takes an array of charts as an argument,
// * and exporting options as the second argument
// */
//Highcharts.exportCharts = function(charts, options) {
//		// Merge the options
//    options = Highcharts.merge(Highcharts.getOptions().exporting, options);    
//		
//    var imageType = options && options.type || 'image/png';
//  alert('local options: ' + options);
//		// Get SVG asynchronously and then download the resulting SVG
//    Highcharts.getSVG(charts, options, function (svg) {
//      Highcharts.downloadSVGLocal(svg,
//        (options.filename || 'chart')  + '.' + (imageType === 'image/svg+xml' ? 'svg' : imageType.split('/')[1]),
//        imageType,
//        options.scale || 2,
//        function () {
//          console.log("Failed to export on client side");
//        });
//    });
//};

//function save_chart(chart, filename) {
//    var render_width = EXPORT_WIDTH;
//    var render_height = render_width * chart.chartHeight / chart.chartWidth
//
//    var svg = chart.getSVG({
//        exporting: {
//            sourceWidth: chart.chartWidth,
//            sourceHeight: chart.chartHeight
//        }
//    });
//
//    var canvas = document.createElement('canvas');
//    canvas.height = render_height;
//    canvas.width = render_width;
//
//    var image = new Image;
//    image.onload = function() {
//        canvas.getContext('2d').drawImage(this, 0, 0, render_width, render_height);
//        var data = canvas.toDataURL("image/png")
//        download(data, filename + '.png');
//    };
//    image.src = 'data:image/svg+xml;base64,' + window.btoa(svg);
//}

//function download(data, filename) {
//    var a = document.createElement('a');
//    a.download = filename;
//    a.href = data
//    document.body.appendChild(a);
//    a.click();
//    a.remove();
//}


function exportZippedCharts(imageType){
        
		console.log('image type: ' + imageType);
        // ZIP file object, which will as the AJAX requests resolve
        var zip = new JSZip();
        
        // URL to Highcharts export server
        var exportUrl = 'https://export.highcharts.com/';

        // POST parameter to Highcharts export server for chart 1
        var object = {
            options: JSON.stringify(chart1),
//            type: 'image/jpeg',
            type: imageType,
            async: true
        };
//        alert('chart 1 params: ' + JSON.stringify(object));
        // Ajax request for chart 1
        var d1 = $.ajax({
            type: 'post',
            url: exportUrl,
            data: object,
            success: function (data) {
//            	alert('1 success');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) { 
//                alert("Status: " + textStatus); alert("Error: " + errorThrown); 
            },
            complete: function (XMLHttpRequest, status) {
//                alert("1 completion:" + status);
              }
        
        });
        
        // POST parameter to Highcharts export server for chart 2
        var object = {
            options: JSON.stringify(chart2),
//            type: 'image/jpeg',
            type: imageType,
            async: true
        };

        // Ajax request for chart 2
        var d2 = $.ajax({
            type: 'post',
            url: exportUrl,
            data: object,
            success: function (data) {
//            	alert('2 success')
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) { 
//                alert("Status: " + textStatus); alert("Error: " + errorThrown); 
            },
            complete: function (XMLHttpRequest, status) {
//                alert("2 completion:" + status);
              }
        });
        
        // When URL to rendered images are returned ...
        $.when(d1,d2).done(function(v1,v2) {
        	// Get contents of rendered image 1
            var p1 = new JSZip.external.Promise(function (resolve, reject) {
                JSZipUtils.getBinaryContent(exportUrl + v1[0], function(err, data) {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(data);
                    }
                });
            });
            
            // Get contents of rendered image 2
            var p2 = new JSZip.external.Promise(function (resolve, reject) {
                JSZipUtils.getBinaryContent(exportUrl + v2[0], function(err, data) {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(data);
                    }
                });
            });
            
            // When content of rendered images have been fetched ...
            Promise.all([p1,p2]).then(function(values) {
                // Add images to ZIP
            	if(imageType == 'image/jpeg'){
            		console.log('into if');
            		zip.file("chart1.jpeg", values[0], {binary:true});
                    zip.file("chart2.jpeg", values[1], {binary:true});
            	}else if(imageType == 'application/pdf'){
            		console.log('into else')
            		zip.file("chart1.pdf", values[0], {binary:true});
                    zip.file("chart2.pdf", values[1], {binary:true});	
            	}
                
                
                // Generate and save ZIP
                zip.generateAsync({type:"blob"})
                    .then(function(content) {
                    saveAs(content, "charts.zip");
                });
            });
        });
}


Highcharts.getSVG = function (charts, options, callback) {
	alert(JSON.stringify(options));
    var svgArr = [],
        top = 0,
        width = 0,
        addSVG = function (svgres) {
            // Grab width/height from exported chart
            var svgWidth = +svgres.match(
                    /^<svg[^>]*width\s*=\s*\"?(\d+)\"?[^>]*>/
                )[1],
                svgHeight = +svgres.match(
                    /^<svg[^>]*height\s*=\s*\"?(\d+)\"?[^>]*>/
                )[1],
                // Offset the position of this chart in the final SVG
                svg = svgres.replace('<svg', '<g transform="translate(0,' + top + ')" ');
            svg = svg.replace('</svg>', '</g>');
            top += svgHeight;
            width = Math.max(width, svgWidth);
            svgArr.push(svg);
        },
        exportChart = function (i) {
            if (i === charts.length) {
                return callback('<svg height="' + top + '" width="' + width +
                  '" version="1.1" xmlns="http://www.w3.org/2000/svg">' + svgArr.join('') + '</svg>');
            }
            charts[i].getSVGForLocalExport(options, {}, function () {
                console.log("Failed to get SVG");
            }, function (svg) {
                addSVG(svg);
                return exportChart(i + 1); // Export next only when this SVG is received
            });
        };
    exportChart(0);
};

/**
 * Create a global exportCharts method that takes an array of charts as an argument,
 * and exporting options as the second argument
 */
Highcharts.exportCharts = function (options) {
	var new_chart1 = $('#graph1').highcharts();
	var new_chart2 = $('#graph2').highcharts();
	var charts = [new_chart1, new_chart2];
    options = Highcharts.merge(Highcharts.getOptions().exporting, options);

		// Get SVG asynchronously and then download the resulting SVG
    Highcharts.getSVG(charts, options, function (svg) {
        Highcharts.downloadSVGLocal(svg, options, function () {
            console.log("Failed to export on client side");
        });
    });
};

// Set global default options for all charts
Highcharts.setOptions({
    exporting: {
        fallbackToExportServer: false // Ensure the export happens on the client side or not at all
    }
});
