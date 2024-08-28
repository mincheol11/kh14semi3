<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	
</style>

<!-- <script type="text/javascript">
	$(function(){
		// 이 페이지의 파라미터 중에서 gradeLecture의 값을 알아내는 코드
		var params = new URLSearchParams(location.search);
		var gradeLecture = params.get("gradeLecture");
		
		// 점수 등록 
		// - 등록 버튼(.grade-insert-btn)을 클릭하면 정보를 서버로 전송
		// - 전송할 정보 : 출석(gradeAttendance), 중간평가(gradeScore1), 기말평가(gradeScore2), 과제(gradeHomework), 총점(gradeRank)
		$(".reply-add-btn").click(function(){

			// step 1 - 작성된 내용을 읽는다
			var grade = $(".grade-insert").val();
			if(grade.length == 0) return;
			
			// step 2 - 비동기 통신을 보낸다
			$.ajax({
				url: "/lecture/grade/insert",
				method: "post",
				data: {
					gradeAttendance: attendance,					
					gradeScore1: score1,
					gradeScore2: score2,
					gradeHomework: homework,
					gradeRank: rank,
				},
				success: function(response) {
					//console.log("점수 등록 완료");
					$(".grade-insert").val("");	//점수 내용 삭제
					// 목록 다시 불러오기
					loadstudentList();
				},
			});
		});
		
		// 학생 목록 처리
		loadstudentList();	//최초 1회 호출
		function loadstudentList() {
			// 목록 불러오기
			$.ajax({
				url: "/lecture/grade/insert",
				method: "post",
				data: {
					gradeLecture : gradeLecture
				},
				success: function(response) {	// response는 List<GradeDto>
					// 기존 내용 삭제
					$(".student-list-wrapper").empty();
					
					//전달된 학생수만큼 반복하여 화면 생성
					for(var i=0; i < response.length; i++) {
						// [1]	템플릿을 불러온다
						var template = $("#student-template").text();	//String
						// [2] HTML로 변환(파싱)
						var html = $.parseHTML(template);
						// [3] 탐색하여 값을 치환
						$(html).find(".student-id").text(response[i].gradeStudent);
						$(html).find(".student-name").text(response[i].memberName);
						$(html).find(".student-attendance").text(response[i].gradeAttendance);
						$(html).find(".student-score1").text(response[i].gradeScore1);
						$(html).find(".student-score2").text(response[i].gradeScore2);
						$(html).find(".student-homework").text(response[i].gradeHomework);
						$(html).find(".student-total").text(response[i].gradeRank);
						
						// [4] 영역에 추가
						$(".student-list-wrapper").append(html);	// $(html).appendTo(".student-list-wrapper");
					}
				}
			});
		}
	
	});
</script> -->

<%--
<!-- 학생 템플릿 -->
<script type="text/template" id="student-template">
	<!-- 학생1명 영역 -->
	<div class="student-wrapper">
		<!-- 점수 영역 -->
		<div class="grade-wrapper">
			<div class="student-id">학번</div>
			<div class="student-name">이름</div>
			<div class="student-attendance">출석</div>
			<div class="student-score1">중간평가</div>
			<div class="student-score2">기말평가</div>
			<div class="student-homework">과제</div>
			<div class="student-total">총점</div>
				<a href="#" class="link link-animation grade-insert-btn">입력/수정</a>
			</div>
		</div>
	</div>
</script>
 --%>

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
				<tbody class="center">
					<!-- 학생 목록 -->
					<tr>
						<div class="row"> <!-- student-list-wrapper -->
							<c:forEach var="gradeStudentVO" items="${studentList}">
								<td>${gradeStudentVO.memberId}</td>
								<td>${gradeStudentVO.memberName}</td>
								<td>${gradeStudentVO.gradeAttendance}</td>
								<td>${gradeStudentVO.gradeScore1}</td>
								<td>${gradeStudentVO.gradeScore2}</td> 
								<td>${gradeStudentVO.gradeHomework}</td>
								<td>${gradeStudentVO.gradeRank}</td> 
								<td><button type="button" class="btn btn-positive btn-insert"></button></td>
							</c:forEach> 
						</div>
					</tr>
				</tbody>
		</table>
		<!-- 점수 입력 등록 -->
		<div class="row">
			<button type="button" class="btn btn-positive w-100 grade-insert-btn">
				<i class="fa-solid fa-pen"></i> 등록하기
			</button>
		</div>
	</form>

</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>