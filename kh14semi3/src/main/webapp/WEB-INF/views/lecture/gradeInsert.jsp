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
		// 성적(개별)입력		
		$(".btn-grade-input").click(function(){
			// step 1 - 작성된 내용을 읽는다
			var score = $(".grade-input").val();
			if(content.length == 0) return;
			
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
					$(".grade-input").val("");	//점수 삭제
					// 점수 다시 불러오기
					loadList();
				},
			});
	
	});
</script>

<!-- 점수입력 템플릿 -->
<script type="text/template" id="grade-template">
	<!-- 학생1명 영역 -->
	<div class="grade-wrapper">
		<!-- 내용 영역 -->
		<div class="score-wrapper">
			<div class="grade-attendance"">출석점수</div>
			<div class="grade-score1">중간평가</div>
			<div class="reply-info">
				<span class="time">yyyy-MM-dd HH:mm:ss</span>
				<a href="#" class="link link-animation reply-edit-btn">수정</a>
				<a href="#" class="link link-animation reply-delete-btn">삭제</a>
			</div>
		</div>
	</div>
</script>

<td><input class="field grade-input-attendance" ></td>
						<td><input class="field grade-input-score1" ></td>
						<td><input class="field grade-input-score2" ></td>
						<td><input class="field grade-input-homework" ></td>
						<td>총점</td>
						<td><button type="button" class="btn btn-grade-input">입력/수정</td>	




<script type="text/template" id="reply-edit-template">
	<!-- 댓글 수정 영역 -->
	<div class="reply-wrapper reply-edit-wrapper">
		<!-- 프로필 영역 -->
		<div class="image-wrapper">
			<img src="https://placehold.it/100x100">
		</div>
		
		<!-- 내용 영역 -->
		<div class="content-wrapper">
			<div class="reply-title">댓글작성자</div>
			<textarea class="field w-100 reply-edit-input"></textarea>
			<div class="right">
				<button type="button" class="btn btn-neutral reply-cancel-btn">취소</button>
				<button type="button" class="btn btn-positive reply-done-btn">완료</button>
			</div>
		</div>
	</div>
</script>



<div class="container w-900 my-50">
	<div class="row center">
		<h1>성적입력</h1>
	</div>
	
	<form action="gradeInsert" method="post" autocomplete="off">
		<div class="row">
			<!-- 결과 화면 -->
			<table class="table w-100">
			<thead>
				<tr>
					<th>학과/전공</th>
					<th>학년</th>
					<th>학번</th>
					<th>성명</th>
					<th>출석</th>
					<th>중간평가</th>
					<th>기말평가</th>
					<th>과제</th>
					<th>총점</th>
					<!-- <th>등급</th> -->
					<th>비고</th>
				</tr>
			</thead>
			<!-- 학생 목록 -->
			<div class="row student-list">
				<tbody align="center">
					<tr>
						<td>${departmentDto.departmentName}</td>
						<td>${studentDto.studentLevel}</td>
						<td>${studentDto.studentId}</td>
						<td>${memberDto.memberName}</td>
						<td><input class="field grade-input-attendance" ></td>
						<td><input class="field grade-input-score1" ></td>
						<td><input class="field grade-input-score2" ></td>
						<td><input class="field grade-input-homework" ></td>
						<td>총점</td>
						<td><button type="button" class="btn btn-grade-input">입력/수정</td>	
					</tr>
				</tbody>
			</div>
		</table>
		</div>
	</form>

</div>

