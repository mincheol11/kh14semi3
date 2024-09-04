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

<script type="text/javascript">
	$(function(){
		var params = new URLSearchParams(location.search);
		var goWhere = params.get("goWhere");
		$(".btn-go-where").on("click",function(){
			if(goWhere == 'regist1'){
				$(this).attr("href", "/registration/list");
			}
			else if(goWhere == 'regist2'){
				$(this).attr("href", "/registration/regist");
			}
			else{
				$(this).attr("href", "/lecture/list");
			}
		});		
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
	<div class="row">
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
            <tr>
                <th>강의계획서</th>
                <td class="center">	                
	                <img src="https://placehold.co/200x200">
                </td>
            </tr>
        </table>
    </div>
    </c:otherwise>
    </c:choose>

    <div class="row float-box center mt-30">
        	<a href="/lecture/list" class="btn btn-neutral btn-go-where">
        	<i class="fa-solid fa-list"></i> 목록이동</a>
    </div>

</div>


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
