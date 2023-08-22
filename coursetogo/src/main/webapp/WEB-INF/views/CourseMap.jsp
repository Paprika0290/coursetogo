<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spring.coursetogo.dto.PlaceDTO" %>
<%@ page import="com.spring.coursetogo.dto.CourseReviewDTO" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="../css/sidebar2.css">
<link rel="stylesheet" href="../css/infowindow.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />

 <style>
#map{
right:200px;


width:100%;}
 .header{
 height:50px;}
footer{
 height: 10rem; /* footer 높이 */
 text-align: center;
 margin: 2em auto;
 padding:2em;
 background-color:#E5F2F1;
}
body {

   height: 100%;
   margin: 0;
   padding: 0;
   
   

}
    .search{
      display: flex;
      justify-content: center;
      align-items: center;
      
      border: 1px solid black;
    }
    .test {
   
   padding: 5px;
   width: 80%;
   height: 800px;
   background-color: #fa8;
   border: 1px solid #000;

background-clip: content-box;

}
 .middle{
    
 }
.contain{
 width: 100px;
 
 }
.courseName{
  	 display: block;
    text-decoration: none;
    color: #1e90ff;
    font-weight: bold;
    padding: 10px;
    border-radius: 10px;
    text-align: center;
    background-color: #fff;
    width: 170px;
    margin:auto;
	}
 
.CourseId{
  	 display: block;
    text-decoration: none;
    color: #1e90ff;
    font-weight: bold;
    padding: 10px;
    border-radius: 10px;
    text-align: center;
    background-color: #fff;
    width: 170px;
    margin:auto;
	}
 
.score{
  	  display: block;
    text-decoration: none;
    color: #1e90ff;
    font-weight: bold;
    padding: 10px;
    border-radius: 10px;
    text-align: center;
    background-color: #fff;
    width: 170px;
    margin:auto;
	}
    .disabled {
        pointer-events: none; /* 클릭 이벤트 비활성화 */
        opacity: 0.5; /* 반투명 처리 */
        cursor: not-allowed; /* 금지 커서 아이콘 */
    }
   
}
  </style>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eeovn23rmv&submodules=geocoder&callback=init"></script>
   <!-- <script  src="http://code.jquery.com/jquery-latest.min.js"></script> -->
   <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
 <div class="sidebar">
            <%@ include file="sidebar.jsp" %>
        </div>
</head>

<header class="header">

  <title>List View Example</title>
   
</header>
<body>


      
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<div  class='middle'>



<div style="width:100%;left:200px">
  <div class="test" id="map" style=""></div>
  
   <title>슬라이드 메뉴</title>
    <style>
        /* 슬라이드 메뉴 스타일 */
       
        
        /* 슬라이드 메뉴 버튼 스타일 */
       
    </style>
    <script>
    var submitButtonClicked = false;
   
    function submitForm() {
        if (submitButtonClicked) {
            return false; // 이미 중복 클릭된 경우 중단
        }
        submitButtonClicked = true; // 버튼 클릭 상태로 설정
        var form = document.getElementById("saveMark");
        
        form.submit(); // 폼 제출
        
    }
        window.onload = function() {
            var sliderMenu = document.getElementById("slider-menu");
            var sliderButton = document.getElementById("slider-button");
            
            // 슬라이드 메뉴를 토글하는 함수
            function toggleSliderMenu() {
                if (sliderMenu.style.right === "200px") {
                    sliderMenu.style.right = "0";
                    sliderMenu.style.display = "none";
                   
                } else {
                    sliderMenu.style.right = "200px";
                    sliderMenu.style.display = "block";
                }
            }
            
            // 슬라이드 메뉴 버튼 클릭 이벤트 핸들러
            sliderButton.onclick = function() {
                toggleSliderMenu();
            };
        };
        
    
    </script>
		<div id="slider-menu" class="slider-menu">
		  <!-- 슬라이드 메뉴 내용 -->
		  <div class="slidetitle">
		    <h3>작성된 리뷰</h3>
		  </div>
		  <%
		  List<CourseReview> reviewList = (List<CourseReview>) request.getAttribute("CourseReview");
		  for (int i = 0; i < reviewList.size(); i++) {
		    %>
		    <div class="slidecontents">
		      <div>
		        <%= reviewList.get(i).getContent() %>
		        <div class="starsscore">
		          <% int courseScore = reviewList.get(i).getCourseScore();
		          for (int j = 5; j >= 1; j--) { %>
		            <i class="fas fa-star <%= j <= courseScore ? "active" : "" %>"></i>
		          <% } %>
		        </div>
		      </div>
		    </div>
		  <% } %>
		</div>
    

  <span class="contain">
 <div class="sidebar2">
          <div class="sidebar2logo">Track</div>
          <ul>
             <!-- 전체적인 링크 수정해야함(onclick) -->
             <li></li>
             <li><input type="button" class="courseName" value="${Course.courseName}"></li>
          
                <li><input type="button" class="CourseId" value="CourseId : ${Course.courseId}"></li>
                <li><input type="button" class="score" value="score :${Course.courseAvgScore}" ></li>
<hr style="border: 1px dashed #ffffff"></hr>
    <%
    List<PlaceDTO> placeList = (List<PlaceDTO>) request.getAttribute("PlaceList");
    double latitudeSum = 0.0;
    double longitudeSum =0.0;
    double minlat = 999;
    double minlong = 999;
    double maxlat =0;
    double maxlong = 0;
      for(int i = 0 ; i < placeList.size(); i++){
         %>

           <li>
		  	<input type="button" class="course" style="font-size: 12px; font-weight: 900; background-color: #ffffff; color:#00008b; border: 3px solid #00008b;" value="<%= placeList.get(i).getPlaceName() %>"
		    onclick="window.open('https://search.naver.com/search.naver?query=' + encodeURIComponent('<%= placeList.get(i).getPlaceName() %>'), '_blank')"
		    onmouseover="this.style.backgroundColor='rgba( 135, 206, 235, 0.7)';"
		    onmouseout="this.style.backgroundColor='#ffffff';">
		  </li>
        
           <%
           
           
          if(minlat > placeList.get(i).getLatitude()) minlat = placeList.get(i).getLatitude();
        if(minlong > placeList.get(i).getLongitude()) minlong = placeList.get(i).getLongitude();
      if(maxlat < placeList.get(i).getLatitude()) maxlat = placeList.get(i).getLatitude();
    if(maxlong < placeList.get(i).getLongitude()) maxlong = placeList.get(i).getLongitude();
        latitudeSum += placeList.get(i).getLatitude();
        longitudeSum += placeList.get(i).getLongitude();
          if(i != placeList.size()-1){
          %>
          <div style="text-align: center; width: 200px; height: 50px;">
              <img style="width: 50px; height: 50px;" src="<%= request.getContextPath() %>/images/arrow.png" alt="화살표">
          </div>
            <%
          }
      

    }double averageLatitude = latitudeSum  / placeList.size();
    double averageLongitude =longitudeSum  / placeList.size();
    
%>

<script>

function openNaverSearch(placeName) {
	  var encodedPlaceName = encodeURIComponent(placeName);
	  var searchURL = 'https://search.naver.com/search.naver?query=' + encodedPlaceName;
	  window.open(searchURL, '_blank');
	}

	function handleButtonMouseOver(button) {
	  button.style.backgroundColor = '#ccc';
	}

	function handleButtonMouseOut(button) {
	  button.style.backgroundColor = '#ffffff';
	}

function moveMap(minlat, minlong, maxlat, maxlong) {
   
   var middle = new naver.maps.LatLngBounds(
            new naver.maps.LatLng(minlat, minlong),
            new naver.maps.LatLng(maxlat, maxlong));
    map.panToBounds(middle);
}

</script>
            <hr style="border: 1px dashed #ffffff"></hr>
           
               <li><input id="slider-button" type="button" class="create-course" value="작성된 리뷰보기" ></li>
              
              
       
        
              <div style="" class="">
           <form id="review" action="/setReview" method="GET" accept-charset="UTF-8">
      
   

<c:if test="${not empty sessionScope.user.userId}">
    <li><input id="slider-button" type="button" class="create-course" value="리뷰 작성 버튼"></li>
</c:if>
<c:if test="${empty sessionScope.user.userId}">
    <li disabled><input id="slider-button" type="button" class="create-course submit disabled"  value="로그인 후 리뷰 작성하기" disabled></li>
</c:if>
      <input type="hidden" id="placeId1" name="placeId1" value=>
      <input type="hidden" id="placeId2" name="placeId2" value=>
      <input type="hidden" id="placeId3" name="placeId3" value=>
      <input type="hidden" id="placeId4" name="placeId4" value=>
      <input type="hidden" id="placeId5" name="placeId5" value=>
      <input type="hidden" id="courseId" name="courseId" value=>
      <input id="courseNumber" type="hidden" name="courseNumber">
   
     
    </form>
             </div>
          </ul>
          
      </div>
   
  </span>
     
          
     

</div>

</body>

<!-- footer -->

<footer style="margin: 10px auto; height: auto;">

<h2 style="margin-left:220px; margin-right:220px;">코스 소개글 : ${Course.courseContent}</h2>
</footer>
             
      
<script>
//polyline
let markers = new Array(); //마커 정보를 담는 배열
   let infoWindows = new Array(); // 정보창을 담는 배열  
   var map;
 var submitButtonClicked = false;
   
       function submitForm() {
           if (submitButtonClicked) {
               return false; // 이미 중복 클릭된 경우 중단
           }
           submitButtonClicked = true; // 버튼 클릭 상태로 설정
           var form = document.getElementById("review");
           
           form.submit(); // 폼 제출
           
       }
    document.getElementById("review").onclick = function() {
           // 추가 동작을 수행합니다. 
           event.preventDefault();
           var urlParams = new URLSearchParams(window.location.search);

           document.getElementById("courseId").value = urlParams.get('courseId');
          document.getElementById("courseNumber").value = urlParams.get('courseNumber');
           // placeId에 저장된 값을 input 박스안에 각각 집어넣어졌는지 확인.
      
           document.getElementById("placeId1").value = urlParams.get('placeId1');
           document.getElementById("placeId2").value  =urlParams.get('placeId2');
           document.getElementById("placeId3").value =urlParams.get('placeId3');
           document.getElementById("placeId4").value = urlParams.get('placeId4');
           document.getElementById("placeId5").value = urlParams.get('placeId5');
         
           console.log("전송 버튼이 눌렸습니다!");
         
           
        
     
         
   
    
           var isLoggedIn = ${not empty sessionScope.user.userId};
           if (isLoggedIn) {
          
           
           submitForm(); // 폼 제출
           }
       };
init();

//지도를 그려주는 함수 실행
function init(){
   

   
   
   //검색정보를 테이블로 작성해주고, 지도에 마커를 찍어준다.
   
   var polylinePath = new Array();
    
    

   map = new naver.maps.Map('map', {
       center: new naver.maps.LatLng(37.3595704, 127.105399),
       zoom: 10
   });
 
  
    
 

    <c:forEach var="place" items="${PlaceList}">

    var counter = 0;
   
   

    
 //   polylinePath.push(new naver.maps.LatLng( ${place.latitude}, ${place.longitude}));
       

    var marker = new naver.maps.Marker({
    
        position: new naver.maps.LatLng(${place.latitude}, ${place.longitude}),
       
        map: map
    });
    
    markers.push(marker);
    
    var contentString = [
    	  '<div class="naver-infoWindow">',
    	  '  <div class="naver-infoWindow-content">',
    	  '    <p>${place.placeName}</p>',
    	  '    ${place.address}',
    	  '  </div>',
    	  '  <div class="naver-infoWindow-anchor"></div>',
    	  '</div>'
    	].join('');
    
    var infoWindow = new naver.maps.InfoWindow({
        content: contentString,
        Width: 140,
        backgroundColor: "rgba( 135, 206, 235)",
        borderColor: "#c4c4c4",
        borderWidth: 2,
        borderRadius: "5px",
        anchorSize: new naver.maps.Size(30, 30),
        anchorSkew: true,
        anchorColor: "rgba( 135, 206, 235)",
        pixelOffset: new naver.maps.Point(20, -20)
        
			

    });

    infoWindows.push(infoWindow); // 생성한 정보창을 배열에 담는다.
    
    
  
    </c:forEach>
    for (var i=0, ii=markers.length; i<ii; i++) {
        naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
    }
   
    var polyline = new naver.maps.Polyline({
        path: polylinePath,      //선 위치 변수배열
        strokeColor: '#FF0000', //선 색 빨강 #빨강,초록,파랑
        strokeOpacity: 0.8, //선 투명도 0 ~ 1
        strokeWeight: 6,   //선 두께
        map: map           //오버레이할 지도
    });


    //---------------direction
    
    var polylinePath = new Array();
    

    <c:forEach var="direction" items="${DirectionList}">
    polylinePath.push(new naver.maps.LatLng( ${direction.latitude}, ${direction.longitude}));
   
    </c:forEach>
 //   console.log(polylinePath);
    


     //    var map = new naver.maps.Map('map', {
        //     center: new naver.maps.LatLng(37.5112, 127.0981), // 잠실 롯데월드를 중심으로 하는 지도
          //   zoom: 15
        // });
       
         var polyline = new naver.maps.Polyline({
             path: polylinePath,      //선 위치 변수배열
             strokeColor: 'rgba( 135, 206, 235)', //선 색 빨강 #빨강,초록,파랑
             strokeOpacity: 0.8, //선 투명도 0 ~ 1
             strokeWeight: 6,   //선 두께
             map: map           //오버레이할 지도
         });
      
         
         var averageLatitude = <%= averageLatitude %>;
      // 이제 average 변수를 원하는 곳에 사용할 수 있습니다.
      var averageLongitude = <%= averageLongitude %>;
      var maxlat= <%= maxlat %>;
      var minlat= <%= minlat %>;
      var maxlong= <%= maxlong %>;
      var minlong= <%= minlong %>;
      /* console.log(minlat, minlong); */
      moveMap(minlat, minlong, maxlat, maxlong);      
         
    
 
}





function ClickMap(i) {
     return function () {
       var infoWindow = infoWindows[i];
       infoWindow.close()
     }
   }

function getClickHandler(seq) {
   
    return function(e) {  // 마커를 클릭하는 부분
        var marker = markers[seq]; // 클릭한 마커의 시퀀스로 찾는다.
        var infoWindow = infoWindows[seq]; // 클릭한 마커의 시퀀스로 찾는다

        if (infoWindow.getMap()) {
            infoWindow.close();
        } else {
           console.log("표시");
           
           
            infoWindow.open(map, marker); // 표출
         //   console.log(map, marker,infoWindow);
        }
   }
}

   
   
   
   
   
   
   
   

//지도를 그려주는 함수
function selectMapList() {
   
   var map = new naver.maps.Map('map', {
       center: new naver.maps.LatLng(37.3595704, 127.105399),
       zoom: 10
   });
}


// 지도를 이동하게 해주는 함수

function calculateDistance(lat1, lon1, lat2, lon2) {
     const earthRadius = 6371; // 지구 반지름 (단위: km)

     // 각도를 라디안으로 변환
     const lat1Rad = (lat1 * Math.PI) / 180;
     const lon1Rad = (lon1 * Math.PI) / 180;
     const lat2Rad = (lat2 * Math.PI) / 180;
     const lon2Rad = (lon2 * Math.PI) / 180;

     // 위도와 경도의 차이 계산
     const latDiff = lat2Rad - lat1Rad;
     const lonDiff = lon2Rad - lon1Rad;

     // Haversine 공식 적용
     const a =
       Math.sin(latDiff / 2) * Math.sin(latDiff / 2) +
       Math.cos(lat1Rad) * Math.cos(lat2Rad) * Math.sin(lonDiff / 2) * Math.sin(lonDiff / 2);
     const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
     const distance = earthRadius * c;

     return distance;
   }

</script>


</html>