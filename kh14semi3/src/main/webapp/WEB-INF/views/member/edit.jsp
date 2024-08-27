<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="edit" method="post" autocomplete="off">
	<div class="container w-600 my-50">
		<div class="row center">
			<h1>내 정보 수정</h1>
		</div>
		<div class="row">
			<label>학번[수정불가]</label> 
			<input name="memberId" type="text" value="${memberDto.memberId}" class="field w-100" readonly>		
		</div>
		<div class="row">
			<label>이름</label> 
			<input type="text" name="memberName" value="${memberDto.memberName}" class="field w-100">
		</div>
		<div class="row">
			<label>구분[수정불가]</label> 
			<input type="text" name="memberRank" value="${memberDto.memberRank}" class="field w-100" readonly>
		</div>
		<div class="row">
			<label>학적상태[수정불가]</label> 
			<input type="text" value="${lastDto.takeOffType}" class="field w-100" readonly>
		</div>		
		<div class="row">
			<label>생년월일</label>
			<input type="date" name="memberBirth" value="${memberDto.memberBirth}" class="field w-100">
		</div>
		<div class="row">
			<label>연락처</label> 
			<input type="tel" name="memberCell" value="${memberDto.memberCell}" class="field w-100">
		</div>
		<div class="row">
			<label>이메일</label>
			<input type="email" name="memberEmail" value="${memberDto.memberEmail}" class="field w-100">
		</div>
		<div class="row">
			<input type="text" name="memberPost" class="field" placeholder="우편번호" readonly>
			<button class="btn btn-neutral btn-find-address">
				<i class="fa-solid fa-magnifying-glass"></i>
			</button>
			<button class="btn btn-negative btn-clear-address">
				<i class="fa-solid fa-xmark"></i>
			</button>
		</div>
		<div class="row">
			<input type="text" name="memberAddress1" class="field w-100" placeholder="기본주소" readonly>
		</div>
		<div class="row">
			<input type="text" name="memberAddress2" class="field w-100" placeholder="상세주소">
		</div>
		<div class="row mt-30">
			<button class="btn btn-positive w-100">수정하기</button>
		</div>
		<div class="row mt-30">
			<a href="mypage" class="btn btn-neutral w-100">수정취소</a>
		</div>
	</div>
</form>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>