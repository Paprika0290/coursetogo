<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
 
<%@page import="java.util.*"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CategorySearch</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
 
    </script>
</head>
<body>
    <h1>지역명 검색</h1>
    <form id="searchForm" method="get" action="/jSearchA" accept-charset="utf-8">
        <input type="text" id="areaName" name="areaName" placeholder="검색어를 입력하세요">
        <button type="submit">검색</button>
    </form>

    <h1>업종별 검색</h1>
    <form id="searchForm" method="get" action="/jSearchC" accept-charset="utf-8">
        <input type="text" id="categoryName" name="categoryName" placeholder="검색어를 입력하세요">
        <button type="submit">검색</button>
    </form>

    <h1>지역명,업종별 검색</h1>
    <form id="searchForm" method="get" action="/jSearchAC" accept-charset="utf-8">
        <input type="text" id="searchTotal" name="searchTotal" placeholder="검색어를 입력하세요">
        <button type="submit">검색</button>
    </form>
</body>
</html>
