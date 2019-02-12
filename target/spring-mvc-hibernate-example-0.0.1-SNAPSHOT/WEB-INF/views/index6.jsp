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
					<div style="background-image: url(<c:url value="/resources/images/155771030-56a793c63df78cf772974e32.jpg" />); 	background-repeat: no-repeat; background-position: center; background-size:cover;">
						
						<div id="matilda_header" style="display: inline-block;width: 100%; position: relative; overflow: auto; text-align: center;margin-bottom: 100px;">
				  			<img alt="" src="<c:url value="/resources/images/transparent-matilda3.png" />" height="320px">
						</div>

				<div id="home_main_container" style="font-family : Comic Sans MS;font-size: 18px;">
				<h1>A Tagline is really important !!!! <br> let's create one now</h1>
					<p><strong>Welcome to Matilda! </strong>This website allows you to analyze the performance
					of an algorithm across the instance space. You can also download instances, research publications 
					related to MATILDA and source code for 
					algorithms and feature generation <a class='no_underline detail' href="<c:url value="/about-matilda" /> ">Learn More ...</a></p>
					
					<div>
						<a href="<c:url value="/newuser" /> "><img alt="" src="<c:url value="/resources/images/transparent-download.png" /> "></a>
						<a href="<c:url value="/data-analytics" /> "><img alt="" src="<c:url value="/resources/images/transparent-download.png" /> "></a>
						<a href="<c:url value="/combinatorial-problem" /> "><img alt="" src="<c:url value="/resources/images/transparent-download.png" /> "></a>
					</div>
					
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