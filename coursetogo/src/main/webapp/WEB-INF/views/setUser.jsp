<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>개인 정보 수정</title>
	<link rel="stylesheet" href="css/setUser.css">
</head>
<body>
	<%@ include file="sidebar.jsp" %>
	
	<form action="/signupDone" method="POST">
		<div class="myPageInform">
			<table>
				<tr>
 					<td style="width: 500px;">
 						<div align="center" id="left-column" width="500px">
							<div class="imgArea">
								<div class="title"><h1>프로필</h1></div>
								<img id="profileImage" src="/images/userProfile1.png" alt="profileImage" width="80" height="80">
								<p><h3>${sessionScope.newUser.userName}</h3></p>
								<p><h4 style="color: grey;">${sessionScope.newUser.userEmail}</h4></p>
								<div class="img-btn">
								</div>
							</div>
						</div>
					</td>
					<td>
 						<div align="center" id="right-column" class="textArea">
							<div >
							<div class="title"><h1>User Info</h1></div>
								<h3 class="profileH3">닉네임</h3>
								<input id="userNickname" class="userNickname" type="text" name="userNickname" value="${sessionScope.newUser.userNickname}" maxlength="8">
								<span id="userNickname-check" style="display:block; font-size: 2px; width:400px; height:20px;"></span>
								<h3 class="profileH3">자기소개</h3>
								<input class="introduce" type="text" name="userIntroduce" value="${sessionScope.newUser.userIntroduce}" maxlength="50"><br>
								<input type="hidden" name="userPhoto" id="userPhoto" value="${sessionScope.newUser.userPhoto}">
							</div>
							<br/>
							<div>
								<input id="editcomplete" class="button" type="submit" value="회원 가입" onclick="updateProfile()">
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
				url: "/signupDone/nicknameCheck",
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
		    var confirmResult = confirm("가입하시겠습니까?");
		    if (confirmResult) {
			    var userPhoto = document.getElementById("userPhoto").value;
			    document.getElementById("profileImage").src = userPhoto;
		    }
		}
		
		// 사용 불가능 닉네임일 때 alert 경고창이 나온 후, 페이지 redirect
		function duplicateNickname() {
			alert("닉네임을 확인해주세요");
		}
	</script>
</body>
</html>