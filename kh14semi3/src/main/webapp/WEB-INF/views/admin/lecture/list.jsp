<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
		
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

<style>
.kh-container{
    height: auto !important; 
}

</style>


<script type="text/javascript">
function showMessage(message) {
	if (message === 'remove') 
        alert('삭제가 완료되었습니다.');
	}
$(document).ready(function() {
    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');
    if (message) {
        showMessage(message); 
    }
});
</script>

    <div class="container w-900 my-50">
        <div class="row center">
            <h1>강의 시스템 관리</h1>
        </div>
        <div class="row center mt-50">
        <form action="list" method="get" autocomplete="off">
    <div class="row right">
        <div class="row right">
		<a href="add" class="btn btn-positive"><i class="fa-regular fa-square-plus"></i> 강의개설</a>
		</div>
            <select name="column" class="field">
            <option value="lecture_code">강의코드</option>
            
		<c:choose>
			<c:when test="${param.column == 'lecture_department'}">
				<option value="lecture_department" selected>학과코드</option>
			</c:when>
			<c:otherwise>
				<option value="lecture_department">학과코드</option>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${param.column == 'lecture_professor'}">
				<option value="lecture_professor" selected>교수코드</option>
			</c:when>
			<c:otherwise>
				<option value="lecture_professor">교수코드</option>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${param.column == 'lecture_type'}">
				<option value="lecture_type" selected>분류</option>
			</c:when>
			<c:otherwise>
				<option value="lecture_type">분류</option>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${param.column == 'lecture_name'}">
				<option value="lecture_name" selected>강의명</option>
			</c:when>
			<c:otherwise>
				<option value="lecture_name">강의명</option>
			</c:otherwise>
		</c:choose>
		
            </select>
        <input type="text" name="keyword" value="${param.keyword}" class="field w-60">
        <button type="submit" class="btn btn-neutral"><i class="fa-solid fa-magnifying-glass"> 검색</i></button>
			    </div>
        </form>
        </div>
                
    <div class="row">
        <table class="table table-horizontal table-hover">
            <thead>
              <tr>
                    <th>강의코드</th>
                    <th>학과코드</th>
                     <th>교수코드</th>
                    <th>분류</th>
                     <th>강의명</th>
                    <th>강의시작 시간</th>
                    <th>강의수업 시간</th>
                    <th>강의요일</th>
                    <th>강의실</th>
                    <th>정원</th>
                    
                    
                    
             </tr>
    </thead>
	<tbody>
			<c:forEach var="lectureDto" items="${lectureList}">
    			<tr onclick="location.href='detail?lectureCode=${lectureDto.lectureCode}'" style="cursor: pointer;">
    					<td>${lectureDto.lectureCode}</td>
				        <td>${lectureDto.lectureDepartment}</td>
				        <td>${lectureDto.lectureProfessor}</td>
				        <td>${lectureDto.lectureType}</td>
				        <td>${lectureDto.lectureName}</td>
				        <td>${lectureDto.lectureTime}</td>
				        <td>${lectureDto.lectureDuration}</td>
				        <td>${lectureDto.lectureDay}</td>
				        <td>${lectureDto.lectureRoom}</td>
				        <td>${lectureDto.lectureCount}</td>
    				</tr>
				</c:forEach>
			</tbody>
		</table>
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include> <!-- navigator 추가 -->
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->