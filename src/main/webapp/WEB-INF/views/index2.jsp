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
				<c:url var="home" value="/" />
				<%@include file="/menu.jsp" %>
				<div style="height:1000px; background-image: url(<c:url value="/resources/images/background/17099_0383.jpg" />); background-size: cover; display: inline-block; width: 100%;background-repeat: no-repeat; color: white; background-attachment: fixed;text-align:center;">
					<div id="home_main_container" style="font-family : Comic Sans MS;font-size: 20px; color: white; background: rgb(48,76,100, 0.4)">
						<h1 style="font-weight:300; font-size:36px; width: 48%;">Melbourne Algorithm & Test Instance Library with Data Analytics</h1>
						<p><strong>Welcome to Matilda! This website allows you to analyze the performance
						of an algorithm across the instance space. You can also download instances, research publications 
						related to MATILDA and source code for algorithms and feature generation.</strong></p>
					</div>
					<div id="homapage_buttons" style="border: 0px solid white; color:white; width: 60%; display: inline-block; text-align: center;margin-top: 150px;">
					<a class="no_underline" href="<c:url value="/about-matilda" />">
						<div class="homepage_button">
							<span style="text-transform: uppercase; font-weight: bold;">About Matilda</span><br>Know more about our project
						</div>
					</a>
					<a class="no_underline" href="<c:url value="/about-us" />">
						<div class="homepage_button">
							<span style="text-transform: uppercase; font-weight: bold;">Our Team</span><br>Meet our team members
						</div>
					</a>
					<a class="no_underline" href="">						
						<div class="homepage_button">
							<span style="text-transform: uppercase; font-weight: bold;">Our Methodology</span><br>
							All about techniques and algorithms behind this engine
						</div>
					</a>
					<a class="no_underline" href="<c:url value="/submission-guidelines" />">
						<div class="homepage_button">
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