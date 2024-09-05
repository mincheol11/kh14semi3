<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<form action="takeOff" method="post">
	<div class="container w-500 my-50">
		<div class="row center">
			<h1>휴학 및 휴직 사유</h1>
		</div>
		<div class="row center">
			<input type="hidden" name="takeOffTarget" value="${param.takeOffTarget}">
			<textarea class="w-100" name="takeOffMemo" rows="10" cols="60"></textarea>
		</div>
		<div class="row right">
			<button class="btn btn-negative">휴학</button>
			<a class="btn btn-neutral" href="list">취소</a>
		</div>
	</div>
</form>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>




