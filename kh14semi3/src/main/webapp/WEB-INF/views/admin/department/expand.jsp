<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	  departmentCodeValid : false, departmentCodeCheckValid:false,
	  departmentNameValid : false, departmentNameCheckValid:false,
	  ok : function(){
		return this.departmentCodeValid && this.departmentNameValid 
		&& this.departmentCodeCheckValid && this.departmentNameCheckValid
		},
	};
		
	// 학과 코드 입력창 검사
	  $("[name=departmentCode]").blur(function(){
		var regex= /^.+$/;//형식검사
		var departmentCode = $(this).val();
		var isValid= regex.test(departmentCode);
		if(isValid){//중복검사
				$.ajax({
					url:"/rest/admin/department/checkDepartmentCode",
					method:"post",
					data:{departmentCode:departmentCode},
					success:function(response){
						if(response){
							status.departmentCodeCheckValid=true;
							$("[name=departmentCode]").removeClass("success fail fail2")
							.addClass("success");
							$("[name=departmentCode]").parent().find("label").find("i").removeClass("red fa-bounce");
							$("[name=departmentCode]").parent().find("label").find("i").addClass("green fa-beat");
						}
						else{
	                        status.departmentCodeCheckValid=false;
	                        $("[name=departmentCode]").removeClass("success fail fail2")
	                        .addClass("fail2");
	                        $("[name=departmentCode]").parent().find("label").find("i").removeClass("green fa-beat");
	                        $("[name=departmentCode]").parent().find("label").find("i").addClass("red fa-bounce");
	                    }
					},
				});
			}
	 		 else{
	     			 $("[name=departmentCode]").removeClass("success fail fail2")
	      			.addClass("fail");
	     			$("[name=departmentCode]").parent().find("label").find("i").removeClass("green fa-beat");
	     			$("[name=departmentCode]").parent().find("label").find("i").addClass("fa-bounce");
	  			}
	  			status.departmentCodeValid = isValid;
		});
		
	  //학과명 입력창 검사
				$("[name=departmentName]").on("input", function(){
					var regex= /^.+$/;//형식검사
					var departmentName = $(this).val();
					var isValid= regex.test(departmentName);
					if(isValid){//중복검사
							$.ajax({
								url:"/rest/admin/department/checkDepartmentName",
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

 <form action="expand" method="post" autocomplete="off" class="check-form">
        <div class="container w-400 my-50">
            <div class="row center">
                <h1>학과 개설</h1>
            </div>
 <!-- 학과 코드 입력 -->               
			<div class="row">
                <label>학과코드 <i class="fa-solid fa-asterisk red"></i></label>
                    <input type="text" name="departmentCode" 
                        class="field w-100" placeholder="ex)KHD01001">
                <div class="success-feedback 00b894">올바른 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 영문 대문자와 숫자로 작성해주세요.</div>
                <div class="fail2-feedback d63031">이미 사용중인 코드입니다</div>
			</div>
<!-- 학과명 입력 -->
			<div class="row">
                <label>학과명 <i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="departmentName" 
                        class="field w-100" placeholder="ex)기계공학과">
 				<div class="success-feedback 00b894">올바른 학과명입니다.</div>
                <div class="fail-feedback d63031">학과명은 한글로만 입력해주세요.</div>
                <div class="fail2-feedback d63031">이미 사용중인 학과명입니다</div>
                </div>
<!-- 전송버튼 -->
            <div class="row">
                <button type="submit" class="btn btn-positive w-100 mt-30" >
                  <i class="fa-solid fa-building-columns"></i> 학과개설
                </button>
                <div class="row">
                	<a href="list" class="btn btn-neutral w-100" >
                   <i class="fa-solid fa-list" style="color: white"></i> 목록이동
                </a>
                </div>
            </div>
        </div>
    </form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->