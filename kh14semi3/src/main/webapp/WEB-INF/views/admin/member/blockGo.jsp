<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<form action="blockGo" method="post">
	<div class="container w-500 my-50">
		<div class="row center">
			<h1>제적사유</h1>
		</div>
		<div class="row center">
			<input type="hidden" name="takeOffTarget" value="${param.takeOffTarget}">
			<textarea class="w-100" name="takeOffMemo" rows="10" cols="60"></textarea>
		</div>
		<div class="row right">
			<button class="btn btn-negative">제적</button>
			<a class="btn btn-positive" href="list">취소</a>
		</div>
	</div>
</form>