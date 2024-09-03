<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>	
	.class-regist{
		cursor: pointer;
	}
	/* .kh-container{
	    height: auto !important; 
	} */
</style>

<script type="text/javascript">
	$(function(){
		$(".class-regist").each(function() {
	        var lectureCode = $(this).parent().find(".lecture-code").text();
	        var btn = $(this);

	        $.ajax({
	            url: "/rest/registration/check",
	            method: "post",
	            data: {lectureCode: lectureCode},
	            success: function(response) {
	                if (!response.checked) {
	                    // 이미 수강신청이 취소된 경우
	                    $(btn).removeClass("class-regist link link-animation");
	                    $(btn).off("click");
	                    $(btn).css("cursor", "not-allowed").css("text-decoration-line", "none"); // 클릭할 수 없도록 커서 스타일 변경
	                    $(btn).attr("title", "수강신청 취소 완료"); // 마우스 오버 시 메시지 표시
	                }
	                // 수강신청 취소 상태가 아닐 경우에는 기본 상태를 유지
	            }
	        });
	    });
	});
</script>

<c:if test="${sessionScope.createdRank == '학생'}">
<script type="text/javascript">
	// (회원전용) 강의명을 누르면 수강 신청 취소 처리를 수행	
	$(function(){
		$(".class-regist").on("click",function(e){
			var lectureCode = $(this).parent().find(".lecture-code").text();
			var btn = this;
			e.stopPropagation();
			$.ajax({
				url: "/rest/registration/regist",
				method: "post",
				data: {lectureCode : lectureCode},
				success: function(response){
					if(!response.checked){						
						// 너의 수강신청목록에 이거 넣었어 라는 문구 출력
						window.alert("수강 신청 취소!");
						$(btn).removeClass("class-regist link link-animation");
						$(btn).off("click");
	                    $(btn).css("cursor", "not-allowed").css("text-decoration-line", "none"); // 클릭할 수 없도록 커서 스타일 변경
	                    $(btn).attr("title", "수강신청 취소 완료"); // 마우스 오버 시 메시지 표시
	                    $(btn).parent("tr").hide();
					}					
					$(btn).parent().find(".lecture-count").text(response.count);
				}
			});
		});
	});
</script>
</c:if>

<%-- createdUser = ${sessionScope.createdUser} , 
createdLevel = ${sessionScope.createdRank}
	
<a href="list" class="btn btn-neutral">이동</a> --%>

<div class="container w-900 my-50">
	<div class="row center">
        <h1>${sessionScope.createdUser}님의 수강 신청 목록</h1>        
    </div>
    
    <div class="row center">
		<c:choose>
	    <c:when test="${RegistrationList.isEmpty()}">
			<h2>수강 신청한 강의가 없습니다</h2>
	    </c:when>
    	<c:otherwise>
    		<div class="right">
				<i class="fa-brands fa-slack red"></i> 강의명 클릭시 수강신청 취소 가능
			</div>
			<table class="table table-hover table-horizontal">
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
                <tbody>
					<c:forEach var="lectureDto" items="${RegistrationList}">
                    <tr onclick="location.href='/lecture/detail?lectureCode=${lectureDto.lectureCode}&&goWhere=regist2'" style="cursor: pointer;">
						<td>${lectureDto.lectureCode}</td>	                        
                        <td>${lectureDto.lectureProfessor}</td>
						<td>${lectureDto.lectureType}</td>
						<td>${lectureDto.lectureName}</td>
						<td class="lecture-code">${lectureDto.lectureCode}</td>
						<td>${lectureDto.lectureTime} ${lectureDto.lectureDuration} ${lectureDto.lectureDay}</td>
						<td>${lectureDto.lectureRoom}</td>
						<td>
							<span class="lecture-count">${lectureDto.lectureRegist}</span>
							/${lectureDto.lectureCount}
						</td>		
						<td class="link link-animation class-regist">
							수강취소
						</td>
                    </tr>
                    </c:forEach>
                </tbody>
			</table>
        </c:otherwise>
        </c:choose>
    </div>		
</div>


<%-- navigator.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
