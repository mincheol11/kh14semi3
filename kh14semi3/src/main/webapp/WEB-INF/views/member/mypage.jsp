<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.kh-container{
    height: auto !important; 
}
</style>

<div class="container w-500 my-50">
	<div class="row center">
		<h1>내 정보</h1>
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
				<th>학적상태</th>
				<c:if test="${lastDto.takeOffType == null}"><td>재학</td></c:if>
				<c:if test="${lastDto.takeOffType != null}"><td>${lastDto.takeOffType}</td></c:if>
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
							<td>${sdDto.departmentName} ${sdDto.departmentCode}</td>
						</tr>
					</c:when>
 					<c:when test="${memberDto.memberRank=='교수'}">
 						<tr>
 							<th>학과</th>
 							<td>${pdDto.departmentName} ${pdDto.departmentCode}</td>
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
	
	<div class="row right">
		<a href="edit?memberId=${memberDto.memberId}" class="btn btn-neutral ms-10"><i class="fa-solid fa-eraser"></i> 내 정보 수정</a> 
	</div>
	
</div>





<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>