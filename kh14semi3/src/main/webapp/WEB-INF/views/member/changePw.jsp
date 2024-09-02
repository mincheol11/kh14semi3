<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
    $(function(){
        // 비밀번호 찾기 페이지에서 사이드바 안나오게 하기
        $(document).ready(function(){
        	$(".profile").css("display","none");
        });
        var status = {
            memberIdValid: false,
            memberEmailValid: false,
            ok: function(){
                return this.memberIdValid && this.memberEmailValid;
            },
        };

        // 아이디 형식 검사
        $("[name=memberId]").blur(function(){
            var regex = /^.+$/; // 값이 존재하는지 검사
            var memberId = $(this).val();
            var isValid = regex.test(memberId);
            if(isValid) {
                status.memberIdValid = true;
                $(this).removeClass("success fail").addClass("success");
            } else {
                status.memberIdValid = false;
                $(this).removeClass("success fail").addClass("fail");
            }
        });

        // 이메일 형식 검사
        $("[name=memberEmail]").blur(function(){
            var regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/; // 간단한 이메일 형식 검사
            var isValid = regex.test($(this).val());
            $(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
            status.memberEmailValid = isValid;
        });

        // 폼 제출 시 검증
        $(".check-form").submit(function(event){
            if (!status.ok()) {
                alert("모든 필드를 올바르게 입력하세요.");
                event.preventDefault(); // 폼 제출을 막음
                return false;
            }
            var btn = $(this).find("button[type=submit]");
            btn.find("i").addClass("fa-bounce");
            return true;
        });
        
        
    });
</script>

<div class="container w-400 my-50">
    <div class="row center">
        <h1>비밀번호 변경</h1>
    </div>
    
    <form action="changePw" method="post" class="check-form">
        <div class="container w-400 my-0">
            <label>아이디</label>
            <input type="text" name="memberId" class="field w-100" required>
            <div class="fail-feedback">아이디를 입력하세요</div>
        </div>
        <div class="container w-400 my-10">
            <label>이메일</label>
            <input type="email" name="memberEmail" class="field w-100" required>
            <div class="fail-feedback">유효한 이메일을 입력하세요</div>
        </div>
        <div class="container w-400 my-0">
            <button type="submit" class="btn btn-positive w-100">
                <i class="fa-regular fa-envelope" style="color: white"></i>
                <span style="color: white">비밀번호 변경 메일 발송</span>
            </button>
        </div>
        <div class="container w-400 my-10">
        	<a class="btn btn-positive w-100" href="/home/main">뒤로가기</a>
        </div>
    </form>
    
    <c:if test="${param.error != null}">
        <div class="row center">
            <b class="red">아이디 또는 이메일이 일치하지 않습니다</b>
        </div>
    </c:if>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
