<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.spring.coursetogo.dto.PlaceDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> 
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=61p0dd1v1a"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
    <meta charset="EUC-KR">
    <title>Marker Test</title>
    <link rel="stylesheet" type="text/css" href="css/Map.css">
    <link rel="stylesheet" href="css/sidebar.css">

    <style>

   .submit:hover {
        opacity: 1.0;
    }
  ul {
    list-style-type: none;
    padding: 0;
    margin: 0;
  }
  #locationContainer {
 	position: absolute;
	z-index: 5;
	text-align: center;
	margin-left: 230px;
	margin-top: 60px;
	font-weight: bold;

	width: 245px;
	
	color:#00008b;
	background-color: #6495ed;
	background-color: rgba( 135, 206, 235, 0.7);
	border-radius: 10px;
	font-weight: bold;
  /* Add any other styling you want for the location elements */
  transform: translateZ(200px); /* Adjust the value to control the forward positioning */
}
    .disabled {
        pointer-events: none; /* 클릭 이벤트 비활성화 */
        opacity: 0.5; /* 반투명 처리 */
        cursor: not-allowed; /* 금지 커서 아이콘 */
    }
    
	#on {
		background-color: #daeefe;
	}
</style>
</head>
<script>

window.onload = function() {
var queryString = window.location.search;
var urlParams = new URLSearchParams(queryString);
document.getElementById('areaName');


if (areaName === null) {
    // areaName이 null일 때 처리
    areaName = ""; // 원하는 기본값을 설정할 수 있습니다.
  }
 document.getElementById("area").innerHTML = areaName;

};


function openModal(locations, categories, isLocationModal) {
	  var popupWidth = 500;
	  var popupHeight = 500;
	  var screenWidth = window.screen.width;
	  var screenHeight = window.screen.height;
	  var top = (screenHeight - popupHeight) / 1.5 - (screenHeight * 0.3);
	  var left = (screenWidth - popupWidth) / 2;

	  var popup = window.open("", "_blank", "width=" + popupWidth + ",height=" + popupHeight + ",top=" + top + ",left=" + left);
	  var html = "<html><body><div align='center'><h1>";
	  html += isLocationModal ? "지역 선택" : "카테고리 선택";
	  html += "</h1>";
	  html += "<table style='border-collapse: collapse;'><tr>";

	  if (isLocationModal) {
	    for (var i = 0; i < locations.length; i++) {
	      var location = locations[i];
	      html += "<td style='border: 1px solid #000; padding: 5px;'><div onclick='selectLocation(\"" + location + "\")' style='cursor: pointer;'>" + location + "</div></td>";
	      if ((i + 1) % 4 === 0) {
	        html += "</tr><tr>";
	      }
	    }
	  } else {
	    for (var i = 0; i < categories.length; i++) {
	      var category = categories[i];
	      html += "<td style='border: 1px solid #000; padding: 5px;'><div onclick='selectCategory(\"" + category + "\")' style='cursor: pointer; '>" + category + "</div></td>";
	      if ((i + 1) % 3 === 0) {
	        html += "</tr><tr>";
	      }
	    }
	  }

	  html += "</tr></table></div></body></html>";
	  popup.document.write(html);

	  popup.selectLocation = function(location) {
	    document.getElementById("areaName").value = location;
	    popup.close();
	  }

	  popup.selectCategory = function(category) {
	    document.getElementById("categoryName").value = category;
	    popup.close();
	  }
	}
	
function openLocationModal() {
	  const locations = [
		  "홍대", "강남역", "이태원", "명동", "가로수길", "신림", "서래마을", "연남동", "신촌", "압구정",
		  "역삼", "잠실", "인사동", "광화문", "청담동", "성수동", "신당", "대학로", "신사", "종로3가",
		  "이촌", "서초", "광장시장", "신촌로터리", "잠실나루", "신논현", "강남구청", "압구정로데오",
		  "역삼역", "삼성동", "건대입구", "선릉", "잠실새내", "잠실역", "한남동", "고속터미널", "여의도",
		  "대치동", "천호", "성수", "신사동", "동대문", "사당", "고려대", "동대문역사문화공원",
		  "역삼동", "상수", "대한민국 역사박물관", "명동역", "이태원로데오", "고덕", "을지로", "명동거리",
		  "신당동", "잠실새내역", "선릉역", "서울대입구", "강동", "노량진", "사당역", "강남역점",
		  "종로5가", "대명동", "삼성역", "홍대입구", "경복궁역", "신대방", "강동구청", "이태원역",
		  "교대", "잠실종합운동장", "남산", "서울역", "사당로", "잠실경기장", "역삼동역", "명동시장",
		  "서울시청", "서울중앙시장"
	  ];
	  openModal(locations, null, true);
	}

	// 업종명 모달 열기
	function openCategoryModal() {
	  const categories = [
		  "카페", "영화관", "음식점", "공연장", "공원", "등산로"
	  ];
	  openModal(null, categories, false);
	}


  function searchPlaces() {
    // 검색 기능을 구현하는 함수
    const areaName = document.getElementById("areaName").value;
    const categoryName = document.getElementById("categoryName").value;
    console.log(areaName);
    console.log(categoryName);
    // areaName이 비어있을 경우 검색 요청을 전송하지 않음
    if (areaName.trim() === "") {
      alert("지역명을 입력해주세요.");
      return;
    }

    // AJAX 요청을 생성합니다.
    const xhr = new XMLHttpRequest();
    xhr.open("GET", "/jSearchAC?areaName=" + areaName + "&categoryName=" + categoryName, true);

    // 서버 응답 처리
    xhr.onreadystatechange = function () {
      if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200) {
          // 서버로부터 받은 데이터를 처리하는 로직을 작성합니다.
          const response = JSON.parse(xhr.responseText);
          console.log(response);
          displayResults(response);
        } else {
          console.error("Error occurred while fetching data.");
        }
      }
    };

    // AJAX 요청을 보냅니다.
    xhr.send();
  }
	
	
	
	
function displayResults(data) {

const placeList = document.getElementById("placeList");
placeList.innerHTML = ""; // 이전 검색 결과를 지웁니다.

if (data && data.length > 0) {
  // 받아온 데이터를 이용하여 결과를 생성하고 표시합니다.
  for (const place of data) {
    const placeDiv = document.createElement("div");
    placeDiv.style.display = "flex";
    placeDiv.style.justifyContent = "center";
    placeDiv.style.alignItems = "center";
    placeDiv.style.width = "200px";
    placeDiv.style.height = "60px";
    placeDiv.classList.add("box", "in");

    const placeContentDiv = document.createElement("div");
    placeContentDiv.onclick = function() {
      placeClicked(place.placeId, place.latitude, place.longitude, place.placeName);
    };
    placeContentDiv.textContent = place.placeName;
    
    placeDiv.appendChild(placeContentDiv);
   placeList.appendChild(placeDiv);
  }
} else {
  // 검색 결과가 없는 경우 메시지를 표시합니다.
  const noResultsDiv = document.createElement("div");
  noResultsDiv.textContent = "검색 결과가 없습니다.";
  placeList.appendChild(noResultsDiv);
}
}
</script>
<body>
	<!-- 사이드바 -->
	<form action="/naverMap" method="GET" name="sidebarForm" id="sidebarForm">
		<div class="sidebar">
		    <div class="logo">Course To Go</div>
		    <ul>
		    	<li><input type="button" class="home" value="홈" onclick="location.href='/home'"></li>
	       		<li><input type="button" class="course" value="코스" onclick="location.href='/courseListWithPagination'"></li>
	    		<li><input type="button" class="create-course" value="코스 제작"  id="on" onclick="location.href='/naverMap'"></li>
    			<c:if test="${empty sessionScope.user.userId}">
	    			<li><input type="button" class="mypage" value="마이페이지" onclick="notLogin()"></li>
	    		</c:if>
		    	<c:if test="${not empty sessionScope.user.userId}">
		    		<li><input type="button" class="mypage" value="마이페이지" onclick="location.href='/userContents'"></li>
		    		<li class="profile"><img src="${sessionScope.user.userPhoto}" alt="프로필 사진"></li>
			        <li class="name">${sessionScope.user.userNickname} 님</li>
			        <li><input type="button" class="logout-btn" value="로그아웃" onclick="location.href='/logout'"></li>
			        <li><input type="button" class="edit-profile-btn" value="개인정보 수정" onclick="location.href='/myPageInformModify'"></li>
		    	</c:if>
		    </ul>
		</div>
	</form>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script type="text/javascript" src="/js/bootstrap.js"></script>
<link rel="stylesheet" href="Map.css">

<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<div class="middle">
  <div class="left">
    <form id="searchForm" method="get" accept-charset="utf-8">
      <input class="left input" type="text" id="areaName" name="areaName" placeholder="지역명 ex)홍대" onclick="openLocationModal()">
      <input class="left input" type="text" id="categoryName" name="categoryName" placeholder="업종명 ex)음식점" onclick="openCategoryModal()">
      <button class="left button" type="button" onclick="searchPlaces()">검색</button>
    </form>
  </div>
</div>
  
   <div class="sidebar2" >
    <form id="saveMark" action="/saveMarker" method="POST" accept-charset="UTF-8">
     <input type="hidden" id="placeId1" name="placeId1" value=>
     <input type="hidden" id="placeId2" name="placeId2" value=>
     <input type="hidden" id="placeId3" name="placeId3" value=>
     <input type="hidden" id="placeId4" name="placeId4" value=>
     <input type="hidden" id="placeId5" name="placeId5" value=>
     <textarea class="userGuide" readonly>
      &#8595;코스제작 가이드 &#8595;
      
&#10112;좌측 상단 검색창을 통해 검색을 해주세요.
예시 : 지역명 홍대 
	    업종명 음식점
	    
&#10113;나온 검색결과를 클릭해서 지도에 마커를 추가해서 장소를 확인하세요.(최대 5개)

&#10114;선택한 장소를 확인 후 우측 사이드바에서 코스이름 코스에 대한 설명을 작성해주세요.

&#10115;작성이 끝나면 코스만들기를 눌러서 자신만의 코스를 만들어주세요.

⚠️코스 제작은 로그인을 하셔야 이용이 가능합니다.

    </textarea>
    <input class="Coursename" id="courseName" type="text" name="courseName" value="코스 이름을 입력해주세요." onfocus="clearInputValue(this)">
	<input id="courseNumber" type="hidden" name="courseNumber">
	<textarea id="courseContent" class="courseContent" name="courseContent" required onfocus="clearTextareaValue(this)" maxlength="400">코스에 대한 설명을 작성해주세요.</textarea>
 <c:if test="${not empty sessionScope.user.userId}">
    <button class="submit" type="submit">코스 제작하기!</button>
</c:if>
<c:if test="${empty sessionScope.user.userId}">
    <button class="submit disabled" disabled>로그인 후 이용해주세요</button>
</c:if>
    </form>
  </div> 
</div>

<script>
	function clearInputValue(input) {
	  if (input.value === input.defaultValue) {
	    input.value = '';
	  } 
	  
	}
	
	function clearTextareaValue(textarea) {
	  if (textarea.value === textarea.defaultValue) {
	    textarea.value = '';
	  }
	}
</script>

<!--  전송 버튼에 대한 스크립트 -->
	<script>
		// 버튼 중복 클릭시 한번만 전송
	    var submitButtonClicked = false;
	
	    function submitForm() {
	        if (submitButtonClicked) {
	            return false; // 이미 중복 클릭된 경우 중단
	        }
	        submitButtonClicked = true; // 버튼 클릭 상태로 설정
	        var form = document.getElementById("saveMark");
	        
	        form.submit(); // 폼 제출
	        
	    }
	    
	    document.getElementById("saveMark").addEventListener("submit", function(event) {
	        // 추가 동작을 수행합니다. 
	        // placeId에 저장된 값을 input 박스안에 각각 집어넣어졌는지 확인.
			  document.getElementById("placeId1").value = placeId.length >=1 ?placeId[0]:null ;
			  document.getElementById("placeId2").value = placeId.length >=2 ? placeId[1] : null;
			  document.getElementById("placeId3").value = placeId.length >=3  ? placeId[2] : null;
			  document.getElementById("placeId4").value = placeId.length >=4  ? placeId[3] : null;
			  document.getElementById("placeId5").value = placeId.length >=5  ? placeId[4] : null;
	        event.preventDefault();
	        console.log("전송 버튼이 눌렸습니다!");
	        console.log(placeId);
	        
	        var courseNameInput = document.getElementById("courseName");
	        
	        var courseNameValue = courseNameInput.value.trim();
	        if (courseNameValue === "") {
	            alert("이름을 입력해주세요.");
	            submitButtonClicked = false; // 버튼 클릭 상태 초기화
	            
	            return;
	        }
	        var courseContentField = document.getElementById("courseContent");
	        var courseContentValue = courseContentField.value;
	        if (courseContentValue === "") {
	            alert("코스내용을 입력해주세요.");
	            submitButtonClicked = false; // 버튼 클릭 상태 초기화
	            return;
	        }
	        if (placeName.length === 0) {
	            alert("최소 1개 이상의 장소를 선택해주세요.");
	            submitButtonClicked = false; // 버튼 클릭 상태 초기화
	            return;
	        }
	 
	        var inputElement = document.getElementById("courseNumber");
	        inputElement.value = placeName.length;
	       
	        
	        submitForm(); // 폼 제출
	       
	    });
	</script>
	
	</div>

<div class="searchResults">
   
    <div>
        <ul id="placeList" style="display: flex; flex-direction: column; align-items: center;">
            <!-- 여기에 장소 목록이 동적으로 생성될 것입니다. -->
        </ul>
    </div>
</div>

<script>
function removeAllChildElements() {
    const locationContainer = document.getElementById("locationContainer");
    while (locationContainer.firstChild) {
        locationContainer.removeChild(locationContainer.firstChild);
    }

    // "populated" 속성 초기화
    locationContainer.dataset.populated = false;
    

}


	 
//    document.getElementById("searchForm").addEventListener("submit", function(event) {
        // 추가 동작을 수행합니다.
  //      event.preventDefault(); 
    
    //    var elements = document.getElementsByClassName("well well-sm");
      //  while (elements.length > 0) {
        //    elements[0].parentNode.removeChild(elements[0]);
         // }
        //this.submit();
      
        // 폼을 서버로 제출합니다.
      

        
       // 기본 동작을 막기 위해 이벤트의 기본 동작을 취소합니다.
   // });
       
</script>
	<div  id="locationContainer"></div>


	
	<div class="markerInputs" onclick="deleteMarker(event)">
	  <ul id="markerInputs" class="horizontal-list"></ul>
	</div>
	
	<div class="markerList" id="markerList" type="hidden">
	<ul type="hidden"></ul>
	</div>
	
	
	
   	<div class="displayMap">
    <div id="map" class="map">
 

<script>
  map = new naver.maps.Map('map', {
	  center: new naver.maps.LatLng(37.5714, 126.9768),
	  zoom: 16,
	  minZoom: 12,
	  maxZoom: 16
  });

  var MAX_MARKER_COUNT = 5; // 최대 마커 개수
  var selectedMarker = null; // 선택된 마커
  var markerList = [];
  var myList = [];
  var placeName = [];
  var placeId = [];

  if (myList === null) {
  } else if (myList.length >= MAX_MARKER_COUNT) {
    myList = myList.slice(0, MAX_MARKER_COUNT);
  }

  for (var i = 0; i < myList.length; i++) {
    var lat = myList[i][0];
    var lng = myList[i][1];
    var name = myList[i][2];

    var marker = new naver.maps.Marker({
      position: new naver.maps.LatLng(lat, lng),
      map: map,
      draggable: false,
      name: name,
      id: i.toString()
    });

    markerList.push(marker);

    addMarkerEventListeners(marker);
  }

  function updateMarkers() {
    updateMarkerInputs();
    updateMarkerList();
  }

  function updateMarkerInputs() {
    var markerInputs = '';
    for (var i = 0; i < placeName.length; i++) {
      var name = placeName[i];
      markerInputs += '<li>' + (i + 1) + ' ' + name + '</li>';
    }
    document.getElementById('markerInputs').innerHTML = markerInputs;
  }

  function updateMarkerList() {
    var markerListHTML = '';
    for (var i = 0; i < markerList.length; i++) {
      var marker = markerList[i];
      var markerName = placeName[i];
      if (markerName) {
        markerListHTML += '<li>' + (i + 1) + ' ' + markerName + '</li>';
      }
    }
    document.getElementById('markerList').innerHTML = markerListHTML;
  }

  var selectedMarker = null;

  function addMarkerEventListeners(marker) {
    naver.maps.Event.addListener(marker, 'click', function () {
      var index = markerList.indexOf(marker);
      if (index !== -1) {
        marker.setMap(null);
        markerList.splice(index, 1);
        placeName.splice(index, 1);
        placeId.splice(index, 1);
        myList.splice(index, 1);
        selectedMarker = null;
        updateMarkers();
        updateMarkerOrder();
        console.log("Marker removed");
        console.log("markerList:", markerList);
        console.log("placeName:", placeName);
        console.log("placeId:", placeId);
        console.log("myList:", myList);
      }
    });
  

    naver.maps.Event.addListener(marker, 'dragend', function () {
      updateMarkerInputs();
    });
  }

  function deleteMarker(event) {
    var clickedIndex = Array.from(event.target.parentNode.children).indexOf(event.target);
    if (clickedIndex !== -1) {
      var markerToRemove = markerList[clickedIndex];
      if (markerToRemove) {
        markerToRemove.setMap(null);
        markerList.splice(clickedIndex, 1);
        placeName.splice(clickedIndex, 1);
        placeId.splice(clickedIndex, 1);
        myList.splice(clickedIndex, 1);
        updateMarkers();
        updateMarkerOrder();
        console.log("Marker removed");
        console.log("markerList:", markerList);
        console.log("placeName:", placeName);
        console.log("placeId:", placeId);
        console.log("myList:", myList);
      }
    }
  }

  function placeClicked(id, lat, lng, name, marker) {
    if (myList === null) {
      myList = [];
    } else if (myList.length >= MAX_MARKER_COUNT) {
      console.log(myList);
      return; // 마커 개수가 제한에 도달한 경우 마커 생성하지 않음
    }

    for (var i = 0; i < myList.length; i++) {
      // 마커가 이미 찍힌지 비교
      if (name === placeName[i]) {
        return;
      }
    }

    console.log(myList);
    var newPlace = [name, lat, lng];
    placeName.push(name);
    myList.push(newPlace);

    var markerHTML = [
      '<div class="cs_mapbridge">',
      '  <div class="map_group _map_group crs">',
      '    <div class="map_marker _marker num1 num1_big">',
      '      <span class="ico _icon">' + getCircleNumber(placeName.indexOf(name)) + name + '</span>',
      '      <span class="shd"></span>',
      '    </div>',
      '  </div>',
      '</div>'
    ].join('');

    function getCircleNumber(index) {
      var baseCharCode = 9312; // '①'의 유니코드 값
      return String.fromCharCode(baseCharCode + index);
    }

    var marker = new naver.maps.Marker({
      position: new naver.maps.LatLng(lat, lng),
      map: map,
      icon: {
        content: markerHTML,
        size: new naver.maps.Size(38, 58),
        anchor: new naver.maps.Point(19, 58),
      },
      draggable: false,
    });

    marker.index = markerList.length;
    markerList.push(marker);
    updateMarkers();
    updateMarkerOrder();
    addMarkerEventListeners(marker);

    placeId.push(id);
    map.setCenter(marker.getPosition());
  }

  function updateMarkerOrder() {
    var baseCharCode = 9312; // '①'의 유니코드 값
    for (var i = 0; i < markerList.length; i++) {
      var marker = markerList[i];
      if (marker) {
        var markerName = placeName[i];
        var circleNumber = String.fromCharCode(baseCharCode + i);
        var markerHTML = [
          '<div class="cs_mapbridge">',
          '  <div class="map_group _map_group crs">',
          '    <div class="map_marker _marker num1 num1_big">',
          '      <span class="ico _icon">' + circleNumber + markerName + '</span>',
          '      <span class="shd"></span>',
          '    </div>',
          '  </div>',
          '</div>'
        ].join('');
        marker.setIcon({
          content: markerHTML,
          size: new naver.maps.Size(38, 58),
          anchor: new naver.maps.Point(19, 58)
        });
      }
    }
  }

  updateMarkers();
  
	function notLogin() {
		alert("로그인 시 이용가능한 서비스입니다.");
	}
</script>

	</div>   
</div>
</body>
</html>
