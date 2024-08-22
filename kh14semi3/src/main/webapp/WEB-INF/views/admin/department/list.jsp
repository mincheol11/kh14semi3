<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			
<script type="text/javascript">
$(function(){

});
</script>

    <div class="container w-600 my-50">
        <div class="row center">
            <h1>학과 시스템 관리</h1>
        </div>
        <div class="row right">
            <a href="expand" class="btn btn-neutral">학과 증설</a>
        </div>

    <div class="row center">
        <form action="list" method="get" autocomplete="off">
            <select name="column" class="field">
                <option value="department_name">학과명</option>
                <option value="#">전공수업</option>
                <option value="#">담당교수</option>
            </select>
        <input type="text" name="keyword" value="${keyword}" class="field">
        <button type="submit" class="btn btn-positive"><i class="fa-solid fa-magnifying-glass">검색</i></button>
        </form>
    </div>
                
    <div class="row">
        <table class="table table-border table-hover">
            <thead>
                <tr>
                    <th>학과코드</th>
                    <th>학과명</th>
                    <th>전공수업</th>
                    <th>담당교수</th>
                </tr>
            </thead>
       <div class="row right">
			<tbody>
               <tr onclick="location.href='detail?departmnetCode=${adminDepartmentDto.departmentCode}'" style="cursor: pointer;">
                   <td>${dto.departmentCode}</td>
                   <td>${dto.departmentName}</td>
                   <td>경영학과(가제)</td>
                   <td>박철수(가제)</td>
                </tr>
			</tbody>
        </div>
        
		</table>
      </div>











