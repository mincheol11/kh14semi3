<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-600 my-50">
	<form action="joinR" method="post" autocomplete="off">

	<c:choose>
			<c:when test="${memberDto.memberRank == '학생'}">
				<div class="row">
					<input name="studentId" value="${memberDto.memberId}" type="hidden" class="field w-100">					
				</div>
				<div class="row">
					<label>학과코드</label>
				</div>
				<div class="row center">
					<input name="studentDepartment" class="field w-100">
				</div>
				<div class="row">
					<label>학년</label>
				</div>
				<div class="row center">
					<select name="studentLevel" class="field w-100">
						<option value="">분류</option>
						<option value="1">1 학년</option>
						<option value="2">2 학년</option>
						<option value="3">3 학년</option>
						<option value="4">4 학년</option>
					</select>
				</div>
			</c:when>
			<c:when test="${memberDto.memberRank == '교수'}">
				<div class="row">
					<input name="professorId" value="${memberDto.memberId}" type="hidden" class="field w-100">
				</div>
				<div class="row center">
					<label>학과코드</label>
				</div>
				<div class="row center">
					<input name="professorDepartment" class="field w-100">
				</div>
			</c:when>
			<c:when test="${memberDto.memberRank == '관리자'}">
				<div class="row">
					<input name="adminId" value="${memberDto.memberId}" type="hidden" class="field w-100">
				</div>
			</c:when>
		</c:choose>
		<div class="right">
			<button class="btn btn-positive" type="submit">등록완료</button>
		</div>
	</form>
</div>



<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	
