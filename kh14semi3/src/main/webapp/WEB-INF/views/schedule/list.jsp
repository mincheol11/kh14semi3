<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 <script type="text/javascript">
 $(function(){
	    $("#move_month > i").click(function(){
	        let url = $(this).parent().attr("data-url");
	        let action = $(this).parent().attr("data-action");

	        let date = $(this).siblings("h2").html();
	        let year = parseInt(date.split(".")[0]);
	        let month = parseInt(date.split(".")[1]) - 1;

	        date = ($(this).attr("id") == "before_month") ? new Date(year, month - 1) : new Date(year, month + 1);
	        year = date.getFullYear();
	        month = date.getMonth() + 1;

	        let form = $("<form></form>");
	        form.attr("method", action);
	        form.attr("action", url);
	        form.append($("<input/>", {type:"hidden", name:"year", value:year}));
	        form.append($("<input/>", {type:"hidden", name:"month", value:month}));
	        form.appendTo("body");
	        form.submit();
	    });
	});
 
 
 </script>


<div class="container w-800 my-50">
    
    <div class="row left">
    <h1>학사 일정</h1>
    </div>
    
    <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
     <c:set var="isLogin" value="${sessionScope.createdUser != null}" />
      
      
    <c:if test="${isLogin && isAdmin}">
    <div class="row right">
    <a href="add" class="btn btn-neutral">신규등록</a>
    </div>
    </c:if>
    <div class="row">
    <table class="table table-border table-hover w-800">
	<thead>
		<tr>
		<th>작성일</th>
		<th>제목</th>
		</tr>
	</thead>
	<tbody align="center">
		<c:forEach var="scheduleDto" items="${scheduleList}">
		<tr>
		<td>${scheduleDto.scheduleWtime }</td>
		<td  align="right">
			<!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
				<a href="detail?scheduleNo=${scheduleDto.scheduleNo}">${scheduleDto.scheduleTitle} </a>
				
			</td>
			
			</tr>
		</c:forEach>
		
	</tbody>
</table>
    </div>
    </div>