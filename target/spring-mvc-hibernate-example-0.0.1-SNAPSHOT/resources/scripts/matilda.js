$(document).ready(function() {
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

function showExecutionLogs(user, problem, modificationTime, lineNumber, logContents, methodCalls){
	var endOfFile = "";
	var scriptSuccess = "";
	var $logsdiv = $("#logs");
	var height;
	$.ajax({
		type: "get",
//		url: "<c:url value="/readMatlabLogFileRecursively" />",
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
				
// 				$('#close-execution').addClass('hidden_div');
				$logsdiv.scrollTop($logsdiv.height());
				$('html, body').animate({scrollTop: height}, 'slow');
				hideExecutionCancellationButton();
				if(scriptSuccess == 'false'){
					$('#error_container').html('<p><font color="red"><h2>An error occured !!! </h2></font><br><br>Please see log window for details.</p> ');
				}else{
					showPerformanceTable(user, problem);
					$('#graph_body').removeClass('hidden_div').addClass('display_div');
					$('#table_container').removeClass('hidden_div').addClass('display_div');
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
//		url: "<c:url value="/readPerformanceTable" />",
		url: performanceTableURL,
		data: {userName:user, problemName:problem},
		success: function(data){
// 			console.log('returned data: ' + data);
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
// 			console.log(table);
		},
		error: function(){
			$('#table_container').html('<p><font color=red>Some error occured while generating footprint performance table. Please see execution logs for the details. </font><p>');
		}
	});
	
	
	$.ajax({
		type: "get",
//		url: "<c:url value="/readMatlabLogFileRecursively" />",
		
		url: logFileURL,
		data: {userName:user, problemName:problem, lastModified:modificationTime, lastLineRead:lineNumber},
		success: function(data){
			if(!$.trim(data)){
				$('#logs').html('<h2><font color="red"> Sorry, some problem occured while executing your code. Please <a href="<c:url value="/contact-us" />">contact</a> website administation.</font><h2>');
			}else{
// 			console.log('returned data: ' + data);
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
				    $('#graph_body').highcharts({
				        chart: {
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
				        	text: selectedFeatureName
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
				      	      title: {
				      	         text: y_label
				      	      }
				      	   }
				    });
				    
				    $('#features').html(featureSelectionOptions);
				 
				 
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