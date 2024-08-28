<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
		
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

<script type="text/javascript">

function showMessage(message) {
if (message === 'reduce') 
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

    <div class="container w-700 my-50">
        <div class="row center">
            <h1>학과 시스템 관리</h1>
        </div>
    <div class="row center">
        <form action="list" method="get" autocomplete="off">
        <div class="row right">
		<a href="expand" class="btn btn-neutral w-20">학과개설</a>
		</div>
		<div class="row right">
            <select name="column" class="field">
            <option value="department_code">학과코드</option>
		<c:choose>
			<c:when test="${param.column == 'department_name'}">
				<option value="department_name" selected>학과명</option>
			</c:when>
			<c:otherwise>
				<option value="department_name">학과명</option>
			</c:otherwise>
		</c:choose>
            </select>
        <input type="text" name="keyword" value="${param.keyword}" class="field w-60">
        <button type="submit" class="btn btn-positive w-20"><i class="fa-solid fa-magnifying-glass">검색</i></button>
            </div>
        </form>
    </div>
                
    <div class="row">
        <table class="table table-horizontal table-hover">
            <thead>
              <tr>
                    <th>학과코드</th>
                    <th>학과명</th>
             </tr>
    </thead>
	<tbody>
			<c:forEach var="departmentDto" items="${departmentList}">
    			<tr onclick="location.href='detail?departmentCode=${departmentDto.departmentCode}'" style="cursor: pointer;">
				        <td>${departmentDto.departmentCode}</td>
				        <td>${departmentDto.departmentName}</td>
    				</tr>
				</c:forEach>
			</tbody>
		</table>

		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include> <!-- navigator 추가 -->
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->