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
<script type="text/javascript">
	$(document).ready(function() {
		$('[data-toggle="tooltip"]').tooltip();
	});
</script>
<style>
.popup-overlay {
	/*Hides pop-up when there is no "active" class*/
	visibility: hidden;
	position: absolute;
	background: #ffffff;
	border: 3px solid #666666;
	width: 50%;
	height: 200px;
	left: 25%;
}

.popup-overlay.active {
	visibility: visible;
	text-align: center;
}

.popup-content {
	visibility: hidden;
}

.popup-content.active {
	visibility: visible;
}

button {
	display: inline-block;
	vertical-align: middle;
	border-radius: 30px;
	margin: .20rem;
	font-size: 1rem;
	color: #666666;
	background: #ffffff;
	border: 1px solid #666666;
}

button:hover {
	border: 1px solid #666666;
	background: #666666;
	color: #ffffff;
}

#main_container {
	padding-top: 50px;
	padding-bottom: 50px;
}
</style>
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
							<label for="lastName">Last Name</label>
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
							<div>
								<form:errors path="email" />
							</div>
						</div>
						<div>
							<label for="affiliation" data-required="true">Institution/Company</label>
							<form:input type="text" path="affiliation" id="affiliation"
								aria-required="true" />
						</div>

						<div>
							<span>						
							<label for="research_description" data-required="true">Short
								Research Description</label> <a href="#" data-toggle="tooltip" style="text-decoration:none"
								title="hello hello hello hello hello hello hello hello hello hellohello hello hello hello hellohello hello hello hello hellohello hello hello hello hello">Why
								do we need it?</a> 
							</span>
							<form:textarea path="researchDescription"
								id="research_description" aria-required="true" />
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

