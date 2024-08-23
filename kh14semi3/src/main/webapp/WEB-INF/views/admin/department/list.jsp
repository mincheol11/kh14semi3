<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
		
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

<script type="text/javascript">
$(document).ready(function() {
    $('tr').on('click', function() {
        var departmentCode = $(this).data('departmentCode');
        if (departmentCode) {
            window.location.href = 'detail?departmentCode=' + departmentCode;
        }
    });
});
</script>

    <div class="container w-600 my-50">
        <div class="row center">
            <h1>학과 시스템 관리</h1>
        </div>
    <div class="row center">
        <form action="list" method="get" autocomplete="off">
        <div class="row right">
		<a href="expand" class="btn btn-neutral w-20">학과개설</a>
		</div>
            <select name="column" class="field">
               <option value="department_name" ${param.column == 'department_name' ? 'selected' : ''}>학과명</option>
                <option value="major_courses" ${param.column == 'major_courses' ? 'selected' : ''}>전공수업</option>
                <option value="professor" ${param.column == 'professor' ? 'selected' : ''}>담당교수</option>
            </select>
        <input type="text" name="keyword" value="${param.keyword}" class="field w-60">
        <button type="submit" class="btn btn-positive w-20"><i class="fa-solid fa-magnifying-glass">검색</i></button>
          
        </form>
    </div>
                
    <div class="row">
        <table class="table table-horizontal table-hover">
            <thead>
              <tr>
                    <th hidden>학과코드</th>
                    <th>학과명</th>
                    <th>전공수업</th>
                    <th>담당교수</th>
                    <th>모집인원</th>
             </tr>
    </thead>
	<tbody>
			<c:forEach var="adminDepartmentDto" items="${adminDepartmentList}">
    			<tr onclick="location.href='detail?departmentCode=${adminDepartmentDto.departmentCode}'" style="cursor: pointer;">
				        <td hidden>${adminDepartmentDto.departmentCode}</td>
				        <td>${adminDepartmentDto.departmentName}</td>
				        <td></td>
				        <td></td>
				        <td></td>
    				</tr>
				</c:forEach>
			</tbody>
		</table>
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include> <!-- navigator 추가 -->
	</div>
</div>