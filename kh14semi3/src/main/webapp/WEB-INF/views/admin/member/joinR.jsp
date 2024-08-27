<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<h2>joinR 페이지</h2>

<c:choose>
	<c:when test="${param.memberRank == '학생' }">
		<input name="studentId" value="${param.memberId}" readonly>
		<div>${param.memberRank}</div>
	</c:when>
	<c:when test="${param.memberRank == '교수' }">
		<input name="studentId" value="${param.memberId}" readonly>
		<div>${param.memberRank}</div>
	</c:when>
	<c:when test="${param.memberRank == '관리자' }">
		<input name="studentId" value="${param.memberId}" readonly>
		<div>${param.memberRank}</div>
	</c:when>
	<c:otherwise>
	</c:otherwise>
</c:choose>



<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
