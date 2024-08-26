<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

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
		
	// 코드 입력창 검사
	  $("[name=departmentCode]").blur(function(){
		var regex= /^[d][0-9]{2,3}$/;//형식검사
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
						}
						else{
	                        status.departmentCodeCheckValid=false;
	                        $("[name=departmentCode]").removeClass("success fail fail2")
	                        .addClass("fail2");
	                    }
					},
				});
			}
	 		 else{
	     			 $("[name=departmentCode]").removeClass("success fail fail2")
	      			.addClass("fail");
	  			}
	  			status.departmentCodeValid = isValid;
		});
		
	  //학과명 입력창 검사
				$("[name=departmentName]").blur(function(){
					var regex= /^[가-힣]{2,20}$/;//형식검사
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
									}
									else{
				                        status.departmentNameCheckValid=false;
				                        $("[name=departmentName]").removeClass("success fail fail2")
				                        .addClass("fail2");
				                    }
								},
							});
						}
				 		 else{
				     			 $("[name=departmentName]").removeClass("success fail fail2")
				      			.addClass("fail");
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
                <h1>학과 증설</h1>
            </div>
 <!-- 학과 코드 입력 -->               
			<div class="row">
                <label>학과 코드<i class="fa-solid fa-asterisk"></i></label>
                    <input type="text" name="departmentCode" 
                        class="field w-100" placeholder="ex)d01">
                <div class="success-feedback 00b894">올바른 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 'd'로 시작하며,다음 숫자를 2~3자로 작성해주세요.</div>
                <div class="fail2-feedback d63031">이미 사용중인 코드입니다</div>
			</div>
<!-- 학과명 입력 -->
			<div class="row">
                <label>학과명 <i class="fa-solid fa-asterisk"></i></label>
                      <input type="text" name="departmentName" 
                        class="field w-100" placeholder="ex)세무회계과">
 				<div class="success-feedback 00b894">올바른 학과명입니다.</div>
                <div class="fail-feedback d63031">학과명은 한글로만 입력해주세요.</div>
                <div class="fail2-feedback d63031">이미 사용중인 학과명입니다</div>
                </div>
<!-- 전송버튼 -->
            <div class="row">
                <button type="submit" class="btn btn-positive w-100" >
                   <i class="fa-solid fa-landmark"></i>
                   학과개설
                </button>
            </div>
        </div>
    </form>

