<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Course To Go / My Page</title>

	<style>
	
		.button {
			  color: black;
			  font-weight: bold;
			  padding: 10px;
			  border-radius: 10px;
			  text-align: center;
			  background-color: #fff;
			  width: 170px;	
		}
		.button:hover {
		cursor: pointer;
		background-color: #daeefe;
		}
		
		#mycourse:focus, #myreview:focus, #mybookmark:focus {
		background-color: #daeefe;
		}
		
		footer {
	    border-top: 1px solid #e4e4e4;
	    background-color:#f8f9fa;
	    padding:1rem 0;
	    margin:1rem 0;
		}
		
		.footer-message {
		    font-weight: bold;
		    font-size:0.9rem;
		    color:#545e6f;
		    margin-bottom:0.3rem;
		    margin:0 0 0 0.6rem;
		}
		
		.footer-contact {
		    font-size:0.9rem;
		    color:#545e6f;
		    margin:0.6rem;
		}
		
		.footer-copyright {
		    font-size:0.9rem;
		    color:#545e6f;
		    margin:0.6rem;
		}
		
		.withoutSidebar {
		margin-left: calc(5vw + 200px);
		display: flex;
	    flex-direction: column;
	    justify-content: center;
		}
		#on {
	background-color: #daeefe;
}
		
	</style>	
	<link rel="stylesheet" href="css/sidebar.css">	
</head>
<body>
	<!-- 사이드바 -->
	<form action="/userContents" method="GET" name="sidebarForm" id="sidebarForm">
		<div class="sidebar">
		    <div class="logo"><a href="/"><img src="/images/logo.png"></a></div>
		    <ul>
		    	<li><input type="button" class="home" value="홈" onclick="location.href='/home'"></li>
	       		<li><input type="button" class="course" value="코스" onclick="location.href='/courseListWithPagination'"></li>
	    		<li><input type="button" class="create-course" value="코스 제작"  onclick="location.href='/naverMap'"></li>
       			<li><input type="button" class="mypage" value="마이페이지" id="on" onclick="location.href='/userContents'"></li>
		    	<c:if test="${not empty sessionScope.user.userId}">
		    		<li class="profile"><img src="${sessionScope.user.userPhoto}" alt="프로필 사진"></li>
			        <li class="name">${sessionScope.user.userNickname} 님</li>
			        <li><input type="button" class="logout-btn" value="로그아웃" onclick="location.href='/logout'"></li>
			        <li><input type="button" class="edit-profile-btn" value="개인정보 수정" onclick="location.href='/myPageInformModify'" ></li>
		    	</c:if>
		    </ul>
		</div>
	</form>
	<!-- 배너 -->	
	<div class = "banner" style = "margin-left: 200px;">
		<img src="/images/advertise.png">
	</div>
	<!-- 로그인/회원정보 -->
	<div class = "loginAndSignup">
		<%@ include file="loginbtn.jsp" %>
	</div>
	<br><br>
	<!-- 버튼 박스 -->	
	<div class = "buttonContainer"
		 style = "margin-left: 200px;
		 		  display: flex;
		 		  justify-content: space-between;" >
		<button class="button" style="margin-left:10%;" onclick="changeContent('/userCourse')" id="mycourse">나의 코스</button>
		<button class="button" onclick="changeContent('/userReview')" id="myreview">나의 리뷰</button>
		<button class="button" style="margin-right:10%;" onclick="changeContent('/userBookmarkList')" id="mybookmark">내가 찜한 코스</button>
	</div>
	<br>
	
	
	
	<!-- 메인 컨텐츠 박스 -->
	<div class = "contentsBox"
		 style = "margin-left: calc(5vw + 200px);
		 		  margin-right: 5vw;
		 		  height: calc(90vh - 200px);
		 		  border-radius: 10px;
		 		  border: 2px solid #ccc;
				  display: flex;
	  			  flex-direction: column;
				  justify-content: left;
				  overflow: auto;">
				  
		<%@ include file="userCourseList.jsp" %>

	</div>
	
	<footer>
	  <div class="inner">
	  	<div class = "withoutSidebar">
		    <div class="footer-message">당신의 휴일이 즐거움으로 가득하도록. 즐거운 CourseToGo 되세요.</div>
		    <div class="footer-contact">📧  p0209y@gmail.com</div>
		    <div class="footer-copyright">© 2023 6CanDoIt All rights reserved</div>
		</div>
	  </div>
	</footer>

	<script>
		function changeContent(page) {
			  var contentsBox = document.querySelector('.contentsBox');
	
			  // AJAX를 사용하여 JSP 파일의 내용을 가져옴
			  var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState === 4 && this.status === 200) {
			      contentsBox.innerHTML = this.responseText;
			    }
			  };
	
			  // 요청 보내기
			  xhttp.open('GET', page, true);
			  xhttp.send();
			}
		
		// 버튼 클릭 시 해당 버튼 focus 적용
 		var currentUrl = window.location.href;;
		
		var mycourse = '/userCourse';
		var myreview = '/userReview';
		var mybookmark = '/userBookmarkList';

		
		if(currentUrl.includes(mycourse)) {
			document.getElementById('mycourse').focus();
		} else if(currentUrl.includes(myreview)) {
			document.getElementById('myreview').focus();
		} else if(currentUrl.includes(mybookmark)) {
			document.getElementById('mybookmark').focus();
		}
	</script>

</body>
</html>