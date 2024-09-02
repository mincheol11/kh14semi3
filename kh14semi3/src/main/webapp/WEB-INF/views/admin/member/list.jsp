<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<div class="container w-900 my-50">
	<div class="row center">
		<h1>회원 관리</h1>
	</div>

	<!-- 검색창 -->
	<div class="row center">
		<form action="list" method="get" autocomplete="off">
			<select name="column" class="field">
				<option value="member_id"<c:if test ="${param.column == 'member_id'}"> selected</c:if>>아이디</option>
				<option value="member_name"<c:if test ="${param.column == 'member_name'}"> selected</c:if>>이름</option>
				<option value="member_email"<c:if test ="${param.column == 'member_email'}"> selected</c:if>>이메일</option>
				<option value="member_rank"<c:if test ="${param.column == 'member_rank'}"> selected</c:if>>등급</option>
			</select>
			<input class="field" type="text" name="keyword" value="${param.keyword}" placeholder="검색어">
			<button class="btn btn-positive" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
			<a class="btn btn-neutral" type="button" href="join"><i class="fa-solid fa-right-to-bracket"></i> 등록</a>
		</form>
	</div>

	<!-- 결과화면 -->

	<c:if test="${memberList.isEmpty()}">
		<h3>검색 결과가 존재하지 않습니다</h3>
	</c:if>

	<c:if test="${memberList.size() >0}">
		<table class="table table-horizontal table-hover w-100">
			<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>등급</th>
					<th>이메일</th>
					<th>가입일</th>
					<th>학적상태</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody align="center">
				<c:forEach var="memberTakeOffVO" items="${memberList}">
					<tr onclick="location.href='detail?memberId=${memberTakeOffVO.memberId}&memberRank=${memberTakeOffVO.memberRank}'" style="cursor: pointer">
						<td>${memberTakeOffVO.memberId}</td>
						<td>${memberTakeOffVO.memberName}</td>
						<td>${memberTakeOffVO.memberRank}</td>
						<td>${memberTakeOffVO.memberEmail}</td>
						<td>${memberTakeOffVO.memberJoin}</td>
						<td>${memberTakeOffVO.takeOffType}</td>
						<td>
							<c:choose>
								<c:when test="${memberTakeOffVO.takeOffType == '재학'}">
									<a class="link link-animation" href="takeOff?takeOffTarget=${memberTakeOffVO.memberId}">휴학</a>
								</c:when>
								<c:when test="${memberTakeOffVO.takeOffType == '휴학'}">
									<a class="link link-animation" href="takeOn?takeOffTarget=${memberTakeOffVO.memberId}">복학</a>
								</c:when>
								<c:when test="${memberTakeOffVO.takeOffType == '제적'}">
									<a class="link link-animation" href="blockNo?takeOffTarget=${memberTakeOffVO.memberId}">제적해제</a>
								</c:when>
								<c:otherwise>
									<a class="link link-animation" href="takeOff?takeOffTarget=${memberTakeOffVO.memberId}">휴학</a>									
								</c:otherwise>
							</c:choose>
							
							
							<c:if test="${memberTakeOffVO.takeOffType != '제적'}">
								<a class="link link-animation" href="blockGo?takeOffTarget=${memberTakeOffVO.memberId}">제적</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>	
			</tbody>
		</table>
	</c:if>
	<div class="row">
		<!-- 네비게이터 불러오는 코드 -->
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"/>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>