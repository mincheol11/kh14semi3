<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->
    
  <script type="text/javascript">
  $(function(){
		//상태 객체
	  var status ={
	  lectureCodeValid : false, lectureCodeCheckValid:false,
	  lectureDepartmentValid : false, lectureDepartmentCheckValid:false,
	  lectureProfessorValid : false, lectureProfessorCheckValid:false,
	  lectureTypeValid : false, lectureTypeCheckValid:false,
	  lectureNameValid : false, lectureNameCheckValid:false,
	  lectureTimeValid : false, lectureTimeCheckValid:false,
	  lectureDurationValid : false, lectureDurationCheckValid:false,
	  lectureDayValid : false, lectureDayCheckValid:false,
	  lectureRoomValid : false, lectureRoomCheckValid:false,
	  lectureCountValid : false, lectureCountCheckValid:false,
	  ok : function(){
		return 	this.lectureCodeValid && this.lectureCodeCheckValid &&  
		this.lectureDepartmentValid && this.lectureDepartmenCheckValid &&
		this.lectureProfessorValid && this.lectureProfessorCheckValid &&
		this.lectureTypeValid && this.lectureTypeCheckValid &&
		this.lectureNameValid && this.lectureNameCheckValid &&
		this.lectureTimeValid && this.lectureTimeCheckValid &&
		this.lectureDurationValid && this.lectureTypeCheckValid &&
		this.lectureDayValid && this.lectureDayCheckValid &&
		this.lectureRoomValid && this.lectureRoomCheckValid &&
		this.lectureCountValid && this.lectureCountCheckValid
		},
	};
		
	// 강의 코드 입력창 검사
	  $("[name=lectureCode]").blur(function(){
		var regex= /^[l][0-9]{2,3}$/;//형식검사
		var lectureCode = $(this).val();
		var isValid= regex.test(lectureCode);
		if(isValid){//중복검사
				$.ajax({
					url:"/rest/admin/lecture/checkLectureCode",
					method:"post",
					data:{lectureCode:lectureCode},
					success:function(response){
						if(response){
							status.lectureCodeCheckValid=true;
							$("[name=lectureCode]").removeClass("success fail fail2")
							.addClass("success");
						}
						else{
	                        status.lectureCodeCheckValid=false;
	                        $("[name=lectureCode]").removeClass("success fail fail2")
	                        .addClass("fail2");
	                    }
					},
				});
			}
	 		 else{
	     			 $("[name=lectureCode]").removeClass("success fail fail2")
	      			.addClass("fail");
	  			}
	  			status.lectureCodeValid = isValid;
		});
		
	  //학과코드 입력창 검사 // 테이블에 있는값인지 확인코드 추가
	  $("[name=lectureDepartment]").blur(function(){
		  	var regex= /^[d][0-9]{2,3}$/;//형식검사
			var lectureDepartment = $(this).val();
			var isValid= regex.test(lectureDepartment);
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.lectureDepartmentValid = isValid;
            });
	  
	  //교수코드 입력창 검사 // 테이블에 있는값인지 확인코드 추가
	  $("[name=lectureProfessor]").blur(function(){
		  	var regex= /^prof[0-9]{3}$/;//형식검사
			var lectureProfessor = $(this).val();
			var isValid= regex.test(lectureProfessor);
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.lectureProfessorValid = isValid;
            });
	  
	  //분류코드 선택창 검사
	     $("[name=lectureType]").click(function(){
                var isValid = $(this).val().length>0;
                $(this).removeClass("success fail")
                            .addClass(isValid ? "success" : "fail");
                status.lectureProfessorValid = isValid;
            });
	  
		  //강의명 입력창 검사 // 테이블에 있는값인지 확인코드 추가
		  $("[name=lectureName]").blur(function(){
			  	var regex= /^[가-힣()]{1,10}$/;//형식검사
				var lectureName = $(this).val();
				var isValid= regex.test(lectureName);
	                $(this).removeClass("success fail")
	                            .addClass(isValid ? "success" : "fail");
	                status.lectureNameValid = isValid;
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

 <form action="add" method="post"  class="check-form">
        <div class="container w-400 my-50">
            <div class="row center">
                <h1>강의 추가</h1>
            </div>
 <!-- 강의 코드 입력 중복X -->               
			<div class="row">
                <label>강의 코드<i class="fa-solid fa-asterisk red"></i></label>
                    <input type="text" name="lectureCode" 
                        class="field w-100" placeholder="ex)l01">
                <div class="success-feedback 00b894">올바른 강의 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자 'l'로 시작하며,다음 숫자를 2~3자로 작성해주세요.</div>
                <div class="fail2-feedback d63031">이미 사용중인 코드입니다.</div>
			</div>
<!-- 학과 코드 입력-->
			<div class="row">
                <label>학과 코드<i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lectureDepartment" 
                        class="field w-100" placeholder="ex)d01">
 				<div class="success-feedback 00b894">올바른 학과 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자 'd'로 시작하며,다음 숫자를 2~3자로 작성해주세요.</div>
                </div>
<!-- 교수 코드 입력-->
			<div class="row">
                <label>교수 코드<i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lectureProfessor" 
                        class="field w-100" placeholder="ex)prof001">
 				<div class="success-feedback 00b894">올바른 교수 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자 'prof'로 시작하며,다음 숫자를 3자로 작성해주세요.</div>
                </div>
<!-- 분류 선택-->
			<div class="row">
                <label>분류<i class="fa-solid fa-asterisk red"></i></label>
                <select name="lectureType" class="field w-100">
                    <option value="">선택하세요</option>
                    <option value="전공">전공</option>
                    <option value="교양">교양</option>
                    <option value="채플">채플</option>
                </select>
                <div class="success-feedback 00b894">올바른 선택입니다</div>
                <div class="fail-feedback d63031">반드시 선택해야 합니다</div>
            </div>
<!-- 강의명 입력-->
			<div class="row">
                <label>강의 명<i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lectureName" 
                        class="field w-100" placeholder="ex)학교보건교육론">
 				<div class="success-feedback 00b894">올바른 입력입니다.</div>
                <div class="fail-feedback d63031">한/영 으로만 입력하세요.</div>
                </div>
<!-- 강의 시작 시간입력-->
		<div class="row">
                        <label>강의시작 시간</label>
                        <input type="time" name="lectureTime" class="field w-100">
                    </div>
<!-- 강의 수업시간 입력-->
			<div class="row">
				<label>강의 수업 시간</label>
    			<input type="number" name="lectureDuration" class="field w-100" placeholder="시간">
				</div> 
<!-- 강의 수업요일 입력-->
			<div class="row">
                <label>강의요일</label>
                <select name="lectureDay" class="field w-100">
                    <option value="">선택하세요</option>
                    <option value="월요일">월요일</option>
                    <option value="화요일">화요일</option>
                    <option value="수요일">수요일</option>
                    <option value="목요일">목요일</option>
                    <option value="금요일">금요일</option>
                    <option value="토요일">토요일</option>
                    <option value="일요일">일요일</option>
                </select>
            </div>
<!-- 강의실 입력-->
			<div class="row">
                <label>강의실</label>
                      <input type="text" name="lectureRoom"   class="field w-100" placeholder="ex)강의실">
                </div>
<!-- 인원 입력-->
			<div class="row">
                <label>정원</label>
                      <input type="number" name="lectureCount" 
                        class="field w-100" placeholder="인원">
                </div>
<!-- 전송버튼 -->
            <div class="row">
                <button type="submit" class="btn btn-positive w-100" >
                   <i class="fa-solid fa-landmark"></i>
                   강의개설
                </button>
            </div>
        </div>
    </form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->
