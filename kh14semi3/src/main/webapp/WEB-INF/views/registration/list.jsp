<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	.table {
		border: 1px solid #2d3436;
		width: 100%;
		font-size: 16px;
	}
</style>

<script type="text/javascript">
	$(function(){
	
	
	});
</script>

<div class="container w-900 my-50">
	<div class="row center">
		<h1>강의 목록</h1>
	</div>

	<div class="row">
		<form action="list" method="get" autocomplete="off">
			<!-- 검색창 --> 
			<select class="field" name="column">
			<option value="lecture_department" <c:if test="${param.column == 'lecture_department'}">selected</c:if>>전공(학과)</option>
			<option value="lecture_professor" <c:if test="${param.column == 'lecture_professor'}">selected</c:if>>교수명</option>
			<option value="lecture_type" <c:if test="${param.column == 'lecture_type'}">selected</c:if>>분류</option>
			<option value="lecture_name" <c:if test="${param.column == 'lecture_name'}">selected</c:if>>강의명</option>
		</select>
		<input class="field" type="search" name="keyword" value="${param.keyword}">
			<button class="btn btn-neutral"">검색</button>
		</form>
	</div>

	<div class="row">
		<!-- 결과 화면 -->
		<table class="table table-horizontal table-hover w-100">
		<thead>
			<tr>
				<th>전공(학과)</th>
				<th>교수명</th>
				<th>분류</th>
				<th>강의명</th>
				<th>강의시간</th>
				<th>강의실</th>
				<th>수강인원</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody align="center">
			<c:choose>
				<%-- 결과가 없을 때 --%>
				<c:when test="${registrationList.isEmpty()}">
					<tr>
						<td colspan="5">결과가 존재하지 않습니다</td>
					</tr>
				</c:when>
				<%-- 결과가 있을 때 --%>
				<c:otherwise>
					<c:forEach var="registrationDto" items="${RegistrationList}">
					<tr>
						<td>${registrationDto.RegistrationDto}</td>
						<td>${registrationDto.lectureProfessor}</td>
						<td>${registrationDto.lectureType}</td>
						<td>
							<a href="#">
								${RegistrationDto.lectureCode}
							</a>
						</td>
						<td>${registrationDto.lectureTime} ${lectureDto.lectureDuration} ${lectureDto.lectureDay}</td>
						<td>${registrationDto.lectureRoom}</td>
						<td>${registrationDto.lectureCount}</td>
						
						<%-- 교수인 경우 --%>
						<c:if test="${sessionScope.createdRank == '교수'}">
							<td><a href="#">성적입력</a></td>
						</c:if>
					</tr>
					
					</c:forEach>
				</c:otherwise>
			</c:choose>
			
		</tbody>
	</table>
	</div>

</div>


