<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <script type="text/javascript">
	$(function(){
		//상태 객체
		var status = {
			memberPwValid : false,
			memberPwCheckValid : false,
			ok : function(){
				return this.memberPwValid && this.memberPwCheckValid;
			}
		};
		
		//비밀번호 형식검사
		$("[name=memberPw]").blur(function(){
			var memberPw= $(this).val();
			var regex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
			status.memberPwValid = regex.test(memberPw);
			$(this).removeClass("success fail").addClass(status.memberPwValid ? "success" : "fail");
		});
		//비밀번호 확인 검사
		$("#password-check").blur(function(){
			var memberPw = $("[name=memberPw]").val();
			var memberPwCheck = $(this).val();
			status.memberPwCheckValid = memberPw.length > 0 && memberPw == memberPwCheck;
			$(this).removeClass("success fail").addClass(status.memberPwCheckValid ? "success" : "fail");
		});
		//form 검사
		$(".check-form").submit(function(){
			$("[name=memberPw]").trigger("blur");
			$("#password-check").trigger("blur");
			return status.ok();
		});
	});
</script>

<div class="container w-600 my-50">
	<div class="row center">
		<h1>비밀번호 재설정</h1>
	</div>
	
	<form action="resetPw" method="post" autocomplete="off" class="check-form">
		<input type="hidden" name="certEmail" value="${certDto.certEmail}">
		<input type="hidden" name="certNumber" value="${certDto.certNumber}">
		<input type="hidden" name="memberId" value="${memberId}">
	
		<div class="row">
			<label>변경할 비밀번호</label>
			<input type="password" name="memberPw" class="field w-100">
			<div class="success-feedback">형식에 맞는 비밀번호입니다</div>
			<div class="fail-feedback">영문 대소문자, 숫자, 특수문자를 포함한 8~16자로 작성하세요</div>
		</div>
		<div class="row">
			<label>비밀번호 확인</label>
			<input type="password" id="password-check" class="field w-100">
			<div class="success-feedback">비밀번호가 일치합니다</div>
			<div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
		</div>
		<div class="row mt-30">
			<button type="submit" class="btn btn-positive w-100">
				<i class="fa-solid fa-lock"></i>
				변경하기
			</button>
		</div>
	</form>
</div>