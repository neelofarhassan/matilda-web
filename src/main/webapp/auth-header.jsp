<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	 <sec:authorize access="isAnonymous()">
    	<div class="page-local-login" data-href="login" data-title="Login"></div>
    </sec:authorize>
	<sec:authorize access="isAuthenticated()">
	    <div class="page-local-login" data-href="logout" data-title="Logout"></div>
	</sec:authorize>
</body>
</html>