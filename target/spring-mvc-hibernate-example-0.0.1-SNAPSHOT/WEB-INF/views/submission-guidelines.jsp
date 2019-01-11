<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
</head>
<body>
	
  <div class="uomcontent">
    <div class="page-inner">
	  <%@include file="/breadcrumbs.jsp" %>
	  <%@include file="authheader.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		<header><h1>Submission Guidelines</h1></header>
		<div class="below_header_div">
			<p>We have selected a list of combinatorial optimization and machine learning 
			<a style="text-decoration: none" href="<c:url value="/combinatorial-problem/all" />">problems</a> for
			which our repository has proposed algorithms and their performance.   You can use this 
			<a style="text-decoration: none" href="<c:url value="/data-analytics" />">website</a>  as a tool to analyze the strengths and weaknesses of these algorithms in
			instance space, compare the performance of your devised algorithm with other solutions for
			these problems or submit and analyze a solution for a new problem.</p>
			
			
			
			<h2>How to analyse the performance of an algorithms for a library problem</h2> 
			<h3>Analyze already existing algorithms</h3>
				<ol>
					<li>Select a problem</li>
					<li>Select algorithms to analyze</li>
					<li>Select features to use/ upload features file for adding new features in your analysis 
					(<a href="<c:url value="/resources/graphcsvs/features.csv" />">sample feature file</a>) </li>
					<li><font color=red>Andres! Feature file format please !!!</font></li>
					<li>Select objective function performance measurement criteria (minimize/maximize)</li>
					<li>Provide parameter values for footprint generation or submit with the default values</li>
				</ol>
				<h3>Submit and Analyze a new algorithm</h3>
				<ol>
					<li>Download benchmark datasets available in our repository for a particular problem.</li>
					<li>Run your algorithm on full/ subset of dataset and record its performance in a csv file with the
					following format (<a href="<c:url value="/resources/graphcsvs/performance.csv" />">sample performance file</a>) </li>
					<li>You can submit more than one algorithms by separating their performance by commas</li>
					<li>First row should mention the names of the algorithm/s </li>
					<li>Select algorithms with which you want to compare the performance of submitted algorithm</li>
					<li>Select features to use/ upload features file for adding new features in your analysis </li>
					<li>Select objective function performance measurement criteria (minimize/maximize)</li>
					<li>Provide parameter values for footprint generation or submit with the default values</li>
				</ol>
			<h2>How to analyze the performance of an algorithms for a custom problem</h2>
			<p>For any problem that is not part of our library, you can submit one or more solutions and compared
			their performance in instance space.</p> 
			<ol>
				<li><font color=red>Dataset???</font></li>
				<li>Upload the performance csv of your algorithm/s using format mentioned above.</li>
				<li>Upload the features csv containing a list of features you want to use in your analysis.</li> 
				<li>Select objective function performance measurement criteria (minimize/maximize)</li>
				<li>Provide parameter values for footprint generation or submit with the default values</li>
			</ol>
		</div>
        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>