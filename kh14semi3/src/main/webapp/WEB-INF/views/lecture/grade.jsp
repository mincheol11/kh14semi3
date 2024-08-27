<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

createdUser = ${sessionScope.createdUser} , 
createdRank = ${sessionScope.createdRank}


<div class="container w-900 my-50">
	<div class="row center">
		<h2>${sessionScope.createdUser}님의 성적 조회</h2>
	</div>

	<div class="row center">
		<form action="grade" method="get" autocomplete="off">
			<!-- 검색창 --> 
			<select class="field" name="column">
			<option value="grade_lecture" <c:if test="${param.column == 'grade_lecture'}">selected</c:if>>강의코드</option>
		</select>
		<input class="field" type="search" name="keyword" value="${param.keyword}">
			<button class="btn btn-neutral">검색</button>
		</form>
	</div>

	<div class="row center">
		<c:choose>
			<%-- 결과가 없을 때 --%>
			<c:when test="${gradeList.isEmpty()}">
				<h2>결과가 존재하지 않습니다</h2>
			</c:when>
			<%-- 결과가 있을 때 --%>
			<c:otherwise>
				<!-- 결과 화면 -->
				<div class="right">
					<i class="fa-brands fa-slack red"></i> 강의명 클릭시 상세 정보 페이지로 이동
				</div>
				<table class="table table-horizontal table-hover">
				<thead>
					<tr>
						<th>강의코드</th>
						<th>강의명</th>
						<th>출석점수</th>
						<th>중간고사</th>
						<th>기말고사</th>
						<th>과제점수</th>
						<th>성적</th>
						<th>비고</th>
					</tr>
				</thead>
				<tbody align="center">
					<c:forEach var="gradeDto" items="${gradeList}">
					<tr>
						<td>${gradeDto.gradeLecture}</td>
						<td></td>
						<td>${gradeDto.gradeAttendance}</td>
						<td>${gradeDto.gradeScore1}</td>
						<td>${gradeDto.gradeScore2}</td>
						<td>${gradeDto.gradeHomework}</td>
						<td>${gradeDto.gradeRank}</td>
						<td></td>
					</tr>					
					</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>			
	</div>
</div>

<%-- navigator.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

