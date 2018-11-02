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
	  <%@include file="/breadcrumbs.jsp" %>
      <div role="main">
      	<c:url var="home" value="/" />
		<%@include file="/menu.jsp" %>
		<header>
                <h1>Login</h1>
        </header>
        <section>
	        	
	        	<c:url var="loginUrl" value="/login" />
	        	<form action="${loginUrl}" method="post" autocomplete="off">
              	<c:if test="${param.error != null}">
                  	<div id="errorMessage" class="form-error" role="alert" aria-atomic="true" >
                    	  <p>Invalid username or password.</p>
                	  </div>
              	</c:if>
              	<c:if test="${param.logout != null}">
                  	<div class="alert alert-success">
                    	  <p>You have been logged out successfully.</p>
                	  </div>
              	</c:if>
	        
		        <fieldset>				
		        <div>
			        <label for="username" data-required="true">Username:</label>
			        <input id="username" name="ssoId" aria-required="true" type="text" autofocus="autofocus" autocapitalize="off" autocorrect="false" spellcheck="false" />
		        </div>
		
		        <!-- Password Input -->
		        <div>
			        <label for="passwordInput" data-required="true">Password:</label>
			        <input id="passwordInput" aria-required="true" name="password" type="password"/>
		        </div>
		        </fieldset>
		        
		        <div class="input-group input-sm">
		            <div class="checkbox">
		              <label><input type="checkbox" id="rememberme" name="remember-me"> Remember Me</label>  
		            </div>
		        </div>
		        <input type="hidden" name="${_csrf.parameterName}"  value="${_csrf.token}" />
				<input type="hidden" name="previous_request" value="<%=request.getHeader("Referer") %>" />	                  		       
		        
		        <!-- Login Button -->
		        <div>
		        	<button type="submit" value="Login" class="button cta">LOGIN</button>
		        </div>
	        </form>
	        
	        <div id="guestLibrary">
		        <p>
		        	<a href="newuser" class="btn" target="_self">New User? Sign Up.</a>
		        </p>
		        </div>
        </section>


        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>