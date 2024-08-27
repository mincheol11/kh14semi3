<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="right">
	createdUser = ${sessionScope.createdUser},
	createdRank = ${sessionScope.createdRank}
</div>

<div class="container w-1000 mb-30">
	<div class="row flex-box">
		<div class="w-50 mx-10 profile">
			<div class="row center">
				<h2>확인용</h2>
			</div>
			<div class="row center">
				<h2>확인용</h2>
			</div>
		</div>
		<div class="w-50 mx-10">
			<div class="row center">
				<h2>확인용</h2>
			</div>
			<div class="row center">
				<h2>확인용</h2>
			</div>
		</div>
	</div>
	
	<hr>
	
	<div class="row flex-box">
		<div class="w-50 mx-10 profile">
			<div class="row center">
				<h2>확인용</h2>
			</div>
			<div class="row center">
				<h2>확인용</h2>
			</div>
		</div>
		<div class="w-50 mx-10" >
			<div class="row center">
				<h2>확인용</h2>
			</div>
			<div class="row center">
				<h2>확인용</h2>
			</div>
			<%-- <div class="row center" style="max-width:300px !important;">
				schedule.jsp에 존재하는 내용을 불러오도록 설정
				<jsp:include page="/WEB-INF/views/schedule/list.jsp"></jsp:include>
			</div> --%>
		</div>
	</div>
	
</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
	