<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

  <script type="text/javascript">
  </script>

 <form action="edit" method="post" autocomplete="off">
	<div class="container w-400 my-50">
            <div class="row center">
                <h2>학과 상세정보 수정</h2>
            </div>
            	<div class="row">
                <label>학과코드</label>
                <input type="text" name="departmentCode" class="field w-100" >   
            </div>
	<div class="row">
                <label>학과명</label>
                <input type="text" name="departmentName" class="field w-100" >   
            </div>
			 <div class="row mt-40">
                <button class="btn btn-positive w-100" >수정하기</button>
            </div>
	</div>
</form>

