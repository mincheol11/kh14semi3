<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
</style>

<script type="text/javascript">
	$(function() {
		// 이 페이지의 파라미터 중에서 gradeLecture의 값을 알아내는 코드
		var params = new URLSearchParams(location.search);
		var lectureCode = params.get("lectureCode");
		var gradeLecture = params.get("gradeLecture");
		
		$(document).ready(function() {
		    // 학생 점수 목록 불러오기
		    function loadStudentList() {
		        $.ajax({
		            url: '/rest/grade/list',
		            method: 'GET',
		            data: {
		                lectureCode: lectureCode, // 강의 코드 전달
		                gradeLecture: gradeLecture, // 강의명 전달
		            },
		            success: function(response) {
		            	// 기존 내용 삭제
						$(".student-list-wrapper").empty();

						//전달된 학생수만큼 반복하여 화면 생성
						for (var i = 0; i < response.length; i++) {
							// [1]	템플릿을 불러온다
							var template = $("#student-template").text(); //String
							// [2] HTML로 변환(파싱)
							var html = $.parseHTML(template);
							// [3] 탐색하여 값을 치환
							$(html).find(".student-id").text(response[i].memberId);
							$(html).find(".student-name").text(response[i].memberName);
							$(html).find(".student-attendance").text(response[i].gradeAttendance);
							$(html).find(".student-score1").text(response[i].gradeScore1);
							$(html).find(".student-score2").text(response[i].gradeScore2);
							$(html).find(".student-homework").text(response[i].gradeHomework);
							$(html).find(".student-rank").text(response[i].gradeRank);
							$(html).find(".grade-insert-btn, .grade-insert-edit-btn")
										.attr("data-grade-code",response[i].gradeCode);

							// [4] 영역에 추가
							$(".student-list-wrapper").append(html);	// $(html).appendTo(".student-list-wrapper");
						}
					},
				});
			}

		
		// 학생 목록 처리
		loadStudentList(); //최초 1회 호출
		
		//수정버튼 처리
		$(document).on("click", ".grade-insert-edit-btn", function(e) {
			e.preventDefault(); //기본 이벤트 차단

			// 기존에 열려있는 수정 화면을 모두 제거
			$(".student-wrapper").show(); //숨긴건 표시
			$(".student-edit-wrapper").remove();

			// [1] 편집용 화면을 생성
			var template = $("#student-edit-template").text();
			var html = $.parseHTML(template);
			$(this).parents(".student-edit-wrapper").after(html);

			// [2] 표시용 화면을 숨김
			$(this).parents(".student-wrapper").hide();

			// [3] 기존 값을 복사
			var memberId = $(this).parents(".student-wrapper").find(".student-id").text();
			$(html).find(".student-id").text(memberId);
			var memberName = $(this).parents(".student-wrapper").find(".student-name").text();
			$(html).find(".student-name").text(memberName);
			var gradeAttendance = $(this).parents(".student-wrapper").find(".student-attendance").text();
			$(html).find(".student-edit-attendance").text(gradeAttendance);
			var gradeScore1 = $(this).parents(".student-wrapper").find(".student-score1").text();
			$(html).find(".student-edit-score1").text(gradeScore1);
			var gradeScore2 = $(this).parents(".student-wrapper").find(".student-score2").text();
			$(html).find(".student-edit-score2").text(gradeScore2);
			var gradeHomework = $(this).parents(".student-homework").find(".student-homework").text();
			$(html).find(".student-edit-homework").text(gradeHomework);
			var gradeRank = $(this).parents(".student-wrapper").find(".student-rank").text();
			$(html).find(".student-edit-rank").text(gradeRank);

			// [4] 완료버튼에 gradeCode 전달
			var gradeCode = $(this).attr("data-grade-code");
			$(html).find(".grade-insert-done-btn").attr("data-grade-code", gradeCode);
		});

		
		// 취소 버튼
		$(document).on("click", ".grade-insert-cancel-btn", function() {
			// [1] 표시용 화면을 숨김 해제한다
			$(this).parents(".student-edit-wrapper").prev(".student-wrapper").show();

			// [2] 편집용 화면을 제거한다
			$(this).parents(".student-edit-wrapperr").remove();
		});

		
		// 완료 버튼
		$(document).on("click", ".grade-insert-done-btn", function() {
			// this를 이용해서 수강신청번호(gradeCode)와 기존내용을 알아내야 한다
			var gradeAttendance = $(this).parents(".student-edit-wrapper")
														.find(".student-edit-attendance").val();
			var gradeScore1 = $(this).parents(".student-edit-wrapper")
										.find(".student-edit-score1").val();
			var gradeScore2 = $(this).parents(".student-edit-wrapper")
										.find(".student-edit-score2").val();
			var gradeHomework = $(this).parents(".student-edit-wrapper")
											.find(".student-edit-homework").val();
			var gradeRank = $(this).parents(".student-edit-wrapper")
									.find(".student-edit-rank").val();
			var gradeCode = $(this).attr("data-grade-code");

			// 점수 내용이 없으면 알림메세지 출력 후 중지
			if (gradeAttendance.length == 0 || gradeScore1.length == 0 || 
				gradeScore2.length == 0 || gradeHomework.length == 0 || 
				gradeRank.length == 0) {
					window.alert("점수는 반드시 작성해야 합니다");
					return;
			}

			// 서버로 점수 수정을 위한 정보를 전송
			$.ajax({
				url : "/rest/grade/edit",
				method : "post",
				data : {
					gradeCode : gradeCode,
					gradeAttendance : gradeAttendance,
					gradeScore1 : gradeScore1,
					gradeScore2 : gradeScore2,
					gradeHomework : gradeHomework,
					gradeRank : gradeRank,
				},
				success : function(response) {
					loadList();
				}
			});
		});

	});
</script>


<!-- 학생 점수 템플릿 -->
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
			<div class="student-rank">총점</div>
			<div class="student-btn">
				<a href="#" class="link link-animation grade-insert-edit-btn">수정</a>
			</div>
		</div>
	</div>
</script>

<!-- 학생 점수 수정 템플릿 -->
<script type="text/template" id="student-edit-template">
	<!-- 학생1명 영역 -->
	<div class="student-wrapper student-edit-wrapper">
		<!-- 점수 영역 -->
		<div class="grade-wrapper">
			<div class="student-id">학번</div>
			<div class="student-name">이름</div>
			<div class="student-edit-attendance">출석</div>
			<div class="student-edit-score1">중간평가</div>
			<div class="student-edit-score2">기말평가</div>
			<div class="student-edit-homework">과제</div>
			<div class="student-edit-rank">총점</div>
			<div class="student-edit-btn">
				<a href="#" class="link link-animation grade-insert-cancel-btn">취소</a>
				<a href="#" class="link link-animation grade-insert-done-btn">완료</a>
			</div>
		</div>
	</div>
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
			<tbody>
				<tr>
					<td>
						<div class="row student-list-wrapper">
						
						</div>
					</td>
				</tr>
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