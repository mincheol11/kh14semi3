<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

  <script type="text/javascript">
  </script>

 <form action="expand" method="post" autocomplete="off">
        <div class="container w-400 my-50">
            <div class="row center">
                <h1>학과 증설</h1>
            </div>

 <!-- 학과 코드 입력 -->               
                <label>코드설정 <i class="fa-solid fa-asterisk"></i></label>
                   <input type="text" name="departmentCode" 
                        class="field w-100" onblur="checkdepartmentCode();">
                <div class="success-feedback 00b894">선택 완료</div>
                <div class="fail-feedback d63031">선택하세요</div>

<!-- 학과명 입력 -->
                <label>학과명 <i class="fa-solid fa-asterisk"></i></label>
                      <input type="text" name="departmentName" 
                        class="field w-100" onblur="checkdepartmentName();">
 				<div class="success-feedback 00b894">선택 완료</div>
                <div class="fail-feedback d63031">선택하세요</div>
<!-- 전송버튼 -->
            <div class="row">
                <button type="submit" class="btn btn-positive w-100">
                   <i class="fa-solid fa-landmark"></i>
                   학과개설
                </button>
            </div>
        </div>
    </form>

