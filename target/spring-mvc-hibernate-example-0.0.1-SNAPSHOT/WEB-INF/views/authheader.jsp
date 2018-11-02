    <%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:url var="logout" value="/logout" />
<c:url var="login" value="/login" />
<c:choose>
    <c:when test="${authenticationStatus}">
       <div class="page-local-login" data-href="${logout}" data-title="Logout"></div>
    </c:when>    
    <c:otherwise>
        <div class="page-local-login" data-href="${login}" data-title="Login"></div>
    </c:otherwise>
</c:choose>
</body>
</html>