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
  <link rel="stylesheet" href="<c:url value="/resources/css/matilda.css" /> ">
  <script src="https://d2h9b02ioca40d.cloudfront.net/v7.0.1/uom.js"></script>
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
			<h1>List of Users</h1>
		</header>
		<table id="users_list">
        	        <thead>
                    <tr>
                        <th><h2>First Name</h2></th>
                        <th><h2>Last Name</h2></th>
                        <th><h2>Email</h2></th>
                        <th><h2>SSO ID</h2></th>
                        <th><h2>Affiliation</h2></th>
                        <th><h2>Research Description</h2></th>
                        <th><h2>Status</h2></th>
                        <th><h2>Edit</h2></th>
                        <th><h2>Delete</h2></th>
                        <th><h2>Approve</h2></th>
<%--                         <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')"> --%>
<!--                             <th width="100"></th> -->
<%--                         </sec:authorize> --%>
<%--                         <sec:authorize access="hasRole('ADMIN')"> --%>
<!--                             <th width="100"></th> -->
<%--                         </sec:authorize> --%>
                         
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
                        <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')">
                        	<td><a href="<c:url value='/edit-user-${user.ssoId}' />" ><button class="button cta">Edit</button></a></td>
                        	<td><a href="<c:url value='/delete-user-${user.ssoId}' />" ><button class="button cta">Delete</button></a></td>
                        	
                        		<td><a href="<c:url value='/approveuser-${user.ssoId}' />" >
                        		<c:choose><c:when test="${user.status ne 'approved'}"><button class="button cta">Approve</button></c:when >
                        		<c:otherwise><button class="button cta disabled">Approve</button> </c:otherwise></c:choose> </a></td>
                        	
                        </sec:authorize>
<%--                        <c:if test="${!userapproval}">  --%>
<%--                         <sec:authorize access="hasRole('ADMIN') or hasRole('DBA')"> --%>
<%--                             <td><a href="<c:url value='/edit-user-${user.ssoId}' />" class="btn btn-success custom-width">Edit</a></td> --%>
<%--                         </sec:authorize> --%>
<%--                         <sec:authorize access="hasRole('ADMIN')"> --%>
<%--                             <td><a href="<c:url value='/delete-user-${user.ssoId}' />" class="btn btn-danger custom-width">Delete</a></td> --%>
<%--                         </sec:authorize> --%>
<%--                         </c:if> --%>
<%--                         <c:if test="${userapproval}"> --%>
<%--                         <td><a href="<c:url value='/approveuser-${user.ssoId}' />" class="btn btn-success custom-width">Approve</a></td> --%>
<%--                         </c:if> --%>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
	

        <%@include file="/footer.jsp" %>
      </div>
    </div>
  </div>
</body>
</html>