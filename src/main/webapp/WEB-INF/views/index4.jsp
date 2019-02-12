<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
  <meta charset="utf-8" />
  <meta content="width=device-width, initial-scale=1.0" name="viewport" />
  <meta content="IE=edge" http-equiv="X-UA-Compatible" />
  <%@include file="/includes.jsp" %>
  <script type="text/javascript" src="<c:url value="/resources/scripts/matilda.js" /> "></script>
</head>
<body>
	<div class="uomcontent">
		<div class="page-inner">
			<%@include file="/auth-header.jsp" %>
			<div role="main">
				
				<%@include file="/menu.jsp" %>
				<div style="padding-top: 0px; background-color: black !important;display: inline-block; width: 100%; text-align: center; height:1200px;">
					<div id="matilda_header" style="background-image: url(<c:url value="/resources/images/banner10.jpg" />); text-align:center; display: inline-block;padding-top: 0px; width: 100%;background-size: cover;height:350px!important;background-color:black;">
						<div style="float:left; text-align:center; width: 33.3%; height: 320px;">
						</div>
						<div style="float:left;  text-align:center; width: 33.3%; height: 320px;">
							<h1 style="	color: white; margin-top:130px;top: 50%; font-size: 56px;">MATILDA</h1>
						</div>
						<div style="float: left; width: 33.3%;text-align: right;height: 320px;">
						</div>
					</div>
	
					<div id="home_main_container" style="font-family : Comic Sans MS;font-size: 18px;background-color: black; color: white; margin-bottom: 80px;">
						<h1>Melbourne Algorithm & Test Instance Library with Data Analytics</h1>
						<p style=""><strong>Welcome to Matilda! </strong>This website allows you to analyze the performance
						of an algorithm across the instance space. You can also download instances, research publications 
						related to MATILDA and source code for 
						algorithms and feature generation <a class='no_underline detail' href="<c:url value="/about-matilda" /> ">Learn More ...</a></p>
					</div>
					<div id="homapage_buttons" style="border: 0px solid white; color:white; max-width: 43.75rem; display: inline-block; text-align: center;">
					<a class="no_underline" href="<c:url value="/about-matilda" />">
						<div class="homepage_button2">
							<span style="text-transform: uppercase; font-weight: bold;">About Matilda</span><br>Know more about our project
						</div>
					</a>
					<a class="no_underline" href="<c:url value="/about-us" />">
						<div class="homepage_button2">
							<span style="text-transform: uppercase; font-weight: bold;">Our Team</span><br>Meet our team members
						</div>
					</a>
					<a class="no_underline" href="">						
						<div class="homepage_button2">
							<span style="text-transform: uppercase; font-weight: bold;">Our Methodology</span><br>
							All about techniques and algorithms behind this engine
						</div>
					</a>
					<a class="no_underline" href="<c:url value="/submission-guidelines" />">
						<div class="homepage_button2">
							<span style="text-transform: uppercase; font-weight: bold;">Getting Started</span><br>
							General Guidelines to use this platform 
						</div>
					</a>
					</div>
				</div>
			</div>
		</div>
		<%@include file="/footer.jsp" %>
	</div>
</body>
</html>