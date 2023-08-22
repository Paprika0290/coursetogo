<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>myPage</title>
	</head>
<body>
	<div class="container">
		<!-- 사이드바 -->
		<div class="sidebar">
			<%@ include file="sidebar.jsp" %>
		</div>
		<!-- 마이페이지 메인 -->
		<div class="myPage">
			<%@ include file="setUser.jsp" %>
		</div>
	</div>
</body>
</html>