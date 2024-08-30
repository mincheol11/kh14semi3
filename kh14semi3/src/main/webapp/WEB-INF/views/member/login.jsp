<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix= "c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="ko">
<head>
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
        	background-image: url("/images/loginpage.png");
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
            background: rgba(250, 250, 250, 0); /* 반투명 배경 */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px; /* 최대 너비 조정 */
            margin: 0 auto; /* 화면 중앙에 폼을 위치시키기 위해 자동 마진 설정 */
            
            margin-top: 100px; /* 상단 여백을 설정하여 화면 중앙에 배치 */
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

		$("[name=memberPw]").blur(
				function() {
					var regex = /^.+$/;
					var isValid = regex.test($(this).val());
					$(this).removeClass("success fail").addClass(
							isValid ? "success" : "fail");
					status.memberPwValid = isValid;
				});

		//폼 검사
		$(".check-form").submit(function() {
			$("[name]").trigger("input").trigger("blur");
			return status.ok();
		});

	});
</script>
<div class="background"></div>
<form action="login" method="post" autocomplete="off" class="check-form">
    <div class="container w-400 my-50">
    	<div class="row center">
    		<a href="/home/login">
	    		<img src="/images/kh.png" width=60% style="margin-top: -50">
    		</a>
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
	</body>
</html>