<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
</style>

<script type="text/javascript">
	$(function(){
		
	});
		
</script>


<div class="container w-1000 my-50">
	<div class="row center">
		<h1>성적입력</h1>
	</div>

<form action="gradeInsert" method="post" autocomplete="off">
		<table class="table table-horizontal w-100">
			<thead>
				<tr>
					<th>전공(학과)</th>
					<th>교수명</th>
					<th>분류</th>
					<th>강의명</th>
					<th>강의코드</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody class="center">
				<tr>
					<td>${lectureDto.lectureDepartment}</td>
					<td>${lectureDto.lectureProfessor}</td>
					<td>${lectureDto.lectureType}</td>
					<td>${lectureDto.lectureName}</td>
					<td>${lectureDto.lectureCode}</td>
					<td>#</td>
				</tr>
			</tbody>
		</table>

		<!-- 결과 화면 -->
		<table class="table table-horizontal w-100">
			<thead>
				<tr>
					<th>학번</th>
					<th>성명</th>
					<th>출석</th>
					<th>중간평가</th>
					<th>기말평가</th>
					<th>과제</th>
					<th>총점</th>
					<th>입력</th>
					<th>수정</th>
				</tr>
			</thead>
			<!-- 학생 목록 -->
			<tbody align="center">
				<c:forEach var="gradeStudentVO" items="${studentList}">
					<tr>
						<td>${gradeStudentVO.memberId}</td>
						<td>${gradeStudentVO.memberName}</td>
						<td>${gradeStudentVO.gradeAttendance}</td>
						<td>${gradeStudentVO.gradeScore1}</td>
						<td>${gradeStudentVO.gradeScore2}</td>
						<td>${gradeStudentVO.gradeHomework}</td>
						<td>${gradeStudentVO.gradeRank}</td>
						<td><button type="button" class="btn btn-positive grade-insert-btn">점수입력</button></td>
						<td><button type="button" class="btn btn-neutral grade-insert-edit-btn">점수수정</button></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
						<!-- 점수 등록 -->
						<div class="row">
							<button type="button" class="btn btn-positive w-100 grade-insert-btn">
								<i class="fa-solid fa-pen"></i> 점수 등록
							</button>
						</div>

	</form>

</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>