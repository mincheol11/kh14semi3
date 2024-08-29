<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix= "c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
	$(function() {
		var status = {
			memberIdValid : false, //형식검사
			memberPwValid : false,
			ok : function() {
				return this.memberIdValid && this.memberPwValid;
			},
		};
		//입력창 검사
		$("[name=memberId]").blur(
				function() {
					//step 1 : 아이디에 대한 형식 검사
					var regex = /^.+$/;
					var memberId = $(this).val();//this.value
					var isValid = regex.test(memberId);
					if (isValid) {
						status.memberIdCheckValid = true;
						$("[name=memberId]").removeClass("success fail fail2")
								.addClass("success");
					} else {//.fail - 아이디가 형식에 맞지 않는 경우
						status.memberIdCheckValid = false;
						$("[name=memberId]").removeClass("success fail fail2")
								.addClass("fail");
					}
					status.memberIdValid = isValid;
				});

		   $("[name=memberPw]").blur(function(){
               var regex = /^.+$/;
               var isValid = regex.test($(this).val());
               $(this).removeClass("success fail")
                           .addClass(isValid ? "success" : "fail");
               status.memberPwValid = isValid;
           });

		//폼 검사
		$(".check-form").submit(function() {
			$("[name]").trigger("input").trigger("blur");
			return status.ok();
		});

	});
</script>


<form action="login" method="post" autocomplete="off" class="check-form">
    <div class="container w-400 my-50">
    	<div class="row center">
    		<h1>Kh 대학교 로그인</h1>
    	</div>
    	<div class="row">
    		<label>아이디</label> 
    		<input type="text" name="memberId" class="field w-100"
    																		  value="${cookie.saveId.value}">
    																		  
                        <div class="fail-feedback">아이디를 입력하세요</div>
    	</div>
    	
		<div class="row mb-0">
			<label>비밀번호</label> <input type="password" name="memberPw" class="field w-100">
                        <div class="fail-feedback">비밀번호를 입력하세요</div>
		</div>
		
		<div class="row flex-box column-2 my-0">
		<div class="row left">
		<label>
			<input type="checkbox" name="remember" 
					<c:if test="${cookie.saveId != null}">checked</c:if>>
				<span>아이디 저장하기</span>
		</label>
		</div>
		<!-- 비밀번호 찾기링크 -->
		<div class="row right">
			<a href="findPw">비밀번호 재설정</a>
		</div>
		</div>

		<div>
			<button class="btn btn-positive w-100" >로그인</button>
		</div>
		
		<c:if test="${param.error != null}">
			<div class="row center">
				<h3 style="color: red">아이디 또는 비밀번호가 잘못되었습니다</h3>
			</div>
		</c:if>
	</div>
</form>
 

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>