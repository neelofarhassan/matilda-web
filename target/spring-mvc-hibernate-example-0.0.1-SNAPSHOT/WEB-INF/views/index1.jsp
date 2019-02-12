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
				<header class='image' style='background-image: url(${home}/resources/images/banner2.jpg);min-height:100px!important;height:320px!important;'>
					<div class='center-align blurred'>
						<h1 style="text-shadow:rgba(0,0,0,0.6) 0px 0px 10px;max-width:100%;width:100%;text-align:center;">MATILDA - Melbourne Algorithm & Test Instance </br>Library with Data Analytics</h1>
					</div>
				</header>
				<div id="home_main_container" style="font-family : Comic Sans MS;font-size: 18px;">
				<h1>Melbourne Algorithm & Test Instance Library with Data Analytics</h1></h1>
					<p><strong>Welcome to Matilda! </strong>This website allows you to analyze the performance
					of an algorithm across the instance space. You can also download instances, research publications 
					related to MATILDA and source code for 
					algorithms and feature generation <a class='no_underline detail' href="<c:url value="/about-matilda" /> ">Learn More ...</a></p>
					
					<div>
						<a href="<c:url value="/newuser" /> "><img alt="" src="<c:url value="/resources/images/circle_register_green.png" /> "></a>
						<a href="<c:url value="/data-analytics" /> "><img alt="" src="<c:url value="/resources/images/circle_upload_green.png" /> "></a>
						<a href="<c:url value="/combinatorial-problem" /> "><img alt="" src="<c:url value="/resources/images/circle_download_green.png" /> "></a>
					</div>
					
				</div>
				<div>
				 </div>
			</div>
		</div>
		<%@include file="/footer.jsp" %>
	</div>
</body>
</html>