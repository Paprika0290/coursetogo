<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
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
</body>
</html>