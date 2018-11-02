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
  <link rel="stylesheet" href="/resources/css/matilda.css">
  <script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script>
  <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<script src="http://code.highcharts.com/highcharts.js"></script>
<script src="http://code.highcharts.com/modules/exporting.js"></script>
<script type="text/javascript">
var ctx = "${pageContext.request.contextPath}"
        jQuery(document).ready(function() { 
 
            var options = {
                chart: {
                    renderTo: 'container',
                    type: 'column'
                },
                title: {
                    text: 'Tiny Tool Monthly Sales'                 
                },
                subtitle: {
                    text: '2014 Q1-Q2'
                },
                xAxis: {
                    categories: []
                },
                yAxis: {
                    title: {
                        text: 'Sales'
                    }
                },
                series: []
            };
            // JQuery function to process the csv data
            $.get('<c:url value="/resources/graphcsvs/example.csv" />', function(data) {
                // Split the lines
                var lines = data.split('\n');
                $.each(lines, function(lineNo, line) {
                    var items = line.split(',');
                     
                    // header line contains names of categories
                    if (lineNo == 0) {
                        $.each(items, function(itemNo, item) {
                            //skip first item of first line
                            if (itemNo > 0) options.xAxis.categories.push(item);
                        });
                    }
                     
                    // the rest of the lines contain data with their name in the first position
                    else {
                        var series = { 
                            data: []
                        };
                        $.each(items, function(itemNo, item) {
                            if (itemNo == 0) {
                                series.name = item;
                            } else {
                                series.data.push(parseFloat(item));
                            }
                        });
                         
                        options.series.push(series);
 
                    }
                     
                });
                //putting all together and create the chart
                var chart = new Highcharts.Chart(options);
            });         
             
        });
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
			<div id="container" style="width: 1000px; height: 700px; margin: 0 auto"></div>   

			<c:url var="action" value="/generate-footprint" />
			<form:form action="${action}" commandName="algorithm" method="POST" enctype="multipart/form-data">
					
					<div>
<!-- 						<label>What problem do you want to analyze?</label> -->
						<p>
						<form:radiobutton id="library_problem1" path="libraryProblem" value="true" name="problem_type" label="Problem from our library"/>
						<form:radiobutton id="library_problem1" path="libraryProblem" value="false" name="problem_type" label="Custom problem"/>
						</p>
					</div> 
					</form:form>
	

        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>




<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1" --%>
<%--     pageEncoding="ISO-8859-1"%> --%>
<%--     <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> --%>
<%--     <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%> --%>
<!-- <!DOCTYPE html> -->
<!-- <html> -->
<!-- <head> -->
<!-- <meta charset="ISO-8859-1"> -->
<!-- <title>Matilda Graph</title> -->
<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script> -->
<!-- <script src="http://code.highcharts.com/highcharts.js"></script> -->
<!-- <script src="http://code.highcharts.com/modules/exporting.js"></script> -->
<!-- <script type="text/javascript"> -->
// var ctx = "${pageContext.request.contextPath}"
//         jQuery(document).ready(function() { 
 
//             var options = {
//                 chart: {
//                     renderTo: 'container',
//                     type: 'column'
//                 },
//                 title: {
//                     text: 'Tiny Tool Monthly Sales'                 
//                 },
//                 subtitle: {
//                     text: '2014 Q1-Q2'
//                 },
//                 xAxis: {
//                     categories: []
//                 },
//                 yAxis: {
//                     title: {
//                         text: 'Sales'
//                     }
//                 },
//                 series: []
//             };
//             // JQuery function to process the csv data
//             $.get('<c:url value="/resources/graphcsvs/example.csv" />', function(data) {
//                 // Split the lines
//                 var lines = data.split('\n');
//                 $.each(lines, function(lineNo, line) {
//                     var items = line.split(',');
                     
//                     // header line contains names of categories
//                     if (lineNo == 0) {
//                         $.each(items, function(itemNo, item) {
//                             //skip first item of first line
//                             if (itemNo > 0) options.xAxis.categories.push(item);
//                         });
//                     }
                     
//                     // the rest of the lines contain data with their name in the first position
//                     else {
//                         var series = { 
//                             data: []
//                         };
//                         $.each(items, function(itemNo, item) {
//                             if (itemNo == 0) {
//                                 series.name = item;
//                             } else {
//                                 series.data.push(parseFloat(item));
//                             }
//                         });
                         
//                         options.series.push(series);
 
//                     }
                     
//                 });
//                 //putting all together and create the chart
//                 var chart = new Highcharts.Chart(options);
//             });         
             
//         });
<!--         </script> -->
<!-- </head> -->
<!-- <body> -->
<!-- <div id="container" style="width: 1000px; height: 700px; margin: 0 auto"></div>    -->

<%-- 			<c:url var="action" value="/generate-footprint" /> --%>
<%-- 			<form:form action="${action}" commandName="algorithm" method="POST" enctype="multipart/form-data"> --%>
<!-- 				<fieldset> -->
					
<!-- 					<div> -->
<!-- <!-- 						<label>What problem do you want to analyze?</label> --> -->
<!-- 						<p> -->
<%-- 						<form:radiobutton id="library_problem1" path="libraryProblem" value="true" name="problem_type" label="Problem from our library"/> --%>
<%-- 						<form:radiobutton id="library_problem1" path="libraryProblem" value="false" name="problem_type" label="Custom problem"/> --%>
<!-- 						</p> -->
<!-- 					</div>  -->
<!-- 					</fieldset> -->
<%-- 					</form:form> --%>
<!-- </body> -->
<!-- </html> -->