<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
			<c:forEach var="lectureDto" items="${list}">
			<tr>
				<td>${lectureDto.lectureDepartment}</td>
				<td>${lectureDto.lectureProfessor}</td>
				<td>${lectureDto.lectureType}</td>
				<td>${lectureDto.lectureName}</td>
				<td>${lectureDto.lectureCode}</td>		
				<td>#</td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
				
	<!--		
	<table class="table table-horizontal table-hover">
					<thead>
						<tr>
							<th>평가배점</th>
							<th>출석</th>
							<th>중간평가</th>
							<th>기말평가</th>
							<th>과제(태도)</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody class="center">					
						<tr>
							<td>기준</td>
							<td>20</td>
							<td>35</td>
							<td>35</td>
							<td>10</td>
						</tr>					
					</tbody>
				</table>
		-->
	
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
						<th>비고</th>
					</tr>
				</thead>
				<!-- 학생 목록 -->
				<tbody class="center">
					<tr>
						<td>#</td>
						<td>#</td>
						<td><input class="field"></td>
						<td><input class="field" ></td>
						<td><input class="field" ></td>
						<td><input class="field" ></td>
						<td>#</td>
						<td><button type="button" class="btn btn-grade-insert">입력/수정</button></td>	
					</tr>
				</tbody>
		</table>
	</form>

</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>