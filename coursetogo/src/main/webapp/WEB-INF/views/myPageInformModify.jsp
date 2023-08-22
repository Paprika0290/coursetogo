<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.spring.coursetogo.dto.CtgUserDTO" %>
<c:set var="userId" value="${sessionScope.user.userId}" />


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인 정보 수정</title>
	<link rel="stylesheet" href="css/myPageInform.css">
	<link rel="stylesheet" href="css/sidebar.css">
	<style>
	#on {
		background-color: #daeefe;
	}

	footer {
	    position: absolute;
	    bottom: 0;
	    left: 0;
	    width: 100%;
	    border-top: 1px solid #e4e4e4;
	    background-color:#f8f9fa;
	    padding:1rem 0;
	    margin:1rem 0;
	    transform: translateY(150px);
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
	</style>
</head>
<body>
	<!-- 사이드바 -->
	<form action="myPageInformModify" method="GET" name="sidebarForm" id="sidebarForm">
		<div class="sidebar">
		    <div class="logo">Course To Go</div>
		    <ul>
		    	<li><input type="button" class="home" value="홈" onclick="location.href='/home'"></li>
	       		<li><input type="button" class="course" value="코스" onclick="location.href='/courseListWithPagination'"></li>
	    		<li><input type="button" class="create-course" value="코스 제작"  onclick="location.href='/naverMap'"></li>
       			<li><input type="button" class="mypage" value="마이페이지" onclick="location.href='/userContents'"></li>
		    	<c:if test="${not empty sessionScope.user.userId}">
		    		<li class="profile"><img src="${sessionScope.user.userPhoto}" alt="프로필 사진"></li>
			        <li class="name">${sessionScope.user.userNickname} 님</li>
			        <li><input type="button" class="logout-btn" value="로그아웃" onclick="location.href='/logout'"></li>
			        <li><input type="button" class="edit-profile-btn" value="개인정보 수정" id="on" onclick="location.href='/myPageInformModify'" ></li>
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
	
	<form action="/myPageInformModify" method="POST">
		<div class="myPageInform">
			<table>
				<tr>
 					<td style="width: 500px;">
 						<div align="center" id="left-column" width="500px">
							<div class="imgArea">
								<div class="title"><h1>프로필</h1></div>
								<img id="profileImage" src="${sessionScope.user.userPhoto}" alt="profileImage" width="80" height="80">
								<p><h3>${sessionScope.user.userName}</h3></p>
								<p><h4 style="color: grey;">${sessionScope.user.userEmail}</h4></p>
								<div class = "user-count">
									<div id="my-course"><h4>${sessionScope.myCourseCount}</h4><h4 style="color: grey;">나의 코스</h4></div>
									<div id="bookmark-course"><h4>${sessionScope.myBookmarkCount}</h4><h4 style="color: grey;">찜한 코스</h4></div>
									<div id="my-review"><h4>${sessionScope.myReviewCount}</h4><h4 style="color: grey;">나의 리뷰</h4></div>
								</div><br/>
								<div class="img-btn">
									<button class="button" id="fix" onclick="showSampleImages()">프로필 사진 수정하기</button>
									<button class="button" id="delete" onclick="deleteProfileImage()">프로필 사진 삭제하기</button>
								</div>
							</div>
						</div>
					</td>
					<td>
 						<div align="center" id="right-column" class="textArea">
							<div >
							<div class="title"><h1>User Info</h1></div>
								<h3 class="profileH3">닉네임</h3>
								<input id="userNickname" class="userNickname" type="text" name="userNickname" value="${sessionScope.user.userNickname}" maxlength="8">
								<span id="userNickname-check" style="display:block; font-size: 2px; width:400px; height:20px;"></span>
								<h3 class="profileH3">자기소개</h3>
								<input class="introduce" type="text" name="userIntroduce" value="${sessionScope.user.userIntroduce}" maxlength="50"><br>
								<input type="hidden" name="userPhoto" id="userPhoto" value="${sessionScope.user.userPhoto}">
							</div>
							<br/>
							<div>
								<input id="editcomplete" class="button" type="submit" value="프로필 수정 완료" onclick="updateProfile()">
								<input id="unsign" class="button" type="button" value="회원 탈퇴" onclick="unsignConfirm()">
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>
	</form>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script>
	$(document).ready(function() {
  		// 닉네임 중복 검사==============================================================================
		$('#userNickname').keyup(function() {
			var userNickname = $('#userNickname').val();
			$.ajax({
				url: "/myPageInformModify/nicknameCheck",
				type: "get",
				data: {
					userNickname: userNickname
				},
				success: function(res) {
					if(res == 1) {
						$("#userNickname-check").html('이미 사용중인 닉네임입니다.');
						$("#userNickname-check").css({
							  'color': 'red',
							  'font-weight': 'bold'
						});
						duplicateNickname();
					} else if(res == 0) {
						$("#userNickname-check").html('사용 가능한 닉네임입니다.');
						$("#userNickname-check").css({
							  'color': '#4c92b1',
							  'font-weight': 'bold'
						});
						updateProfile();
					} else if(res == -1) {
						$("#userNickname-check").html('닉네임을 입력해주세요.(닉네임은 비어있을 수 없습니다.)');
						$("#userNickname-check").css({
							  'color': 'red',
							  'font-weight': 'bold'
						});
						duplicateNickname();
					}
				},
					error: function() {
					alert("서버 요청 실패");
				}
			});
		});
  		
		  // 프로필 수정 완료 버튼 클릭 시 현재 이미지 태그의 src 값을 userPhoto에 저장
		  function updateProfile() {
			var editCompleteButton = document.getElementById("editcomplete");
		    editCompleteButton.setAttribute("type", "submit");
		    editCompleteButton.setAttribute("onclick", "updateProfile()");
		  }

		  function duplicateNickname() {
			var editCompleteButton = document.getElementById("editcomplete");
			editCompleteButton.setAttribute("type", "button");
			editCompleteButton.setAttribute("onclick", "duplicateNickname()");
		  }
	});
	
		// 사용 가능한 닉네임일 때 프로필 수정 완료 버튼 클릭 시 현재 이미지 태그의 src 값을 userPhoto에 저장	
		function updateProfile() {
		    var confirmResult = confirm("변경하시겠습니까?");
		    if (confirmResult) {
			    var userPhoto = document.getElementById("userPhoto").value;
			    document.getElementById("profileImage").src = userPhoto;
		    }
		}
		
		// 사용 불가능 닉네임일 때 alert 경고창이 나온 후, 페이지 redirect
		function duplicateNickname() {
			alert("닉네임을 확인해주세요");
		}
		
		// 닉네임 input 기본값 설정 및 이벤트 처리=================================================================
		var userNicknameInput = document.getElementById('userNickname');
		var defaultUserNickname = userNicknameInput.value;

		userNicknameInput.addEventListener('focus', function() {
		    if (userNicknameInput.value === defaultUserNickname) {
		        userNicknameInput.value = '';
		    }
		});

		userNicknameInput.addEventListener('blur', function() {
		    if (userNicknameInput.value === '') {
		        userNicknameInput.value = defaultUserNickname;
		    }
		});

		// 자기소개 input 기본값 설정 및 이벤트 처리
		var userIntroduceInput = document.querySelector('.introduce');
		var defaultUserIntroduce = userIntroduceInput.value;

		userIntroduceInput.addEventListener('focus', function() {
		    if (userIntroduceInput.value === defaultUserIntroduce) {
		        userIntroduceInput.value = '';
		    }
		});

		userIntroduceInput.addEventListener('blur', function() {
		    if (userIntroduceInput.value === '') {
		        userIntroduceInput.value = defaultUserIntroduce;
		    }
		});


		// 이미지 선택 팝업 창========================================================================
		function showSampleImages() {
			// 이미지 주소
			var imageUrls = [
				"/images/userProfile2.png",
				"/images/userProfile3.png",
				"/images/userProfile4.png",
				"/images/userProfile5.png",
				"/images/userProfile6.png",
				"/images/userProfile7.png",
				"/images/userProfile8.png",
				"/images/userProfile9.png",
				"/images/userProfile10.png",
				"/images/userProfile11.png",
				"/images/userProfile12.png",
				"/images/userProfile13.png",
				"/images/userProfile14.png",
				"/images/userProfile15.png",
				"/images/userProfile16.png"
			];
			
			var popupWidth = 500;
			var popupHeight = 500;
			var screenWidth = window.screen.width;
			var screenHeight = window.screen.height;
			var top = (screenHeight - popupHeight) / 1.5 - (screenHeight * 0.3);
			var left = (screenWidth - popupWidth) / 2;
	
			var popup = window.open("", "_blank", "width=" + popupWidth + ",height=" + popupHeight + ",top=" + top + ",left=" + left);
			var html = "<html><body><div align='center'><h1>프로필 사진 선택</h1></br><h3>프로필 수정 완료 버튼을 클릭해야 최종 변경됩니다!</h3>";
			
			// 팝업창에 이미지 반목문으로 1~16출력
			for (var i = 0; i < imageUrls.length; i++) {
				var imageUrl = imageUrls[i];
				// 이미지 클릭 시, 부모 창의 selectImage 함수 호출하여 이미지 URL 전달
				html += "<img src='" + imageUrl + "' alt='profileImage' width='80' height='80' onclick='window.opener.selectImage(\"" + imageUrl + "\")'> ";
			}
			
			html += "<br><br><button onclick='window.close()'>확인</button>";
			html += "</div></body></html>";
			popup.document.write(html);
		}
		
		// 팝업창에서 이미지 선택 시 개인정보 수정창의 이미지 변경(src값을 변경)
		function selectImage(imageUrl) {
			document.getElementById("profileImage").src = imageUrl;
			document.getElementById("userPhoto").value = imageUrl;
		}
		
		// 프로필 수정 완료 버튼 클릭 시 현재 이미지 태그의 src 값을 userPhoto에 저장	
		function updateProfile() {
		    var confirmResult = confirm("변경하시겠습니까?");
		    if (confirmResult) {
			    var userPhoto = document.getElementById("userPhoto").value;
			    document.getElementById("profileImage").src = userPhoto;
		    }
		}
		
		// 프로필 사진 삭제 버튼 클릭 시 기본이미지(userProfile1.png)로 변경 및 userPhoto에 저장
		function deleteProfileImage() {
			document.getElementById("profileImage").src = "/images/userProfile1.png";
 			document.getElementById("userPhoto").value = "/images/userProfile1.png";
		}
		
		// 회원탈퇴 버튼 클릭 시 사용자에게 확인을 요청하는 알림창
		function unsignConfirm() {
			var confirmResult1 = confirm("정말로 회원을 탈퇴하시겠습니까?");
			if (confirmResult1) {
				var confirmResult2 = confirm("탈퇴 후에는 이전 정보를 되돌릴 수 없습니다. 탈퇴하시겠습니까?");
				if(confirmResult2) {
					unsignUser();
				}
			}
		}
		
		// 알림창에서 확인버튼 클릭 시 회원탈퇴===============================================================
	    function unsignUser() {
	    	var userId = parseInt('<%= pageContext.getAttribute("userId") %>');
	
	        var form = document.createElement('form');
	        form.method = 'POST';
	        form.action = '/myPageInformModify';
	
	        var input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = '_method';
	        input.value = 'PUT';
	        form.appendChild(input);
	
	        input = document.createElement('input');
	        input.type = 'hidden';
	        input.name = 'userId';
	        input.value = userId;
	        form.appendChild(input);
	
	        document.body.appendChild(form);
	        form.submit();
		}
	</script>
	
   	<footer>
	  <div class="inner">
	  	<div class = "withoutSidebar">
		    <div class="footer-message">당신의 휴일이 즐거움으로 가득하도록. 즐거운 CourseToGo 되세요.</div>
		    <div class="footer-contact">📧  p0209y@gmail.com</div>
		    <div class="footer-copyright">© 2023 6CanDoIt All rights reserved</div>
		</div>
	  </div>
	</footer>
</body>
</html>
