<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course To Go / Review</title>
	<style>
		div[class^=starsscore]{
		 text-align:center;
		 display:flex;
		 direction: rtl;
		 justify-content: flex-end;
		 font-size:28px;
		 padding:0 .2em;
		}
		
		div[class^=starsscore] input{
		display:none;
		}
		
		div[class^=starsscore] label {
		  color:#ccc;
		  cursor:pointer;
		}
		
		div[class^=starsscore] :checked ~ label{
		  color:#ffd400;
		}
		
		div[class^=starsscore] label:hover,
		div[class^=starsscore] label:hover ~ label {
		  color:#ffd700;
		}
		
		div[class^=courseStarsscore]{
		 text-align:center;
		 display:flex;
		 direction: rtl;
		 justify-content: flex-end;
		 font-size:40px;
		 padding:0 .2em;
		}
		
		div[class^=courseStarsscore] input{
		display:none;
		}
		
		div[class^=courseStarsscore] label {
		  color:#ccc;
		  cursor:pointer;
		}
		
		div[class^=courseStarsscore] :checked ~ label{
		  color:#ffd400;
		}
		
		div[class^=courseStarsscore] label:hover,
		div[class^=courseStarsscore] label:hover ~ label {
		  color:#ffd700;
		}
		
		.insert-button {
		 color: black;
		 font-weight: bold;
		 padding: 10px;
		 border-radius: 10px;
		 text-align: center;
		 background-color: #fff;
		 width: 170px;
		  }
		 
		.insert-button:hover {
         background-color: #daeefe;
        }
        
	</style>
</head>
<body>
	<!-- 사이드바 -->
  <div class = "sidebar">
		<%@ include file = "sidebar.jsp" %>
  </div>  	
  	<!-- 사이드바 제외 메인페이지 -->
  <div class = "mainpage">
  	<!-- 배너 -->	
 		<div class = "banner" style = "margin-left: 200px;">
			<img src="/images/advertise.png">
		</div> 	
	<!-- 로그인/회원정보 -->
	 	<div class = "loginAndSignup">
			<%@ include file="loginbtn.jsp" %>
		</div> 	
		<br><br>
	<div style = "margin-left: 200px;
    	 		  background-color: white;
    	 		  display: flex;
				  justify-content: center;
				  align-items: center;">
				  
		<div class = "courseInfo"
			 style = "height: auto;
			 		  width: 500px;
			 		  background-color: #fafafa;
			 		  border-radius: 5px;
			 		  border: 2px solid #fafafa;
					  display: flex;
		  			  flex-direction: column;
					  justify-content: center;
	  				  align-items: center;
					  padding: 5px;">
			<img width = "100px" src="https://github.com/Paprika0290/Paprika0290/assets/59499235/95acfb73-d521-42c2-b85d-49a6f22af4ca"><br>

			<span style = "width: 480px;
						   height: auto;
						   background-color: white;
						   text-align: center;
	   			 		   border-radius: 5px;
			 		  	   border: 2px solid #fafafa;">
			 		  	   
			  <b style="color: blue;">${courseInform.userNickName}</b>&nbsp;님의&nbsp;<b style="color: blue;">${courseInform.courseName}</b>&nbsp;코스<br>	<b style="color: grey">${courseInform.courseContent}</b>

			</span>

		</div>
	</div>
	<br>
	
	<!-- placeReview + courseReview 박스-->
	<form action="/setreview" method="POST" id = "review" >
	<!-- placeReview 박스 -->	
	    <div class = "placereview" id = "placereview"
	    	 style = "margin-left: 200px;
	    	 		  background-color: #fafafa;
	    	 		  display: flex;
					  justify-content: center;
					  align-items: center; ">
					  

					  
			<c:forEach items= "${placeList}" var= "placeDTO" varStatus= "placeSt">
				<div class = "place"
				     style = "margin: 5px;
    	 				      background-color:white;
    	 					  border-radius: 3px;
      	 					  border: 1px solid #EAE8E8;
      	 					  padding: 10px;
      	 					  margin-left: 50px;
      	 					  margin-top: 30px;
      	 					  margin-bottom: 30px;">
      	 					  
					<b style="display: flex;
   				              justify-content: center;
				              align-items: center;">
				              
				       ${placeDTO.placeName}</b>
					<!-- place 리뷰 작성하는 부분 -->
					<div class="starsscore${placeSt.index + 1}" style = "display: flex;
											   				             justify-content: center;
															             align-items: center;">	
					
			      	  	<input type="radio" id="stars${placeSt.index + 1}5" name = "placeScore${placeSt.index + 1}" value="5" />
  			            <label for ="stars${placeSt.index + 1}5" title = "5" >★</label>
						<input type="radio" id="stars${placeSt.index + 1}4" name = "placeScore${placeSt.index + 1}" value="4" />
	        		    <label for ="stars${placeSt.index + 1}4" title = "4" >★</label>						
						<input type="radio" id="stars${placeSt.index + 1}3" name = "placeScore${placeSt.index + 1}" value="3" />
	        		    <label for ="stars${placeSt.index + 1}3" title = "3">★</label>								
						<input type="radio" id="stars${placeSt.index + 1}2" name = "placeScore${placeSt.index + 1}" value="2" />
	        		    <label for ="stars${placeSt.index + 1}2" title = "2" >★</label>								
						<input type="radio" id="stars${placeSt.index + 1}1" name = "placeScore${placeSt.index + 1}" value="1" />
	        		    <label for ="stars${placeSt.index + 1}1" title = "1" >★</label>		
	        		    						
						<input type="hidden" name="place${placeSt.index + 1}" id="place${placeSt.index + 1}" value = "${placeDTO.placeId}">
	      	  		</div>
					
				</div>

			</c:forEach>
		</div>
		
	<!-- placeReview 박스 끝-->
	
	<!-- CourseReview 박스 (리뷰작성 칸과 submit버튼 영역-->	
		<div class = "CourseReview" style = "display: flex;
											 flex-direction: column;
											 justify-content: center;
											 align-items: center;
											 margin-left: calc(5vw + 200px);
											 margin-right: 5vw;">
			<!-- CourseReview score -->
    	    <div class="courseStarsscore">
					<input type="radio" id="courseStars5" name="courseScore" value="5" />
		            <label for ="courseStars5" title = "5">★</label>
		            <input type="radio" id="courseStars4" name="courseScore" value="4"/>
		            <label for ="courseStars4" title = "4" >★</label>
		            <input type="radio" id="courseStars3" name="courseScore" value="3" />
		            <label for ="courseStars3" title = "3" >★</label>
		            <input type="radio" id="courseStars2" name="courseScore" value="2" />
		            <label for ="courseStars2" title = "2" >★</label>
		            <input type="radio" id="courseStars1" name="courseScore" value="1" />
		            <label for ="courseStars1" title = "1" >★</label>
           	</div>	
           	<br> 
			<!-- courseReview 작성 칸 -->		  
			<textarea rows="15" cols="70" name= "content" class = "CourseReview" maxlength="400"></textarea>			
			<input type="hidden" name="userId" id ="userId" value="${user.userId}">
			<input type="hidden" name="courseId" id = "courseId" value="${courseId}">
			
		    <div>
		    <br>
		    	<button type = "submit" value ="등록" class = "insert-button"> 리뷰 등록 </button>
		    </div>
		</div>
	<!-- CourseReview 박스 끝-->		
	
	</form>  	 	
  	<!-- 사이드바 제외 메인페이지 꿑-->  	
  </div>
  
  	<script type="text/javascript">
		var submitButtonClicked = false;
		
		function submitForm() {
		    if (submitButtonClicked) {
		        return false; // 이미 중복 클릭된 경우 중단
		    }
		    
		    submitButtonClicked = true; // 버튼 클릭 상태로 설정
		    var form = document.getElementById("review");
		    
		    form.submit(); // 폼 제출
		}
		
	</script>	
  
  
</body>
</html>