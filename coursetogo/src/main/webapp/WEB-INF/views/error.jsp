<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body {
         
            font-family: Arial, sans-serif;
            margin: 40px;
        }

        h1 {
            color: navy;
        }
        .error{
        left: 220px;
        
        }
    </style>
</head>
<body>
  <div class="sidebar" >
            <%@ include file="sidebar.jsp" %>
        </div>
        <div id="error" style="  position: relative;left:220px">
		
		<img src="/images/error.png">
   <%--  <p>An unexpected error occurred.</p>
    <p>Status Code: ${status}</p>
    <p>Error Message: ${message}</p>
    예외가 존재하는 경우에만 예외 정보를 표시합니다
    <% if (exception != null) { %>
        <h2>Exception:</h2>
        <pre>${exception}</pre>
    <% } %> --%>
    
    </div>
</body>
</html>