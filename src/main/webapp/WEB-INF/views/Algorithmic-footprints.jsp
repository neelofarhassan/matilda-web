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
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/data.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>

<script type="text/javascript">
$(document).ready(function() { 
	modificationTime=0;
	lineNumber=1;
	methodCalls=0;
	showExecutionLogs('neelofar', 'gcp', modificationTime, lineNumber, '', methodCalls);

//  // JQuery function to process the csv data
 $.get('<c:url value="/resources/graphcsvs/coordinates.csv" />', function(data) {
     // Split the lines
     var lines = data.split('\n');
     var series_data = new Array();
     var x_label, ylabel;
     $.each(lines, function(lineNo, line) {
    	 if(lineNo == 0){
    		 var items = line.split(',');
    		 $.each(items, function(itemNo, item){
    			 if(itemNo == 0){
    				 x_label= item;
    			 }else{
    				 y_label = item;
    			 }
    		 });
    	 }else{
	         var items = line.split(',');
	         var items_subarray = new Array();
	      	 $.each(items, function(itemNo, item) {
	      		items_subarray.push(parseFloat(item));
	  		});
// 	      	 console.log(items_subarray);
	      	series_data.push(items_subarray);
		}
     });

   var chart = {
      type: 'scatter',
      zoomType: 'xy'
   };

   var title = {
      text: 'Title ???'   
   };
   var subtitle = {
      text: ''  
   };
   var xAxis = {
      title: {
         enabled: true,
         text: x_label
      },
      startOnTick: true,
      endOnTick: true,
      showLastLabel: true
   };
   var yAxis = {
      title: {
         text: y_label
      }
   };
   var legend = {   
      layout: 'vertical',
      align: 'left',
      verticalAlign: 'top',
      x: 100,
      y: 100,
      floating: true,
      backgroundColor: (
         Highcharts.theme && Highcharts.theme.legendBackgroundColor) ||
         '#FFFFFF',
      borderWidth: 1
   }  
   var plotOptions = {
      scatter: {
         marker: {
            radius: 5,
            states: {
               hover: {
                  enabled: true,
                  lineColor: 'rgb(100,100,100)'
               }
            }
         },
         states: {
            hover: {
               marker: {
                  enabled: false
               }
            }
         },
         tooltip: {
            headerFormat: '<b>{series.name}</b><br>',
            pointFormat: '{point.x}, {point.y}'
         }
      }
   };
   
   var series = [
      {
         name: 'series name?',
         color: 'rgba(223, 83, 83, .5)',
         data: series_data
      }
   ];     

   var json = {};   
   json.chart = chart; 
   json.title = title;   
   json.subtitle = subtitle; 
   json.legend = legend;
   json.xAxis = xAxis;
   json.yAxis = yAxis;  
   json.series = series;
   json.plotOptions = plotOptions;
   $('#container').highcharts(json);
 });   
   
});
function showExecutionLogs(user, problem, modificationTime, lineNumber, logContents, methodCalls){
	var endOfFile = "";
	$.ajax({
		type: "get",
		url: "<c:url value="/readMatlabLogFileRecursively" />",
		data: {userName:'neelofar', problemName:'gcp', lastModified:modificationTime, lastLineRead:lineNumber},
		success: function(data){
			$.each(data, function(k,v){
				if(k == 'true'){
				console.log('inside true')
				endOfFile = v[0];
				lineNumber=v[1];
				currentLogContents = v[2];
				modificationTime=v[3];
				logContents = logContents + currentLogContents;
				console.log('method calls: ' + methodCalls + ', last read line: ' + lineNumber + ', modification time: ' + modificationTime + ', end of file: ' + endOfFile);
				}
			});
			logContents = '<p>' + logContents + '</p>';
			$('#logs').html(logContents);
			if(endOfFile != 'true'){
				methodCalls = parseInt(methodCalls) + 1;
				 setTimeout(showExecutionLogs, 10000, user, problem, modificationTime, lineNumber, logContents, methodCalls);
			}else{
				return;
			}
		}
	});
}
</script>
  
  <style>
  	#main_container {
  	padding-top:50px;
  	padding-bottom:50px;
  	}
  </style>
</head>
<body>
	
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	  <%@include file="authheader.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
			<div id="logs" style="overflow:scroll; height:600px; margin-left: 25%; margin-right: 25%; margin-top: 50px; margin-bottom: 50px;background-color: black; color: white;"></div>
			<div id="container" style="width: 1000px; height: 700px; margin: 0 auto"></div>   

			
			
<%-- 			<img alt="graph" src="<c:url value="/userimages/footprint_maxis_colours.png" />"> --%>
<%-- 			<img alt="graph" src="<c:url value="/resources/images/andres.jpg" />"> --%>
	

        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>
