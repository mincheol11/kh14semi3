<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->
<style>
.red.bounce {
	color: red;
	animation: bounce 0.1s ease-in-out infinite;
	}
.green.beat {
	color: green;
	animation: beat 0.1s ease-in-out infinite;
	}
</style>

  <script type="text/javascript">
  $(function(){
		//상태 객체
	  var status ={
	  departmentNameValid : false, departmentNameCheckValid:false,
	  ok : function(){
		return this.departmentNameValid && this.departmentNameCheckValid
		},
	};
	//학과명 입력창 검사
		$("[name=departmentName]").on("input", function(){
			var regex= /^[가-힣]{2,20}$/;//형식검사
			var departmentName = $(this).val();
			var isValid= regex.test(departmentName);
			if(isValid){//중복검사
					$.ajax({
						url:"${pageContext.request.contextPath}/rest/admin/department/checkDepartmentName",
						method:"post",
						data:{departmentName:departmentName},
						success:function(response){
							if(response){
								status.departmentNameCheckValid=true;
								$("[name=departmentName]").removeClass("success fail fail2")
								.addClass("success");
								$("[name=departmentName]").parent().find("label").find("i").removeClass("fa-bounce");
								$("[name=departmentName]").parent().find("label").find("i").addClass("green fa-beat");
							}
							else{
		                        status.departmentNameCheckValid=false;
		                        $("[name=departmentName]").removeClass("success fail fail2")
		                        .addClass("fail2");
		                        $("[name=departmentName]").parent().find("label").find("i").removeClass("green fa-beat");
		                        $("[name=departmentName]").parent().find("label").find("i").addClass("fa-bounce");
		                    }
						},
					});
				}
		 		 else{
		     			 $("[name=departmentName]").removeClass("success fail fail2")
		      			.addClass("fail");
		     			$("[name=departmentName]").parent().find("label").find("i").removeClass("green fa-beat");
		     			$("[name=departmentName]").parent().find("label").find("i").addClass("fa-bounce");
		  			}
		  			status.departmentNameValid = isValid;
		});
	//단축키 폼 검사
      $(".check-form").submit(function(){
          $("[name]").trigger("input").trigger("blur");
          return status.ok();
      });
      //엔터 차단 코드
      $(".check-form").find(".field").keypress(function(e){
          switch(e.keyCode){
              case 13 : return false; 
          }
      });
});		
  </script>

 <form action="edit" method="post" autocomplete="off" class="check-form">
	<div class="container w-400 my-50">
		<div class="row center">
			<h1>학과 정보 수정</h1>
		</div>
            
		<div class="row">
			<label>학과코드</label>
				<input type="hidden" name="departmentCode" value="${departmentDto.departmentCode}">
				<div class="field w-100">${departmentDto.departmentCode}</div>
		</div>
		     	
		<!-- 학과명 입력 -->
		<div class="row">
			<label>학과명 <i class="fa-solid fa-asterisk red"></i></label>
			<input type="text" name="departmentName"  value="${departmentDto.departmentName}"
                        class="field w-100" placeholder="ex)기계공학과">
				<div class="success-feedback 00b894">올바른 학과명입니다.</div>
                <div class="fail-feedback d63031">학과명은 한글로만 입력해주세요.</div>
                <div class="fail2-feedback d63031">이미 사용중인 학과명입니다</div>
		</div>
		
		<div class="row mt-30">
			<button class="btn btn-positive w-100 confirm-link" data-text="정말 수정하시겠습니까?">
							<i class="fa-solid fa-eraser"></i> 수정하기</button>
		</div>
		<div class="row">
			<a href="detail?departmentCode=${departmentDto.departmentCode}" class="btn btn-neutral w-100" >
                   <i class="fa-solid fa-arrow-rotate-left"></i> 뒤로가기</a>
		</div>
		
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->
