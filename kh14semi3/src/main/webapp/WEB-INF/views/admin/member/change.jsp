<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form action="change" method="post" autocomplete="off">
	<div class="container w-600 my-50">
		<div class="row center">
			<h1>회원정보수정</h1>
		</div>
		<div class="row">
			<input name="memberId" type="hidden" value="${memberDto.memberId}">		
		</div>
		<div class="row">
			<label>이름</label> <input type="text" name="memberName"
				value="${memberDto.memberName}" class="field w-100">
		</div>
		<div class="row">
			<label>직급</label> <select name="memberRank" class="field w-100">
				<option value="">분류</option>
				<option value="관리자">관리자</option>
				<option value="교수">교수</option>
				<option value="학생">학생</option>
			</select>
		</div>
		<div class="row">
			<label>생년월일</label> <input type="date" name="memberBirth"
				value="${memberDto.memberBirth}" class="field w-100">
		</div>
		<div class="row">
			<label>연락처</label> <input type="tel" name="memberCell"
				value="${memberDto.memberCell}" class="field w-100">
		</div>
		<div class="row">
			<label>이메일</label> <input type="email" name="memberEmail"
				value="${memberDto.memberEmail}" class="field w-100">
		</div>
		<div class="row">
			<input type="text" name="memberPost" class="field" placeholder="우편번호"
				readonly>
			<button class="btn btn-neutral btn-find-address">
				<i class="fa-solid fa-magnifying-glass"></i>
			</button>
			<button class="btn btn-negative btn-clear-address">
				<i class="fa-solid fa-xmark"></i>
			</button>
		</div>
		<div class="row">
			<input type="text" name="memberAddress1" class="field w-100"
				placeholder="기본주소" readonly>
		</div>
		<div class="row">
			<input type="text" name="memberAddress2" class="field w-100"
				placeholder="상세주소">
		</div>
		<div class="row mt-30">
			<button class="btn btn-positive w-100">수정하기</button>
		</div>
	</div>
</form>



