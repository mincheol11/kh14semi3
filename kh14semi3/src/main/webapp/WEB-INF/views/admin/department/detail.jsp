<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

 <script type="text/javascript">
    function checkDelete(){
        return confirm("정말 삭제하시겠습니까?");
    }

    </script>
    <body>
    <div class="container w-600 my-50">
    <div class="row center">
    <h1>학과 상세정보</h1>
    </div>

    <c:choose>
        <c:when test="${adminDepartmentDto == null}">
            <h2>존재하지 않는 학과 정보 입니다.</h2>
        </c:when>
    <c:otherwise>
        <table class="table table-border table-hover">
                <tr>
                    <th width="30%">학과 코드</th>
                    <td>${adminDepartmentDto.departmentCode}</td>
                </tr>
                <tr>
                    <th>학과명</th>
                    <td>${adminDepartmentDto.departmentName}</td>
                </tr>
                <tr>
                    <th>담당교수</th>
                    <td>(코드추가)</td>
                </tr>
                 <tr>
                    <th>최대인원</th>
                    <td>(코드추가)</td>
                </tr>
            </table>
        </c:otherwise>
    </c:choose>
    
    <!-- 다른 페이지로 이동할 수 있는 링크 -->
     <div class="row center">
    <a href="list" class="btn btn-netraul">목록</a>
    <c:if test="${adminDepartmentDto != null}">
    <a href="edit?departmentCode=${adminDepartmentDto.departmentCode}" class="btn btn-netraul">학과 정보 수정</a>
    <a href="reduce?departmentCode=${adminDepartmentDto.departmentCode}" class="btn btn-netraul" onclick="return checkDelete()">학과 삭제</a>
    </c:if>
</div>
</div>    
</body>


