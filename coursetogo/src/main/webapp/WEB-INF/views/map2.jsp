<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
 <style>
    .search{
      display: flex;
      justify-content: center;
      align-items: center;
      
      border: 1px solid black;
    }
  </style>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eeovn23rmv&submodules=geocoder&callback=selectMapList"></script>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
</head>

<body>
 
<div class="search">
	<input id="address" type="text" placeholder="검색할 주소">
	<input id="submit" type="button" value="주소검색">
</div>
<div id="map" style="width:100%;height:1000px;"></div>
<div>
	<table>
		<thead>
			<tr>
				<th>주소</th>
				<th>위도</th>
				<th>경도</th>
			</tr>	
		</thead>
		<tbody id="mapList"></tbody>
	</table>
</div>
</body>


<script>
//polyline



//지도를 그려주는 함수 실행


//검색한 주소의 정보를 insertAddress 함수로 넘겨준다.
function searchAddressToCoordinate(address) {
    naver.maps.Service.geocode({
        query: address
    }, function(status, response) {
        if (status === naver.maps.Service.Status.ERROR) {
            return alert('Something Wrong!');
        }
        if (response.v2.meta.totalCount === 0) {
            return alert('올바른 주소를 입력해주세요.');
        }
        var htmlAddresses = [],
            item = response.v2.addresses[0],
            point = new naver.maps.Point(item.x, item.y);
        if (item.roadAddress) {
            htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
        }
        if (item.jibunAddress) {
            htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
        }
        if (item.englishAddress) {
            htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
        }

        insertAddress(item.roadAddress, item.x, item.y);
        
    });
}

// 주소 검색의 이벤트
$('#address').on('keydown', function(e) {
    var keyCode = e.which;
    if (keyCode === 13) { // Enter Key
        searchAddressToCoordinate($('#address').val());
    }
});
$('#submit').on('click', function(e) {
    e.preventDefault();
    searchAddressToCoordinate($('#address').val());
});

var map;
let markers = new Array(); //마커 정보를 담는 배열
let infoWindows = new Array(); // 정보창을 담는 배열  
//검색정보를 테이블로 작성해주고, 지도에 마커를 찍어준다.
function insertAddress(address, latitude, longitude) {
	var mapList = "";
	mapList += "<tr>"
	mapList += "	<td>" + address + "</td>"
	mapList += "	<td>" + latitude + "</td>"
	mapList += "	<td>" + longitude + "</td>"
	mapList += "</tr>"

	$('#mapList').append(mapList);	

	map = new naver.maps.Map('map', {
	    center: new naver.maps.LatLng(longitude, latitude),
	    zoom: 14
	});
    var marker = new naver.maps.Marker({
        map: map,
        position: new naver.maps.LatLng(longitude, latitude),
    });

    var polylinePath = new Array();
    
 

    <c:forEach var="place" items="${PlaceList}">
    
    var counter = 0;
    var dis = calculateDistance(longitude, latitude, ${place.latitude}, ${place.longitude});
   
    if(dis >0){
    
    polylinePath.push(new naver.maps.LatLng( ${place.latitude}, ${place.longitude}));
    	

    var marker = new naver.maps.Marker({
    
        position: new naver.maps.LatLng(${place.latitude}, ${place.longitude}),
    	
        map: map
    });
    
    markers.push(marker);
   /*  console.log(dis); // 결과 출력 (단위: km) */
	var contentString = [
	    '<div class="iw_inner">', '<p>place Name: ${place.placeName}</p>',
	   ${place.latitude}, ${place.longitude},
	    '</div>'
	].join('');	
    
    var infoWindow = new naver.maps.InfoWindow({

        content: contentString,

        maxWidth: 140,
        backgroundColor: "#eee",
        borderColor: "#2db400",
        borderWidth: 5,
        anchorSize: new naver.maps.Size(30, 30),
        anchorSkew: true,
        anchorColor: "#eee",

        pixelOffset: new naver.maps.Point(20, -20)
    });

    infoWindows.push(infoWindow); // 생성한 정보창을 배열에 담는다.
    
    }
  
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
         /*    console.log(map, marker,infoWindow); */
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
function moveMap(len, lat) {
	var mapOptions = {
		    center: new naver.maps.LatLng(len, lat),
		    zoom: 15,
		    mapTypeControl: true
		};
    var map = new naver.maps.Map('map', mapOptions);
    var marker = new naver.maps.Marker({
        position: new naver.maps.LatLng(len, lat),
        map: map
    });
}
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
<div class="sidebar">
            <%@ include file="sidebar.jsp" %>
        </div>
</html>