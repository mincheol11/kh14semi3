<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<h1>강의 목록</h1>

<!-- 검색창 -->
<form action="list" method="get">
	<select name="column">
		<option value="lecture_department" <c:if test="${param.column == 'lecture_department'}">selected</c:if>>전공(학과)</option>
		<option value="lecture_professor" <c:if test="${param.column == 'lecture_professor'}">selected</c:if>>교수명</option>
		<option value="lecture_type" <c:if test="${param.column == 'lecture_type'}">selected</c:if>>분류</option>
		<option value="lecture_name" <c:if test="${param.column == 'lecture_name'}">selected</c:if>>강의명</option>
	</select>
	<input type="text" name="keyword" value="${param.keyword}">
	<button>검색</button>
</form>

<!-- 결과 화면 -->
<table border="1" width="800">
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
			<c:when test="${lectureList.isEmpty()}">
				<tr>
					<td colspan="5">결과가 존재하지 않습니다</td>
				</tr>
			</c:when>
			<%-- 결과가 있을 때 --%>
			<c:otherwise>
				<c:forEach var="dto" items="${lectureList}">
				<tr>
					<td>${lectureDto.lectureDepartment}</td>
					<td>${lectureDto.lectureProfessor}</td>
					<td>${lectureDto.lectureType}</td>
					<td>
						<a href="detail?lectureCode=${lectureDto.lectureCode}">
							${lectureDto.lectureCode}
						</a>
					</td>
					<td>${lectureDto.lectureTime} ${lectureDto.lectureDuration} ${lectureDto.lectureDay}</td>
					<td>${lectureDto.lectureRoom}</td>
					<td>${lectureDto.lectureCount}</td>
					
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


