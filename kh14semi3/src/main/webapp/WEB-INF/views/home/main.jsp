<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.profile{
	min-height:150px;
}
</style>

<div class="right">
	createdUser = ${sessionScope.createdUser},
	createdRank = ${sessionScope.createdRank}
</div>

<div class="container w-1000 mb-30">
	<div class="row flex-box">
		<div class="w-50 mx-10 profile flex-core">
			<div class="row center">
				<h2>마이페이지</h2>
			</div>
		</div>
		<div class="w-50 mx-10 flex-core">
			<div class="row center">
				<h2>공지사항</h2>
			</div>
		</div>
	</div>
	
	<hr>
	
	<div class="row flex-box">
		<div class="w-50 mx-10 profile flex-core">
			<div class="row center">
				<h2>강의 목록</h2>
			</div>
		</div>
		<div class="w-50 mx-10 flex-core" >
			<div class="row center">
				<h2>학사 일정</h2>
			</div>
		</div>
	</div>
	
</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
	