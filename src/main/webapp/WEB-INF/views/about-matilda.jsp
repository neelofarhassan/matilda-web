<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<h2> What is MATILDA?</h2>
		<p><b>MATILDA</b> – Melbourne Algorithm & Test Instance Library with Data Analytics –
		is a research funded by the Australian Research Council as a 5 year Laureate 
		project. The project aims to develop powerful new tools to reveal the strengths and weaknesses of 
		algorithms, not just in the mathematical field of optimisation, but also in machine learning, 
		time series forecasting, software testing, and many other fields. </p> 
		
		<h2>What is the significance of our research?</h2>
		<p>There is a very rich set of optimisation algorithms that we can draw upon for 
		various classes of problems, e.g. the famous Travelling Salesman Problem. But which 
		algorithm will be the best for solving a given instance of the problem is not at all clear. 
		Different algorithms have different underlying mechanisms that are able to exploit certain 
		properties of the data instance, but if the instance has unsuited properties then an algorithm may 
		fail to give good solutions. Thus, if we
		want to select the right algorithm for the right problem, it is crucial to understand 
		the strengths and weaknesses of algorithms. It won't just help us in becoming more insightful 
		in our quest for ensuring we select the right algorithm for the right problem, but also contribute in
		avoiding tedious 
		trial-and-error testing, or – even worse – a deployment disaster when an unreliable algorithm is 
		chosen.</p>
		
		<h2>Research Outcomes</h2>
		
		<p>We developed the methodologies and tools to facilitate
		<ul>
			<li>objective “stress-testing” and reporting of algorithmic power,</li>
			<li>visualizations of the instance space to support insights into algorithm strengths 
			and weaknesses, and</li>
			<li>automated algorithm selection tools to assist deployment of the best algorithm for 
			real-world applications.</li>
		</ul>
		</p>
		
		<h2>About this Website</h2>
		<p>The engine behind this website is powered by MATILDA research outcomes and facilitates the users to
		<ul if="matilda_functionality">
			<li><a href="#">Download benchmark datasets for various problems</a></li>
			<li><a href="#">Upload their solution and visualize its strength and weaknesses across a
			wide instance space</a></li>
			<li><a href="#">Download performance visualization graphs</a></li>
			<li><a href="#">Download other researcher's solutions</a></li>
		</ul> 
		</p>
		<h2>Research Publications</h2>
		<p>The methodology used by MATILDA for visualizing and understanding the strengths and 
		weaknesses of different algorithms has been described in a series of three papers: </p>
		<ul>
			<li>Smith-Miles, K. A., and Lopes, L. B., “Measuring Instance Difficulty for Combinatorial 
			Optimization Problems”, Computers & Operations Research, vol. 39, no. 5, pp. 875-889, 2012.</li>
			<li>Smith-Miles, K. A., Baatar, D., Wreford, B. and Lewis, R., “Towards Objective Measures 
			of Algorithm Performance across Instance Space”, Computers & Operations Research, vol. 
			45, pp. 12-24, 2014.</li>
			<li>Smith-Miles, K. A. and Bowly, S., "Generating New Test Instances by Evolving in 
			Instance Space", Computers & Operations Research, vol. 63, pp. 102-113, 2015.</li>
		</ul>
        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>