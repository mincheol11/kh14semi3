<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>
.kh-container{
	height: 100vh;  /* 뷰포트 높이의 100% */
}
</style>

<div class="container w-500 my-50">
	<div class="row center">
		<h1>회원 정보 상세</h1>
	</div>

	<div class="row center">
		<table class="table table-border w-100">
			<tr>
				<th width="30%">아이디</th>
				<td>${memberDto.memberId}</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>${memberDto.memberName}</td>
			</tr>
			<tr>
				<th>구분</th>
				<td>${memberDto.memberRank}</td>
			</tr>
			<tr>
				<c:choose>
					<c:when test="${memberDto.memberRank!='관리자'}">
						<th>학적상태</th>
						<c:if test="${lastDto.takeOffType == null}"><td>재학</td></c:if>
						<c:if test="${lastDto.takeOffType != null}"><td>${lastDto.takeOffType}</td></c:if>
					</c:when>
					<c:otherwise>
						<th>재직상태</th>
						<c:if test="${lastDto.takeOffType == null}"><td>재직</td></c:if>
						<c:if test="${lastDto.takeOffType == '재학'}"><td>재직</td></c:if>
						<c:if test="${lastDto.takeOffType == '휴학'}"><td>휴직</td></c:if>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<c:choose>
					<c:when test="${memberDto.memberRank=='학생'}">
						<tr>
							<th>학년</th>
							<td>${studentDto.studentLevel}</td>
						</tr>
						<tr>
							<th>학과</th>
							<td>${sdDto.departmentName}</td>
						</tr>
					</c:when>
 					<c:when test="${memberDto.memberRank=='교수'}">
 						<tr>
 							<th>학과</th>
 							<td>${pdDto.departmentName}</td>
 						</tr>
					</c:when>
					<c:otherwise>

					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>${memberDto.memberBirth}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>${memberDto.memberCell}</td>
			</tr>
			<tr>
				<th>Email</th>
				<td>${memberDto.memberEmail}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>[${memberDto.memberPost}] ${memberDto.memberAddress1}
					${memberDto.memberAddress2}</td>
			</tr>
			<tr>
				<c:if test="${memberDto.memberRank=='학생'}">
				<th>입학일</th>
				</c:if>
				<c:if test="${memberDto.memberRank=='교수'}">
				<th>등록일</th>
				</c:if>
				<c:if test="${memberDto.memberRank=='관리자'}">
				<th>입사일</th>
				</c:if>				
				<td><fmt:formatDate value="${memberDto.memberJoin}" pattern="yyyy-MM-dd E" /></td>
			</tr>
			
		</table>
	</div>

	<!-- 메뉴 배치 -->

	<div class="row float-box center mt-30">
		<a href="join" class="btn btn-positive"><i class="fa-regular fa-square-plus" style="color: white"></i> 회원등록</a>
		<a href="list" class="btn btn-neutral"><i class="fa-solid fa-list" style="color: white"></i> 목록이동</a> 
		<a href="change?memberId=${memberDto.memberId}" class="btn btn-neutral"><i class="fa-solid fa-eraser" style="color: white"></i> 회원수정</a> 
		<a href="delete?memberId=${memberDto.memberId}" class="btn btn-negative confirm-link" 
				data-text="정말 삭제하시겠습니까?"><i class="fa-solid fa-trash" style="color: white"></i> 회원삭제</a>
	</div>
		
	</div>



<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
