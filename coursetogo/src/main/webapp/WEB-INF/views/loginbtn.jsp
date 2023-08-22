<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/loginbtn.css">
</head>
<body>
	<div class="loginAndSignup">
		<c:if test="${empty sessionScope.user.userId}">
			<div class="loginbtn">
       			<a href="${sessionScope.apiURL}" ><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
    		</div>
		</c:if>
		<c:if test="${not empty sessionScope.user.userId}">
			<div class="withBackground">
				<div class="userPhoto" id="img">
				  <img src="${sessionScope.user.userPhoto}" height="25px">	
				</div>
				<div id="text"> 
					<div class="userName">
					  	${sessionScope.user.userNickname} 님
					</div>
					<div class="userEmail">
						${sessionScope.user.userEmail}
					</div>
				</div>
			</div>
		</c:if>
	</div>
</body>
</html>
