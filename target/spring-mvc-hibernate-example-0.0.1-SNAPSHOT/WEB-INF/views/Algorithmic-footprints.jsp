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
  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
  <script src="//code.highcharts.com/highcharts.js"></script>
  <script src="//code.highcharts.com/modules/heatmap.js"></script>
  <script src="//code.highcharts.com/modules/data.js"></script>
  <script src="//code.highcharts.com/modules/exporting.js"></script>
  <script type="text/javascript">
	var userName = "<%=request.getAttribute("userName") %>";
	var problemName = "<%=request.getAttribute("problemName") %>"; 
	var performanceMetricLabel = "<%=request.getAttribute("PerformanceMetricLabel") %>"; 
	var logFileURL = "<c:url value="/readMatlabLogFileRecursively" />";
	var performanceTableURL= "<c:url value="/readPerformanceTable" />";
	var coordinatesPath = '<c:url value="/usersdata/" />' + userName + '/' + problemName + '/coordinates.csv';
	var featuresPath = '<c:url value="/usersdata/" />' + userName + '/' + problemName + '/feature_process.csv';
	var algosPath = '<c:url value="/usersdata/" />' + userName + '/' + problemName + '/algorithm_process.csv';
	var jobCancellationURL = '<c:url value="/cancelUserJob/${jobId}/${problemName}" />';
	console.log(userName + ':' + problemName);
	var modificationTime=0;
	var lineNumber=1;
	var methodCalls=0;
	
</script>
<script type="text/javascript" src="<c:url value="/resources/scripts/matilda.js" /> "></script>
<script type="text/javascript">
showExecutionLogs(userName, problemName, modificationTime, lineNumber, '', methodCalls);
</script>
</head>
<body>
	
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	  <%@include file="authheader.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		<header>
			<h1>Footprint Analysis</h1> <br> <h2>${userFriendlyProblemName}</h2>
		</header>
		<div class="nextto_header">
			<p>You can inspect the execution logs of your submitted solution in the window below. If you want to cancel the
			execution at any time, please press 'close' button. <br> <br>
			
			<font color="red">&#9888; Please be aware that the execution logs and other submitted files will be deleted by cancelling the execution. </font>
			</p>
		</div>
		<div class="shell-wrap" id="execution_logs_container">
  			<div class="shell-top-bar">
  					<table id="log_header_table" class="log_header full_width_table">
  						<tr>
  							<td  style="text-align: left;"><h3>Execution Logs -- ${userFriendlyProblemName}</h3></td>
  							<td style="text-align: right; color: red;"><a id="cancel_job" class="no_underline" href=""><button style="background-color: red;">Close</button></a></td>
  						</tr>
  					</table>
  				</div>
  				<div class="shell-body" id="logs"></div>
			</div>
		
		<div id="error_container"></div>
			<div id="graph_container" style="border: 1px solid black; text-align: center;">
			<h2>Instance Space: Distribution of selected features/algorithms</h2>
				<div style="clear: both;">
					<form>
						<div id='features' class="twocolumnform_firstcolumn"></div>
					
					</form>
				</div>
				<div id="graph_body" style="width: 800px; height: 850px; margin: 0 auto" class="hidden_div"></div>

			</div>
			
			<div id="table_container" style="margin-bottom: 100px;" class="hidden_div"></div>   
			



			
<%-- 			<img alt="graph" src="<c:url value="/userimages/footprint_maxis_colours.png" />"> --%>
<%-- 			<img alt="graph" src="<c:url value="/resources/images/andres.jpg" />"> --%>
	

        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>
