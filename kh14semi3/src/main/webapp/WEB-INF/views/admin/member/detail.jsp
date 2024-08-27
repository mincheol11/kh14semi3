<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container w-600 my-50">
	<div class="row center">
		<h2>회원 정보 상세</h2>
	</div>

	<div class="row center">
		<table class="table table-hover table-horizontal w-100">
			<tr>
				<th width="30%">아이디</th>
				<td>${memberDto.memberId}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${memberDto.memberName}</td>
			</tr>
			<tr>
				<th>구분</th>
				<td>${memberDto.memberRank}</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${memberDto.memberBirth}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${memberDto.memberCell}</td>
			</tr>
			<tr>
				<th>Email</th>
				<td>${memberDto.memberEmail}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>[${memberDto.memberPost}] ${memberDto.memberAddress1}
					${memberDto.memberAddress2}</td>
			</tr>
			<tr>
				<c:if test="${memberDto.memberRank=='학생'}">
				<th>입학일</th>
				</c:if>
				<c:if test="${memberDto.memberRank=='교수'}">
				<th>등록일</th>
				</c:if>
				<c:if test="${memberDto.memberRank=='관리자'}">
				<th>입사일</th>
				</c:if>				
				<td><fmt:formatDate value="${memberDto.memberJoin}"pattern="yyyy-MM-dd E HH:mm:ss" /></td>
			</tr>
		</table>
	</div>

	<!-- 메뉴 배치 -->
	<div class="row float-box">
		<div class="float-right">
			<a href="list" class="btn btn-neutral">회원 정보 검색</a> <a
				href="change?memberId=${memberDto.memberId}"
				class="btn btn-neutral ms-10">회원 정보 수정</a> <a
				href="delete?memberId=${memberDto.memberId}"
				class="btn btn-neutral ms-10">회원 정보 삭제</a>
		</div>
	</div>

</div>
