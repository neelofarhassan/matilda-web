<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
  	#feedback_sub_header {
  	margin-top: 35px;
  	
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
		<header>
                <h1>Question or Feedback !!!</h1>
        </header>
	        <p id="feedback_sub_header">If you have any question or feedback, please get in touch through the form below!</p>
	
	        
		   <c:url var="feedback" value="/feedback" />
	       <form:form  action="${feedback}" method="post" modelAttribute="usermessage">
	             <fieldset>
	             <div>
	                <form:label for="name" path="userName">Name:</form:label>
	                <c:choose>
		                <c:when test="${authenticationStatus}"> 
		                	<form:input type="text" id="name" path="userName" aria-required="true" value="${name}" readonly="true" />
		            	</c:when>
		            	<c:otherwise>
		            	<form:input type="text" id="name" path="userName" aria-required="true" />
		            	</c:otherwise>
	            	</c:choose>
	            </div>
	            <div>
	            	<form:label for="pwd" path="email">Email:</form:label>
	            	<c:choose>
		                <c:when test="${authenticationStatus}"> 
			                <form:input type="email" id="email" path="email" value="${email}" readonly="true" />
	            		</c:when>
		            	<c:otherwise>
			            	<form:input type="email" id="email" path="email" aria-required="true" />
		            	</c:otherwise>
	            	</c:choose>
				</div>
				<div>	            	
	            	<form:label for="message" path="message">Message:</form:label>
	            	<form:textarea id="message" path="message" rows="9" />
	            </div>
<%-- 	            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
	            </fieldset>
	            <div>
	            <button id="submit_message" type="submit" class="button cta">Submit</button>
	            </div>
	        </form:form>
        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>