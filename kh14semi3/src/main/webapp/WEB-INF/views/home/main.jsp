<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<html>
<head>

<title>학사정보메인페이지</title>
</head>
<body>
	<h1>확인용 메인페이지</h1>
	createdUser = ${sessionScope.createdUser},
	createdRank = ${sessionScope.createdRank}
	<a href="/registration/list">수강신청이동</a>
	<a href="/lecture/list">강의목록이동</a>
</body>
</html>