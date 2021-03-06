<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<meta content="IE=edge" http-equiv="X-UA-Compatible" />
<title>Matilda</title>
<link rel="stylesheet"
	href="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.css">
<script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
<link href="<c:url value='/resources/css/app.css' />" rel="stylesheet"></link>
<link href="<c:url value='/resources/css/matilda.css' />" rel="stylesheet"></link>
<script src="https://www.google.com/recaptcha/api.js"></script>
<script type="text/javascript" src="<c:url value="/resources/scripts/matilda.js" /> "></script>
</head>
<body>

	<div class="uomcontent">
		<div class="page-inner">
			<%@include file="/breadcrumbs.jsp" %>
			<div role="main">
				<c:url var="home" value="/" />
				<%@include file="/menu.jsp"%>
				<header>
					<h1>Register</h1>
				</header>
				<%@include file="authheader.jsp"%>
				
				<c:url var="action" value="/newuser" />
				<form:form method="POST" action="${action}" modelAttribute="user"
					autocomplete="on">
					<form:input type="hidden" path="id" id="id" />

					<fieldset>
						<div>
							<label for="ssoId" data-required="true">User Name</label>
							<c:choose>
								<c:when test="${edit}">
									<form:input type="text" path="ssoId" id="ssoId"
										aria-required="true" autofocus="autofocus"
										autocapitalize="off" autocorrect="false" spellcheck="false"
										disabled="true" />
								</c:when>
								<c:otherwise>
									<form:input type="text" path="ssoId" id="ssoId"
										aria-required="true" autofocus="autofocus"
										autocapitalize="off" autocorrect="false" spellcheck="false" />
									<div class="has-error">
										<form:errors path="ssoId" class="help-inline" />
									</div>
								</c:otherwise>
							</c:choose>
						</div>

						<div>
							<label for="firstName" data-required="true">First Name</label>
							<form:input type="text" path="firstName" id="firstName"
								aria-required="true" autofocus="autofocus" autocapitalize="off"
								autocorrect="false" spellcheck="false" />
							<div class="has-error">
								<form:errors path="firstName" class="help-inline" />
							</div>
						</div>

						<div>
							<label for="lastName" data-required="true">Last Name</label>
							<form:input type="text" path="lastName" id="lastName"
								aria-required="true" />
							<div class="has-error">
								<form:errors path="lastName" />
							</div>
						</div>

						<div>
							<label for="password" data-required="true">Password</label>
							<form:input type="password" path="password" id="password"
								aria-required="true" />
							<div class="has-error">
								<form:errors path="password" class="help-inline" />
							</div>
						</div>

						<div>
							<label for="email" data-required="true">Email</label>
							<form:input type="text" path="email" id="email"
								aria-required="true" />
							<div class="has-error"> 
								<form:errors path="email" />
							</div>
						</div>
						<div>
							<label for="affiliation" data-required="true">Institution/Company</label>
							<form:input type="text" path="affiliation" id="affiliation" aria-required="true" />
							<div class="has-error"> 
								<form:errors path="affiliation" />
							</div>
						</div>

						<div>
							<label><span class="tooltip">Short Research Description<img src="<c:url value="resources/images/info.png" />" width="15" height="15"><span class="tooltiptext">
							Please provide a brief description of how you wish to interact with our repository. This information
							helps us to maintain the security and data quality regulations. 
							</span></span></label>
							<form:textarea path="researchDescription" id="research_description" aria-required="true" />
							<div class="has-error"> 
								<form:errors path="researchDescription" />
							</div>
						</div>
							
							<div class="g-recaptcha" data-sitekey="6Ldso3kUAAAAAJiQwokosrghpu_t5UJjuiYcWbVF"></div>
							<div class="has-error">
								<form:errors path="captchaError" />
							</div>
							
						<form:hidden path="status" id="status" value="waiting" />
						<form:hidden path="userProfiles" id="userProfiles" value="1" />
					</fieldset>

					<div>
						<button type="submit" value="Register" class="button cta">Register</button>
					</div>

				</form:form>

				<!--Creates the popup body-->

				<%@include file="/footer.jsp"%>
			</div>
		</div>
	</div>
</body>
</html>

