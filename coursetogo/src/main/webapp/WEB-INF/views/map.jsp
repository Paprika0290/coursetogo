<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>간단한 지도 표시하기</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=eeovn23rmv"></script>
</head>
<body>
<div id="map" style="width:100%;height:1000px;"></div>
<div class="container">
<div class="row justify-content-center">
		<div class="col-6">
			<ul class="list-group">
				<c:if test="${not empty RestaurantList}">
					<c:forEach var="restaurant" items="${RestaurantList}">
						<li class="list-group-item d-flex justify-content-between align-items-start">
							<div class="ms-2 me-auto">
								<div class="fw-bold">${restaurant.establishmentName}</div>
								${restaurant.establishmentName}
								${restaurant.mapXCoordinate}
								${restaurant.mapYCoordinate}
								
							</div> <span class="badge bg-primary rounded-pill">${notice.hit}</span>
						</li>
					</c:forEach>
				</c:if>
			</ul>
		</div>
	</div>
	</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
   <script>
   var polylinePath = new Array();
   
   
   <c:forEach var="direction" items="${DirectionList}">
   polylinePath.push(new naver.maps.LatLng( ${direction.mapYCoordinate}, ${direction.mapXCoordinate}));
   </c:forEach>
   /* console.log(polylinePath); */
   


        var map = new naver.maps.Map('map', {
            center: new naver.maps.LatLng(37.5112, 127.0981), // 잠실 롯데월드를 중심으로 하는 지도
            zoom: 15
        });
		
        var polyline = new naver.maps.Polyline({
            path: polylinePath,      //선 위치 변수배열
            strokeColor: '#FF0000', //선 색 빨강 #빨강,초록,파랑
            strokeOpacity: 0.8, //선 투명도 0 ~ 1
            strokeWeight: 6,   //선 두께
            map: map           //오버레이할 지도
        });
        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(37.5112, 127.0981),
            map: map,
            title:'사기',
            
         
            
        });
        
        var greenMarker = new naver.maps.Marker({
            position: new naver.maps.LatLng(37.3613962, 127.1112487),
            map: map,
            title: 'Green',
            icon: {
                content: [
                            '<div class="cs_mapbridge">',
                                '<div class="map_group _map_group crs">',
                                    '<div class="map_marker _marker num1 num1_big"> ',
                                        '<span class="ico _icon"></span>',
                                        '<span class="shd"></span>',
                                    '</div>',
                                '</div>',
                            '</div>'
                        ].join(''),
                size: new naver.maps.Size(38, 58),
                anchor: new naver.maps.Point(19, 58),
            },
            draggable: true
        });
        var pinkMarker = new naver.maps.Marker({
            position: new naver.maps.LatLng(37.3637770, 127.1174332),
            map: map,
            icon: {
                content: [
                            '<div class="cs_mapbridge">',
                                '<div class="map_group _map_group">',
                                    '<div class="map_marker _marker tvhp tvhp_big">',
                                        '<span class="ico _icon"></span>',
                                        '<span class="shd"></span>',
                                    '</div>',
                                '</div>',
                            '</div>'
                        ].join(''),
                size: new naver.maps.Size(38, 58),
                anchor: new naver.maps.Point(19, 58),
            }
        });
        
        pinkMarker.setTitle('Pink Hot');
        pinkMarker.setDraggable(true);
        
        
        <c:forEach var="restaurant" items="${RestaurantList}">
        var marker = new naver.maps.Marker({
            position: new naver.maps.LatLng(${restaurant.mapYCoordinate}, ${restaurant.mapXCoordinate}),
            map: map
        });
    </c:forEach>
    </script>
</body>
</html>