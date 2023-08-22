<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page import="com.spring.coursetogo.dto.CourseInformDTO" %>
<c:set var="courseInformList" value="${requestScope.courseInformList}"/>





<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course To Go / Course List</title>
	<style>
	    table {
			width: 80%;
	    }
	    
        .inline-items {
             white-space: nowrap;
        }
        .item {
            display: inline-block;
            border: 1px solid #EAE8E8;
            margin: 5px;
            padding: 5px;
        }
	</style>
</head>
<body>
		<c:if test="${empty requestScope.courseInformList}">
			<p style="margin: auto; text-align: center;">등록된 코스가 존재하지 않습니다.<br>나만의 코스를 만들어볼까요?</p>
		</c:if>
		
		<c:if test="${not empty requestScope.courseInformList}">
			<div>		
		    	 	<c:forEach items="${requestScope.courseInformList}" var="courseInformDTO" varStatus="courseSt">
	
				    	 		<div style="margin: 5px;
				    	 					background-color: #DDEBF0;
				    	 					border-radius: 5px;
			       	 					    border: 1px solid #BDD9E3;
			       	 					    padding: 10px;">
			       	 				<div style="margin-bottom:5px;
												background-color: #fafafa;
												border-radius: 5px;
												padding:5px;
				       	 					    padding-left: 20px;">	    
							    	 	<c:forEach items="${requestScope.courseMakerUserNameList}" var="userName" varStatus="userSt">
						    	 			<c:if test="${courseSt.index eq userSt.index}">
						    	 				<b>${userName} </b>님의
						    	 			</c:if>
						    	 		</c:forEach>
						    	 		
						    	 		<c:forEach items="${requestScope.courseDetailPageList}" var="coursePage" varStatus="pageSt">
						    	 			<c:if test="${courseSt.index eq pageSt.index}">
						    	 				<c:set var="query" value="${coursePage}" scope="request" />
						    	 			</c:if>
						    	 		</c:forEach>
						    	 		
					    	 			<a href="/courseList/Map?${query}" style="background-color: white;
					    	 													  color:#595959;"><b>${courseInformDTO.courseName} </b></a> Course: <b style="color: #797979">${courseInformDTO.courseContent}</b> <br>
									</div>				    	 			
					                <div class="inline-items" style = "border-radius:5px;
					                								   background-color: ;
					                								   margin-top: 5px;
					                								   display:flex;
					                								   align-items: center;
					                								   justify-content: center;">
					                    <c:forEach items="${fn:split(courseInformDTO.courseList, ',')}" var="place">
					                        <div class="item" style = "padding:5px;
					                        						   background-color: #71B6D0;
					                        						   border-radius:5px;
					                        						   color: white;
					                        						   margin-right:15px;"><b>${place}</b></div>
					                    </c:forEach>
					                </div>
					                
									<c:forEach begin="1" end="${courseInformDTO.courseAvgScore}" varStatus="status">
									    <span>&#9733;</span>
									</c:forEach>
		
				    	 		</div>
			        </c:forEach>
			</div>
		</c:if>

</body>
</html>