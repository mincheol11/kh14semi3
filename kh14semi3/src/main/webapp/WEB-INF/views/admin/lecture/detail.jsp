<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

 <script type="text/javascript">
    function showMessage(message) {
        if (message === 'edit') {
            /* alert('수정이 완료되었습니다.'); */
        } 
    }
    $(document).ready(function() {
        var urlParams = new URLSearchParams(window.location.search);
        var message = urlParams.get('message');
        if (message) {
            showMessage(message); 
        }
    });
    </script>
    
 
    <div class="container w-500 my-50">
	    <div class="row center">
	    	<h1>[ ${lectureDto.lectureName} ] 강의 정보</h1>
	    </div>
	    <c:choose>
	        <c:when test="${lectureDto == null}">
	            <h2>존재하지 않는 강의 정보 입니다.</h2>
	        </c:when>
	    <c:otherwise>
        <table class="table table-border">
                <tr>
                    <th width="30%">강의코드</th>
                    <td>${lectureDto.lectureCode}</td>
                </tr>
                <tr>
                    <th>전공(학과)</th>
                    <td>
                    	${departmentDto.departmentName}
                    	${departmentDto.departmentCode}
                   	</td>
                </tr>
                <tr>
                    <th>교수명</th>
                    <td>${memberDto.memberName}</td>
                </tr>
                <tr>
                    <th>분류</th>
                    <td>${lectureDto.lectureType}</td>
               	</tr>
               	<tr>
                    <th>강의명</th>
                    <td>${lectureDto.lectureName}</td>
                </tr>
                <tr>
                	<th>강의시간</th>
	                <td>
		                ${lectureDto.lectureDay}
		                ${lectureDto.lectureTime}
		                (${lectureDto.lectureDuration}시간)
	                </td>
            	</tr>
                <tr>
                    <th>강의실</th>
                    <td>${lectureDto.lectureRoom}</td>
                </tr>
                <tr>
                    <th>수강인원</th>
                	<td>${lectureDto.lectureRegist}/${lectureDto.lectureCount}</td>
                </tr>
            </table>
        </c:otherwise>
    </c:choose>
    
	<div class="row float-box center mt-30">
		<a href="add" class="btn btn-positive"><i class="fa-regular fa-square-plus"></i> 강의개설</a>
		<a href="list" class="btn btn-neutral"><i class="fa-solid fa-list"></i> 목록이동</a>
		<a href="edit?lectureCode=${lectureDto.lectureCode}" class="btn btn-neutral"><i class="fa-solid fa-eraser"></i> 강의수정</a>
		<a href="remove?lectureCode=${lectureDto.lectureCode}"class="btn btn-negative confirm-link" data-text="정말 삭제하시겠습니까?"  onclick="return checkRemove()">
			<i class="fa-solid fa-trash"></i> 강의삭제</a>
	</div>
</div>    


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->
