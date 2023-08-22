<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="../css/sidebar.css">
</head>
<body>
	<form action="/home" method="GET" name="sidebarForm" id="sidebarForm">
		<div class="sidebar">
		    <div class="logo"><a href="/"><img src="/images/logo.png"></a></div>
		    <ul>
		    	<li><input type="button" class="home" value="홈" onclick="location.href='/home'"></li>
	       		<li><input type="button" class="course" value="코스" onclick="location.href='/courseListWithPagination'"></li>
	    		<li><input type="button" class="create-course" value="코스 제작"  onclick="location.href='/naverMap'"></li>
       			<li><input type="button" class="mypage" value="마이페이지" onclick="location.href='/userContents'"></li>
		    	<c:if test="${not empty sessionScope.user.userId}">
		    		<li class="profile"><img src="${sessionScope.user.userPhoto}" alt="프로필 사진"></li>
			        <li class="name">${sessionScope.user.userNickname} 님</li>
			        <li><input type="button" class="logout-btn" value="로그아웃" onclick="location.href='/logout'"></li>
			        <li><input type="button" class="edit-profile-btn" value="개인정보 수정" onclick="location.href='/myPageInformModify'" ></li>
		    	</c:if>
		    </ul>
		</div>
	</form>
	
	<script>
		function notLogin() {
		  alert("로그인을 해주세요.");
		}
	</script>
</body>
</html>