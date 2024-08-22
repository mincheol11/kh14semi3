<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 제목 -->
<h1>회원 관리</h1>

<form action="list" method="get">
	<select name="column">
		<option value="member_id"<c:if test ="${param.column == 'member_id'}"> selected</c:if>>아이디</option>
		<option value="member_name"<c:if test ="${param.column == 'member_Name'}"> selected</c:if>>이름</option>
		<option value="member_email"<c:if test ="${param.column == 'member_email'}"> selected</c:if>>이메일</option>
		<option value="member_rank"<c:if test ="${param.column == 'member_rank'}"> selected</c:if>>등급</option>
	</select>
	<input type="text" name="keyword" value="${param.keyword}" placeholder="검색어" required>
	<button>검색</button>
</form>

<!-- 결과화면 -->
<hr>

<c:if test="${memberList.isEmpty()}">
	<h3>검색 결과가 존재하지 않습니다</h3>
</c:if>

<c:if test="${memberList.size() >0}">
	<table border="1" width="900">
		<thead>
			<tr>
				<th>아이디</th>
				<th>닉네임</th>
				<th>이메일</th>
				<th>등급</th>
				<th>가입일</th>
				<th>상태</th>
				<th>관리</th>
			</tr>
		</thead>
		<tbody align="center">
			<c:forEach var="memberTakeOffVO" items="${memberList}">
				<tr>
					<td><a href="detail?memberId=${memberTakeOffVO.memberId}">${memberTakeOffVO.memberId}</a></td>
					<td>${memberTakeOffVO.memberName}</td>
					<td>${memberTakeOffVO.memberEmail}</td>
					<td>${memberTakeOffVO.memberRank}</td>
					<td>${memberTakeOffVO.memberJoin}</td>
					<td>${memberTakeOffVO.takeOffType}</td>
					<td>
						<a href="detail?memberId=${memberTakeOffVO.memberId}">상세</a>
						<a href="edit?memberId=${memberTakeOffVO.memberId}">수정</a>
						<c:choose>
							<c:when test="${memberTakeOffVO.takeOffType == '해제'}">
								<a href="takeOff?takeOffTarget=${memberTakeOffVO.memberId}">차단</a>
							</c:when>
							<c:when test="${memberTakeOffVO.takeOffType == ''}">
								<a href="#">+포인트</a>
							</c:when>
							<c:otherwise>
								<a href="cancel?takeOffTarget=${memberTakeOffVO.memberId}">해제</a>
							</c:otherwise>
						</c:choose>
						<a href="delete?memberId=${memberTakeOffVO.memberId}">삭제</a>
					</td>
				</tr>
			</c:forEach>	
		</tbody>
	</table>
</c:if>