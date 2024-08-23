<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	.table {
		border: 1px solid #2d3436;
		width: 100%;
		font-size: 16px;		
	}	
	.class-regist{
		cursor: pointer;
	}
</style>

<%-- <c:if test="${sessionScope.createdRank == '학생'}"> --%>
<script type="text/javascript">
	// (회원전용) 하트를 누르면 좋아요 처리를 수행
	var params = new URLSearchParams(location.search);
	var lectureCode = $(".lecture-code").attr("data-code");
	
	$(function(){
		$(".class-regist").on("click",function(){
			$.ajax({
				url: "/rest/registration/regist",
				method: "post",
				data: {lectureCode : lectureCode},
				success: function(response){
					if(response.checked){						
						console.log(lectureCode);
						// 너 이미 이거 수강신청 했어 라는 문구 출력 alert-link.js 만들어서 추가
						window.alert("너 이거 담음");
					}
					else{
						// 너의 수강신청목록에 이거 넣었어 라는 문구 출력
						window.alert("이거 담을게");
					}					
					/* $(".class-regist").next("span").text(response.count); */
				}
			});
		});
	});
</script>
<%-- </c:if> --%>


<div class="container w-700 my-50">
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
			<button class="btn btn-neutral">검색</button>
		</form>
	</div>
	

	<div class="row">
		<c:choose>
			<%-- 결과가 없을 때 --%>
			<c:when test="${lectureList.isEmpty()}">
				<h2>결과가 존재하지 않습니다</h2>
			</c:when>
			<%-- 결과가 있을 때 --%>
			<c:otherwise>
				<!-- 결과 화면 -->
				<div class="right">
					<i class="fa-brands fa-slack red"></i> 강의명 클릭시 수강신청 담기 가능
				</div>
				<%-- 
				<div class="flex-box">
				<table class="table table-horizontal w-20" style="border-right:none;">
					<thead>
						<tr>
							<th>전공(학과)</th>
						</tr>
					</thead>
					<tbody class="center">
						<c:forEach var="departmentDto" items="${departmentList}">
						<tr class="w-20">
							<td>${departmentDto.departmentName}</td>
						</tr>
						</c:forEach>
					</tbody>										
				</table>
				 --%>
				<table class="table table-horizontal table-hover" style="border-left:none;">
					<thead>
						<tr>
							<th>전공(학과)</th>
							<th>교수명</th>
							<th>분류</th>
							<th width="30%">강의명</th>
							<th>강의코드</th>
							<th>강의시간</th>
							<th>강의실</th>
							<th>수강인원</th>
							<th>비고</th>
						</tr>
					</thead>
					<tbody class="center">					
						<c:forEach var="lectureDto" items="${lectureList}">
						<tr>
							<td>${lectureDto.lectureDepartment}</td>
							<td>${lectureDto.lectureProfessor}</td>
							<td>${lectureDto.lectureType}</td>
							<td class="link link-animation class-regist">
								${lectureDto.lectureName}
							</td>
							<td class="lecture-code" data-code="${lectureDto.lectureCode}">${lectureDto.lectureCode}</td>
							<td>${lectureDto.lectureTime} ${lectureDto.lectureDuration} ${lectureDto.lectureDay}</td>
							<td>${lectureDto.lectureRoom}</td>
							<td>${lectureDto.lectureCount}</td>		
							<td></td>					
						</tr>					
						</c:forEach>
					</tbody>
				</table>
			<%-- </div> --%>
			</c:otherwise>
		</c:choose>
	</div>

</div>


