<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

 <script type="text/javascript">
 function showMessage(message) {
     if (message === 'edit') 
         alert('수정이 완료되었습니다.');
 }

 $(document).ready(function() {
     var urlParams = new URLSearchParams(window.location.search);
     var message = urlParams.get('message');
     if (message) {
         showMessage(message); 
     }
 });
    </script>
    
    <body>
    <div class="container w-600 my-50">
  
    <c:choose>
        <c:when test="${departmentDto == null}">
        <div class="row center">
            <h1>존재하지 않는 학과 정보 입니다.</h1>
            </div>
        </c:when>
    <c:otherwise>
      <div class="row center my-50">
    <h1>학과 상세정보</h1>
    </div>
        <table class="table table-border table-hover">
                <tr>
                    <th width="30%">학과코드</th>
                    <td>${departmentDto.departmentCode}</td>
                </tr>
                <tr>
                    <th>학과명</th>
                    <td>${departmentDto.departmentName}</td>
                </tr>
            </table>
        </c:otherwise>
    </c:choose>
    
     <div class="row float-box">
     	<div class="float-right">
		     <a href="expand" class="btn btn-positive"><i class="fa-solid fa-building-columns"></i> 학과개설</a>
		    <a href="list" class="btn btn-neutral"><i class="fa-solid fa-list"></i> 목록이동</a>
		    <a href="edit?departmentCode=${departmentDto.departmentCode}" class="btn btn-neutral"><i class="fa-solid fa-eraser"></i> 학과수정</a>
		    <a href="reduce?departmentCode=${departmentDto.departmentCode}"class="btn btn-negative confirm-link" 
		    	data-text="정말 삭제하시겠습니까?" onclick="return checkReduce()"><i class="fa-solid fa-trash"></i> 학과삭제</a>
    	</div>
	</div>
</div>    
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->
