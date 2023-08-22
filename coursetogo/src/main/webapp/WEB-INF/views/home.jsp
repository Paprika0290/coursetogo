<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Course To Go</title>
    <style>
    	body {
    		height: 1080px;
    		overflow-x: hidden;
    	}
    		
   	    .placeReviewTop3 img,
	    .placeReviewTop3 span {
	        display: inline-block; /* img와 텍스트를 가로로 나란히 배치 */
	        vertical-align: middle; /* 세로 정렬 기준선을 중앙으로 설정 */
	    }
	
	    .placeReviewTop3 span {
	        margin-left: 5px; /* 아이콘과 텍스트 사이에 5px의 여백 추가 */
	    }
	    
      	.courseReviewTop3 img,
	    .courseReviewTop3 span {
	        display: inline-block; /* img와 텍스트를 가로로 나란히 배치 */
	        vertical-align: middle; /* 세로 정렬 기준선을 중앙으로 설정 */
	    }
	
	    .courseReviewTop3 span {
	        margin-left: 5px; /* 아이콘과 텍스트 사이에 5px의 여백 추가 */
	    }
	    #on {
			background-color: #daeefe;
		}
		
		.recommendCourse,
		.recommendPlace {
		  margin-bottom: 50px; /* 적절한 값을 추가하여 div와 footer 사이에 여백을 만듭니다. */
		}
		
		.courseRecommendBox {
		    position: absolute;
		    top: 530px;
		    left: 230px;
		    box-sizing: border-box;\
		}
		
		.placeRecommendBox {
		    position: absolute;
		    top: 530px;
		    right: 30px;
		    box-sizing: border-box;\
		}
		
		.stars::before {
		  content: "★";
		}
		
		.stars[data-score="1"]::before {
		  content: "★";
		  color:#ffd400;
   		  font-size:20px;
		}
		
		.stars[data-score="2"]::before {
		  content: "★★";
		  color:#ffd400;
   		  font-size:20px;	  
		}
		
		.stars[data-score="3"]::before {
		  content: "★★★";
		  color:#ffd400;
   		  font-size:20px;
  		}
		
		.stars[data-score="4"]::before {
		  content: "★★★★";
		  color:#ffd400;
   		  font-size:20px;
		}
		
		.stars[data-score="5"]::before {
		  content: "★★★★★";
		  color:#ffd400;
   		  font-size:20px;
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
    	<link rel="stylesheet" href="css/sidebar.css">
</head>
<body>

	<!-- 사이드바 -->
	<form action="/home" method="GET" name="sidebarForm" id="sidebarForm">
		<div class="sidebar">
		    <div class="logo">Course To Go</div>
		    <ul>
		    	<li><input id="on" type="button" class="home" value="홈" onclick="location.href='/home'"></li>
	       		<li><input type="button" class="course" value="코스" onclick="location.href='/courseListWithPagination'"></li>
	    		<li><input type="button" class="create-course" value="코스 제작"  onclick="location.href='/naverMap'"></li>
	    		<c:if test="${empty sessionScope.user.userId}">
	    			<li><input type="button" class="mypage" value="마이페이지" onclick="notLogin()"></li>
	    		</c:if>
       			
		    	<c:if test="${not empty sessionScope.user.userId}">
		    		<li><input type="button" class="mypage" value="마이페이지" onclick="location.href='/userContents'"></li>
		    		<li class="profile"><img src="${sessionScope.user.userPhoto}" alt="프로필 사진"></li>
			        <li class="name">${sessionScope.user.userNickname} 님</li>
			        <li><input type="button" class="logout-btn" value="로그아웃" onclick="location.href='/logout'"></li>
			        <li><input type="button" class="edit-profile-btn" value="개인정보 수정" onclick="location.href='/myPageInformModify'" ></li>
		    	</c:if>
		    </ul>
		</div>
	</form>
    <!-- 랭킹 -->
    <div style="display: flex;
    			margin-left: 250px;">
    			
	    <div class = "courseMakeKing"
	    	 style = "background-color: #DAF3FD;
	    			  margin-top:50px;
	    			  width: 200px;
	    			  border-radius: 5px;
	    			  border: 2px solid #85C6E2;
	    			  text-align: center;">
	    	<b>코스 작성 TOP3</b><br>
				<div class="courseReviewTop3">
				    <c:forEach items="${requestScope.courseMakeKingUserIds}" var="userId" varStatus="kingSt">
				        <c:choose>
				            <c:when test="${kingSt.index == 0}">
				                <img src="/images/goldMedal.png" alt="gold">
				            </c:when>
				            <c:when test="${kingSt.index == 1}">
				                <img src="/images/silverMedal.png" alt="silver">
				            </c:when>
				            <c:when test="${kingSt.index == 2}">
				                <img src="/images/bronzeMedal.png" alt="bronze">
				            </c:when>
				        </c:choose>
				        <span>
				            <c:forEach items="${requestScope.courseMakeKingUserNicknames}" var="courseKingNick" varStatus="courseKingNickSt">
				                <c:if test="${kingSt.index eq courseKingNickSt.index}">
				                    ${courseKingNick}
				                </c:if>
				            </c:forEach>
				        </span>
				        <br>
				    </c:forEach>
				</div>
	    </div>

	    <div class = "courseReveiwKing"
    		 style = "background-color: #DAF3FD;
	    			  margin-top:50px;
	    			  width: 200px;
	    			  border-radius: 5px;
	    			  border: 2px solid #85C6E2;
	    			  text-align: center;
	    			  margin-left:50px;">
	    	<b>코스 리뷰 TOP3</b><br>
				<div class="courseReviewTop3">
				    <c:forEach items="${requestScope.courseReviewKingUserIds}" var="userId" varStatus="kingSt">
				        <c:choose>
				            <c:when test="${kingSt.index == 0}">
				                <img src="/images/goldMedal.png" alt="gold">
				            </c:when>
				            <c:when test="${kingSt.index == 1}">
				                <img src="/images/silverMedal.png" alt="silver">
				            </c:when>
				            <c:when test="${kingSt.index == 2}">
				                <img src="/images/bronzeMedal.png" alt="bronze">
				            </c:when>
				        </c:choose>
				        <span>
				            <c:forEach items="${requestScope.courseReviewKingUserNicknames}" var="courseKingNick" varStatus="courseKingNickSt">
				                <c:if test="${kingSt.index eq courseKingNickSt.index}">
				                    ${courseKingNick}
				                </c:if>
				            </c:forEach>
				        </span>
				        <br>
				    </c:forEach>
				</div>
	    </div>	    
	    
	    <div class = "placeReveiwKing" 
	    	 style = "background-color: #DAF3FD;
	    			  margin-top:50px;
	    			  width: 200px;
	    			  border-radius: 5px;
	    			  border: 2px solid #85C6E2;
	    			  text-align: center;
	    			  margin-left:50px;">
	    	<b>장소 리뷰 TOP3</b><br>
				<div class="placeReviewTop3">
				    <c:forEach items="${requestScope.placeReviewKingUserIds}" var="userId" varStatus="kingSt">
				        <c:choose>
				            <c:when test="${kingSt.index == 0}">
				                <img src="/images/goldMedal.png" alt="gold">
				            </c:when>
				            <c:when test="${kingSt.index == 1}">
				                <img src="/images/silverMedal.png" alt="silver">
				            </c:when>
				            <c:when test="${kingSt.index == 2}">
				                <img src="/images/bronzeMedal.png" alt="bronze">
				            </c:when>
				        </c:choose>
				        <span>
				            <c:forEach items="${requestScope.placeReviewKingUserNicknames}" var="placeKingNick" varStatus="placeKingNickSt">
				                <c:if test="${kingSt.index eq placeKingNickSt.index}">
				                    ${placeKingNick}
				                </c:if>
				            </c:forEach>
				        </span>
				        <br>
				    </c:forEach>
				</div>
	    </div>
    </div>
    <div class="container">
        <div class="loginAndSignup">
            <%@ include file="loginbtn.jsp" %>
        </div>
        <!-- 메인 중단부(광고 및 이벤트 배너) -->
        <div class="banner">
        	<%@ include file="banner.jsp" %>
        </div>
        <!-- 메인 하단부(추천 코스 리스트) -->
        <div class="recommendCourse">
        	<div class = "courseRecommendBox">
				<div style = "border-radius: 15px;
							  width: 350px;
							  height: 50px;
							  display: flex;
						      flex-direction: row;
						      justify-content: left;
						      align-items: center;
						      background-color: #87ceeb;
						      padding-right: 50px;
						      padding-left: 30px;">
						      
						<img src="/example/recommend.png" alt="recommend"
							width= "20px" style= "margin: 10px;">
						<h3 style = "display: inline-block;
			    				 	 white-space: nowrap;
			    				 	 color: white;
			    				 	 font-size: 15pt;">
			    		&nbsp;&nbsp;&nbsp;&nbsp;추천 코스
			    		</h3>
				</div>
		   		<div>	  
						<c:forEach items="${requestScope.courseInformDTOList}" var = "course" varStatus = "courseSt">
							<div style = "margin: 5px;
										  background-color: #f5f5f5;
										  border-bottom:2px solid #D5D5D5;
										  border-radius: 10px;
										  width: 800px;
										  height: 100px;
										  padding-left: 30px;
										  overflow:hidden">
									<div style="display: flex;
												flex-direction: row;
										        justify-content: left;
										        align-items: center;
										        padding-top: 10px;">
										<img src="/example/letsgo.png" alt= "go!" width= "40px;">&nbsp;&nbsp;
			 			                    <c:forEach items="${fn:split(course.courseList, ',')}" var="place">
						                        <div class="item" style = "display: inline-block;
			       								    				 	   white-space: nowrap;
						                        						   padding:5px;
						                        						   background-color: #91B6D0;
						                        						   border-radius:5px;
						                        						   color: #353535;
						                        						   margin-left: 10px;
						                        						   overflow:hidden;"><b>${place}</b></div>
						                    </c:forEach>
											<br>
											<c:choose>
												<c:when test="${course.courseAvgScore == 1.0}">
													<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★</span>
												</c:when>
												<c:when test="${course.courseAvgScore == 2.0}">
													<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★★</span>
												</c:when>
												<c:when test="${course.courseAvgScore == 3.0}">
													<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★★★</span>
												</c:when>
												<c:when test="${course.courseAvgScore == 4.0}">
													<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★★★★</span>
												</c:when>
												<c:when test="${course.courseAvgScore == 5.0}">
													<span style="color:#ffd400; font-size:20px;">&nbsp;&nbsp;&nbsp;★★★★★</span>
												</c:when>
											</c:choose>		    				 
									
									</div>	  
									<div>
		                                 <c:forEach items="${requestScope.courseDetailPageList}" var="coursePage" varStatus="pageSt">
		                                     <c:if test="${courseSt.index eq pageSt.index}">
		                                         <c:set var="query" value="${coursePage}" scope="request" />
		                                     </c:if>
		                                 </c:forEach>
									
										<h4 style="background-color: white;
												   margin-top: 5px;
												   padding-right: 5px;
												   border-radius: 5px;
												   color: #353535;
												   display: inline-block;">	     
		                                <a href="/courseList/Map?${query}">[ ${course.courseName} ]</a>
										</h4>
											<span style="color: black; font-weight: normal;">${course.courseContent}</span>
									</div>
							</div>	
						</c:forEach>
		   		</div>		
			</div>
        </div>
        <!-- 메인 중단부(추천 장소 리스트) -->
        <div class="recommendPlace">
       		<div class = "placeRecommendBox">
			
				<div style = "border-radius: 15px;
							  width: 350px;
							  height: 50px;
							  display: flex;
						      flex-direction: row;
						      justify-content: left;
						      align-items: center;
						      background-color: #87ceeb;
						      padding-right: 50px;
						      padding-left: 30px;">
						      
						<img src="/example/recommend.png" alt="recommend"
							width= "20px" style= "margin: 10px;">
						<h3 style = "display: inline-block; /* 폼 요소를 인라인 블록으로 표시 */
			    				 	 white-space: nowrap;
			    				 	 color: white;
			    				 	 font-size: 15pt;">
			    		&nbsp;&nbsp;&nbsp;&nbsp;추천 장소
			    		</h3>
				</div>
				
		   		<div>	  
						<c:forEach items="${requestScope.placeDTOList}" var = "place" varStatus = "placeSt">
							
							<div style = "margin: 5px;
										  background-color: #f5f5f5;
										  border-bottom:2px solid #D5D5D5;
										  border-radius: 10px;
										  width: 800px;
										  height: 100px;
										  padding-left: 30px;
										  overflow:hidden;">
								
									<div style="display: flex;
												flex-direction: row;
										        justify-content: left;
										        align-items: center;
										        margin-top:0px;
										        margin-bottom:0px;
												padding-top:0px;
												padding-bottom:0px;">
								
										<img style="padding-top:0px;
													padding-bottom:0px;" src="/example/letsgo.png" alt= "go!" width= "40px;">&nbsp;&nbsp;
												<h4 style="background-color: white;
														   padding-right: 5px;
														   border-radius: 5px;
														   color: #353535;
														   padding-top:0px;
														   padding-bottom:0px;">	     
													[ ${place.placeName} ]
												</h4>
												<c:choose>
													<c:when test="${place.placeAvgScore >= 0.0 && place.placeAvgScore < 1.0}">
														<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;</span>
													</c:when>
													<c:when test="${place.placeAvgScore >= 1.0 && place.placeAvgScore < 2.0}">
														<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★</span>
													</c:when>
													<c:when test="${place.placeAvgScore >= 2.0 && place.placeAvgScore < 3.0}">
														<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★★</span>
													</c:when>
													<c:when test="${place.placeAvgScore >= 3.0 && place.placeAvgScore < 4.0}">
														<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★★★</span>
													</c:when>
													<c:when test="${place.placeAvgScore >= 4.0 && place.placeAvgScore < 5.0}">
														<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★★★★</span>
													</c:when>
													<c:when test="${place.placeAvgScore == 5.0}">
														<span style="color:#ffd400; padding-bottom:0px;">&nbsp;&nbsp;&nbsp;★★★★★</span>
													</c:when>
												</c:choose>		    				 
									</div>	  
								<h4 style="display: inline-block;
										   margin-top: 0px;
										   margin-bottom: 10px;
										   font-weight: normal;
										   color: black;">${place.address}</h4>
							</div>					
						</c:forEach>			
		   		</div>			
			</div>
        </div>
    </div>
    
    <script>
    	function notLogin() {
    		alert("로그인 시 이용가능한 서비스입니다.");
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