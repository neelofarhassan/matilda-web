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
</head>
<body>
	
  <div class="uomcontent">
    <div class="page-inner">
<%-- 	<%@include file="/breadcrumbs.jsp" %> --%>
 	  <%@include file="authheader.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		<header class='image' style='background-image: url(${home}/resources/images/banner.png);min-height:100px!important;height:300px!important;'>
			<div class='center-align blurred'>
				<h1 style="text-shadow:rgba(0,0,0,0.6) 0px 0px 10px;max-width:100%;width:100%;text-align:center;">MATILDA - Melbourne Algorithm Test Instance </br>Library & Data Archive</h1>
			</div>
		</header>
	
        (your website markup goes here)
      </div>
    </div>
  </div>
</body>
</html>