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
  <script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script>
  <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
  <script type="text/javascript">
  jQuery(document).ready(function() {
	$('#problems').hover(function(){
	    $('#flyout').slideToggle();
	});
  });
  </script>
  <style>
  	#main_container {
  	padding-top:50px;
  	padding-bottom:50px;
  	}
  	a{
  	text-decoration: none;
  	}
  	p{
	text-align:justify;
	}
  </style>
</head>
<body>
	
  <div class="uomcontent">
    <div class="page-inner">
<%-- 	  <%@include file="/breadcrumbs.jsp" %> --%>
	  <%@include file="/auth-header.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		<header class='image' style='background-image: url(${home}/resources/images/banner.png);min-height:100px!important;height:300px!important;'>
			<div class='center-align blurred'>
				<h1 style="text-shadow:rgba(0,0,0,0.6) 0px 0px 10px;max-width:100%;width:100%;text-align:center;">MATILDA - Melbourne Algorithm & Test Instance </br>Library with Data Analytics</h1>
			</div>
		</header>
	
        <div id="main_container">
			<p><strong>Welcome to Matilda -- </strong>This website allows you to upload your solution
			and facilitates</p>
			<ul>
				<li>Objective “stress-testing” and reporting of algorithmic power</li>
				<li>Visualizations of the instance space to support insights into algorithm strengths 
				and weaknesses, and </li>
				<li>Automated algorithm selection tools to assist deployment of the best algorithm 
				for real-world applications. <a href="about-matilda">Learn More ...</a></li>		
			</ul>
			</div>
        </div>
      </div>
      <%@include file="/footer.jsp" %>
    </div>
</body>
</html>