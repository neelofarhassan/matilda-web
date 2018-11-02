<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
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
			    <div class="generic-container">
        <%@include file="authheader.jsp" %>   
        <div class="panel panel-default">
              <!-- Default panel contents -->
            <div class="panel-heading"><span class="lead">List of Users </span></div>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Firstname</th>
                        <th>Lastname</th>
                        <th>Email</th>
                        <th>SSO ID</th>
                        <th>Affiliation</th>
                        <th>Research Description</th>
                        <th>Status</th>
                        <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
                            <th width="100"></th>
                        </sec:authorize>
                        <sec:authorize access="hasRole('ADMIN')">
                            <th width="100"></th>
                        </sec:authorize>
                         
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${users}" var="user">
                    <tr>
                        <td>${user.firstName}</td>
                        <td>${user.lastName}</td>
                        <td>${user.email}</td>
                        <td>${user.ssoId}</td>
                        <td>${user.affiliation}</td>
                        <td>${user.researchDescription}</td>
                        <td>${user.status}</td>
                        <c:if test="${param.error != null}">
                  	<div id="errorMessage" class="form-error" role="alert" aria-atomic="true" >
                    	  <p>Invalid username or password.</p>
                	  </div>
              	</c:if>
                        
                        
                       <c:if test="${!userapproval}"> 
                        <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
                            <td><a href="<c:url value='/edit-user-${user.ssoId}' />" class="btn btn-success custom-width">Edit</a></td>
                        </sec:authorize>
                        <sec:authorize access="hasRole('ADMIN')">
                            <td><a href="<c:url value='/delete-user-${user.ssoId}' />" class="btn btn-danger custom-width">Delete</a></td>
                        </sec:authorize>
                        </c:if>
                        <c:if test="${userapproval}">
                        <td><a href="<c:url value='/approveuser-${user.ssoId}' />" class="btn btn-success custom-width">Approve</a></td>
                        </c:if>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <sec:authorize access="hasRole('ADMIN')">
            <div class="well">
                <a href="<c:url value='/newuser' />">Add New User</a>
            </div>
        </sec:authorize>
    </div>
	

        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>