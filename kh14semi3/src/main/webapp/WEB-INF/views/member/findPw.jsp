<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<html lang="ko">
<head>
<title>KH 대학교 학사정보 사이트</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap"
	rel="stylesheet">

<!-- my css (절대주소 필수) -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->

<!-- font awesome icon cdn-->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

<!-- 자바스크립트 -->

<!-- moment cdn (시간 관련 js) -->
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>

<!-- jquery cdn -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- my jquery library (무조건 jquery cdn 뒤에 있어야 제대로 돌아간다!)-->
<script src="/js/checkbox.js"></script>
<script src="/js/confirm-link.js"></script>
<script src="/js/multipage.js"></script>

<!-- chart.js cdn -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<!-- swiper cdn -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>


<style>
.success {
	border-color: black;
}
 /* 전체 페이지 스타일 */
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            width: 100%;
            overflow: hidden; /* 스크롤바 제거 */
        }
        body{
        	background-image: url("/images/background_gray.png");
        	background-repeat: no-repeat;
        	background-size: cover;
        	
        }

        .background {
            position: fixed; /* 고정 위치로 설정 */
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            z-index: -1; /* 배경 이미지를 맨 뒤로 보내기 */
            filter: brightness(60%); /* 배경 이미지를 연하게 처리 */
        }

      	.check-form {
            position: relative;
            z-index: 1; /* 로그인 폼이 배경 이미지 위에 오도록 설정 */
            background: rgba(250, 250, 250, 0.5); /* 반투명 배경 */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px; /* 최대 너비 조정 */
            margin: 0 auto; /* 화면 중앙에 폼을 위치시키기 위해 자동 마진 설정 */
            
            margin-top: 150px; /* 상단 여백을 설정하여 화면 중앙에 배치 */
            height: 570px;
        } 
        

        .fail-feedback {
            color: red;
            font-size: 0.875rem;
            margin-top: 0.5rem;
        }

        .btn.btn-positive {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 0.75rem;
            width: 100%;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn.btn-positive:hover {
            background-color: #0056b3;
        }
</style>
</head>
<body>
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
<form action="findPw" method="post" class="check-form">
<div class="container w-400 my-50">
    <div class="row center">
        <h1>비밀번호 찾기</h1>
    </div>
    
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
                <i class="fa-regular fa-envelope"></i>
                <span>비밀번호 재설정 메일 발송</span>
            </button>
        </div>
    
    <c:if test="${param.error != null}">
        <div class="row center">
            <b class="red">아이디 또는 이메일이 일치하지 않습니다</b>
        </div>
    </c:if>
</div>
</form>
</body>
</html>