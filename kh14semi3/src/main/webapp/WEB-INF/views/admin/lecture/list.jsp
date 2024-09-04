<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
		
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

<style>

</style>


<script type="text/javascript">
function showMessage(message) {
	if (message === 'remove') 
		loadCheck();
	}
$(document).ready(function() {
    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');
    if (message) {
        showMessage(message); 
    }
});
function loadCheck() {
	 Swal.fire({
     icon: 'success',
     iconColor: "#6695C4",
     title: '삭제 완료.',
     showConfirmButton: false,
     timer: 1500         
	 });
};	
</script>

    <div class="container w-1000 my-50">
        <div class="row center">
            <h1>강의 시스템 관리</h1>
        </div>

        <div class="row center">
        	<form action="list" method="get" autocomplete="off">
            	<!-- 검색창 --> 
				<select class="field" name="column">
					<option value="department_name" <c:if test="${param.column == 'department_name'}">selected</c:if>>전공(학과)</option>
					<option value="member_name" <c:if test="${param.column == 'member_name'}">selected</c:if>>교수명</option>
					<option value="lecture_type" <c:if test="${param.column == 'lecture_type'}">selected</c:if>>분류</option>
					<option value="lecture_name" <c:if test="${param.column == 'lecture_name'}">selected</c:if>>강의명</option>
				</select>
        		<input type="search" name="keyword" value="${param.keyword}" class="field" placeholder="검색어">
        		<button class="btn btn-positive" type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
				<a href="add" class="btn btn-neutral"><i class="fa-regular fa-square-plus"></i> 강의개설</a>
        	</form>
        </div>
                
    <div class="row">
        <table class="table table-horizontal table-hover w-100">
            <thead>
              <tr>
                    <th>강의코드</th>
                    <th>전공(학과)</th>
                     <th>교수명</th>
                    <th>분류</th>
                     <th>강의명</th>
                    <th>시작시간</th>
                    <th>수업시간</th>
                    <th>강의요일</th>
                    <th>강의실</th>
                    <th>정원</th>
             </tr>
    </thead>
	<tbody>
			<c:forEach var="lectureMemberVO" items="${lectureList}">
    			<tr onclick="location.href='detail?lectureCode=${lectureMemberVO.lectureCode}'" style="cursor: pointer;">
    					<td>${lectureMemberVO.lectureCode}</td>
				        <td>${lectureMemberVO.departmentName}</td>
				        <td>${lectureMemberVO.memberName}</td>
				        <td>${lectureMemberVO.lectureType}</td>
				        <td>${lectureMemberVO.lectureName}</td>
				        <td>${lectureMemberVO.lectureTime}</td>
				        <td>${lectureMemberVO.lectureDuration}</td>
				        <td>${lectureMemberVO.lectureDay}</td>
				        <td>${lectureMemberVO.lectureRoom}</td>
				        <td>${lectureMemberVO.lectureCount}</td>
    				</tr>
				</c:forEach>
			</tbody>
		</table>
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include> <!-- navigator 추가 -->
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->