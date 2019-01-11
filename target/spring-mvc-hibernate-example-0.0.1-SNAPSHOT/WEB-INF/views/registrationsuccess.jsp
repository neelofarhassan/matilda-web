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
	  <%-- 	<%@include file="/breadcrumbs.jsp" %> --%>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>

			<h3><p>Dear ${username}, You have registered successfully.</p></h3>
			 <p>Once approved, we will notify you via email to your registered email address.
			 Registration approval can take 
			 up to a week. <br><br>Please note, you don't need to login to <a href="#">download</a> from our 
			 repository.</p>
         
        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>