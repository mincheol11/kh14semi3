<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- lightpick cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>



<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
.kh-container{
    height: auto !important; 
}
.fa-asterisk {
	color:#d63031;
}
</style>

<script>
$(function(){
    //상태 객체
    var status = {
        memberIdValid : false, //형식검사
        memberIdCheckValid : false, //중복검사
        memberPwValid : false,
        memberPwCheckValid : false,
        memberNameValid : false, //형식검사
        memberRankValid: false,
        memberEmailValid : false,
        memberCellValid : true , //선택항목
        memberBirthValid : true , //선택항목
        memberAddressValid : true , //선택항목
        ok : function(){
            return this.memberIdValid && this.memberIdCheckValid
                && this.memberPwValid && this.memberPwCheckValid 
                && this.memberNameValid && this.memberRankValid
                && this.memberEmailValid && this.memberCellValid
                && this.memberBirthValid && this.memberAddressValid;
        },
    };

 	//입력창 검사
    $("[name=memberId]").blur(function(){
        //step 1 : 아이디에 대한 형식 검사
        var regex = /^[a-z][a-z0-9]{7,19}$/;
        var memberId = $(this).val();//this.value
        var isValid = regex.test(memberId);
        //step 2 : 아이디 중복 검사(형식이 올바른 경우만)
        if(isValid) {
            //비동기 통신으로 중복 검사 수행
            $.ajax({
                url:"/rest/member/checkId",
                method:"post",
                data:{memberId : memberId},
                success: function(response) {
                    if(response) {//.success - 아이디가 사용가능한 경우
                        status.memberIdCheckValid = true;
                        $("[name=memberId]").removeClass("success fail fail2")
                                                            .addClass("success");
                    }
                    else {//.fail2 - 아이디가 이미 사용중인 경우
                        status.memberIdCheckValid = false;
                        $("[name=memberId]").removeClass("success fail fail2")
                                                            .addClass("fail2");
                    }
                },
            });
        }
        else {//.fail - 아이디가 형식에 맞지 않는 경우
            $("[name=memberId]").removeClass("success fail fail2")
                                                .addClass("fail");
        }
        status.memberIdValid = isValid;
    });
    $("[name=memberPw]").blur(function(){
        var regexStr = /^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[A-Za-z0-9!@#$]{8,16}$/;
        var regex = new RegExp(regexStr);
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberPwValid = isValid;
        console.log($(this).val());
    });
    $("#password-check").blur(function(){
        var isValid = $("[name=memberPw]").val().length
                        && $(this).val() == $("[name=memberPw]").val();
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberPwCheckValid = isValid;
    });
    
    $("[name=memberName]").blur(function(){
        var regexStr = /^[가-힣]{2,7}$/;
        var regex = new RegExp(regexStr);
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail").addClass(isValid ? "success" : "fail");
        status.memberNameValid = isValid;
    });

    $("[name=memberRank]").on("input", function(){
        var str = "^(관리자|교수|학생)$";
        var regex = new RegExp(str);//문자열을 정규표현식으로 변환
        var isValid = regex.test($(this).val());
        $(this).removeClass("success fail")
        .addClass(isValid ? "success" : "fail");
        status.memberRankValid = isValid;
    });
    

    $("[name=memberEmail]").blur(function(){
        var isValid = $(this).val().length > 0;
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberEmailValid = isValid;
    });
    $("[name=memberCell]").blur(function(){
        var regex = /^010[1-9][0-9]{7}$/;
        var isValid = $(this).val().length == 0 || regex.test($(this).val());
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberCellValid = isValid;
    });
    $("[name=memberBirth]").blur(function(){
        var regex = /^([0-9]{4})-(02-(0[1-9]|1[0-9]|2[0-9])|(0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30)|(0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))$/;
        var isValid = $(this).val().length == 0 || regex.test($(this).val());
        $(this).removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberBirthValid = isValid;
    });
    //주소는 모두 없거나 모두 있거나 둘 중 하나면 통과
    $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]").blur(function(){
        var memberPost = $("[name=memberPost]").val();
        var memberAddress1 = $("[name=memberAddress1]").val();
        var memberAddress2 = $("[name=memberAddress2]").val();

        var isEmpty = memberPost.length == 0 
                            && memberAddress1.length == 0 
                            && memberAddress2.length == 0;
        var isFill = memberPost.length > 0
                            && memberAddress1.length > 0
                            && memberAddress2.length > 0;
        var isValid = isEmpty || isFill;
        $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]")
                    .removeClass("success fail")
                    .addClass(isValid ? "success" : "fail");
        status.memberAddressValid = isValid;
    });

    //폼 검사
    $(".check-form").submit(function(){
        $("[name], #password-check").trigger("input").trigger("blur");    
        return status.ok();
    });
    

    //부가기능
    $(".field-show").change(function(){
        var checked = $(this).prop("checked");
        $("[name=memberPw] , #password-check")
                    .attr("type", checked ? "text" : "password");
    });
    $(".fa-eye").click(function(){
        var checked = $(this).hasClass("fa-eye");
        if(checked) {
            $(this).removeClass("fa-eye").addClass("fa-eye-slash");
            $("[name=memberPw] , #password-check").attr("type", "text");
        }
        else {
            $(this).removeClass("fa-eye-slash").addClass("fa-eye");
            $("[name=memberPw] , #password-check").attr("type", "password");
        }
    });


    $("[name=memberPost],[name=memberAddress1], .btn-find-address")
    .click(function(){
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수

                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                document.querySelector("[name=memberPost]").value = data.zonecode;
                document.querySelector("[name=memberAddress1]").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.querySelector("[name=memberAddress2]").focus();
                $("[name=memberPost]").trigger("input");
            }
        }).open();
    });

    $(".btn-clear-address").click(function(){
        $("[name=memberPost]").val("");
        $("[name=memberAddress1]").val("");
        $("[name=memberAddress2]").val("");
    });

    $(".btn-clear-address").hide();
    $("[name=memberPost],[name=memberAddress1],[name=memberAddress2]")
    .on("input", function(){
        var len1 = $("[name=memberPost]").val().length;
        var len2 = $("[name=memberAddress1]").val().length;
        var len3 = $("[name=memberAddress2]").val().length;
        if(len1 + len2 + len3 > 0) {
            $(".btn-clear-address").fadeIn();
        }
        else {
            $(".btn-clear-address").fadeOut();
        }
    });

    //엔터 차단 코드
    $(".check-form").find(".field").keypress(function(e){
        switch(e.keyCode) {
            case 13: return false;
        }
    });
    

    //생년월일 입력창에 DatePicker 설정
    var picker = new Lightpick({
        field: document.querySelector("[name=memberBirth]"),//설치대상
        format: "YYYY-MM-DD",//날짜의 표시 형식(momentJS 형식)
        firstDay:7,//일요일부터 표시
        maxDate: moment(),//종료일을 오늘로 설정
    });
});
</script>

<div class="container w-500 my-50">
	<div class="row center">
		<h1>회원 등록 페이지</h1>
	</div>

	<form class="check-form" action="join" method="post"  >
		<div class="row">
 			
 			<div class="page">
				<div class="row">
					<label>아이디</label>
					<input type="text" name="memberId" class="field w-100"
                                    placeholder="영문소문자 시작, 숫자 포함 8~20자">
					<div class="success-feedback">멋진 아이디입니다!</div>
					<div class="fail-feedback">올바른 형식으로 작성해주세요</div>
					<div class="fail2-feedback">아이디가 이미 사용중입니다</div>
				</div>
			</div>
                
			<div class="page">
				<div class="row">
					<label>비밀번호
						<!-- 방법1 : 체크박스 사용 -->
						<label class="ms-20">
							<input type="checkbox" class="field-show">
							<span>표시하기</span>
						</label>
						<!-- 방법2 : 아이콘 사용 -->
						<i class="fa-solid fa-eye"></i>
					</label>
                        
					<input type="password" name="memberPw" class="field w-100" 	
								placeholder="영문 대소문자, 숫자, !@#$중 하나 반드시 포함">
						<div class="success-feedback">올바른 형식입니다!</div>
                        <div class="fail-feedback">형식에 맞춰 8~16자로 작성하세요</div>
				</div>
			</div>
				
			<div class="page">
				<div class="row">
					<label>비밀번호 확인</label>
					<input type="password" id="password-check" class="field w-100" 
								placeholder="확인을 위해 비밀번호 한번 더 입력">
                        <div class="success-feedback">비밀번호가 일치합니다</div>
                        <div class="fail-feedback">비밀번호가 일치하지 않습니다</div>
				</div>
			</div>
			
			<div class="page">
				<div class="row">
					<label>이름</label>
					<input type="text" name="memberName" class="field w-100" placeholder="이름">
                        <div class="success-feedback">완료</div>
                        <div class="fail-feedback">이름이 형식에 맞지 않습니다</div>
				</div>
			</div>
			
			<!------------- 교수 관리자 학생-------------->
			<div class="page">
				<div class="row">
   					<label>직업</label>
 					<select name="memberRank" class="field w-100">
						<option value="">분류</option>
						<option value="관리자">관리자</option>
						<option value="교수">교수</option>
						<option value="학생">학생</option>
					</select>    
                        <div class="success-feedback">완료</div>
                        <div class="fail-feedback">필수 선택사항 입니다.</div>
				</div>
			</div>

			<div class="page">
				<div class="row">
					<label>이메일</label>
					<input type="email" name="memberEmail" class="field w-100" 
								placeholder="test@kh.com">
                        <div class="fail-feedback">이메일은 반드시 입력해야 합니다</div>
				</div>
			</div>
			
			<div class="page">
				<div class="row">
					<label>연락처(휴대전화번호, - 제외)</label>
					<input type="text" name="memberCell" class="field w-100" placeholder="010XXXXXXXX">
                        <div class="fail-feedback">입력한 번호가 형식에 맞지 않습니다</div>
				</div>
			</div>
			
			<div class="page">
				<div class="row">
					<label>생년월일</label>
					<input type="text" name="memberBirth" class="field w-100">
				</div>
			</div>
			
			<div class="page">
				<div class="row">
					<label>주소</label>
					<div>
						<input type="text" name="memberPost" class="field"
	                                placeholder="우편번호" readonly>
						<button class="btn btn-neutral btn-find-address">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
						<button class="btn btn-negative btn-clear-address">
							<i class="fa-solid fa-xmark"></i>
						</button>
					</div>
				</div>
			
				<div class="row">
					<input type="text" name="memberAddress1" class="field w-100" 
								placeholder="기본주소" readonly>
				</div>
				<div class="row">
					<input type="text" name="memberAddress2" class="field w-100"
                                placeholder="상세주소">
					<div class="fail-feedback">주소는 비워두거나 모두 입력해야 합니다</div>
				</div>
			</div>
			
			<div class="row w-100 mt-30">
				<button type="submit" class="btn btn-positive w-100">
					<i class="fa-solid fa-right-to-bracket"></i> 등록하기
				</button>
				<div class="row">
					<a href="list" class="btn btn-neutral w-100"><i class="fa-solid fa-list"></i> 목록이동</a> 
				</div>
			</div>
                
        </div>
    </form>
</div>


<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>