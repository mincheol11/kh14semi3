<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

  <script type="text/javascript">
  function checkEdit(){
		return confirm("정말 수정하시겠습니까?");
  	}
  $(function(){
		//상태 객체
	  var status ={
	  lectureCodeValid : true, lectureDepartmentValid : false,
	  lectureDepartmentCheckValid : false, lectureProfessorCheckValid : false,
	  lectureProfessorValid : false, lectureTypeValid : true,
	  lectureNameValid : false, lectureDateValid : false,
	  ok : function(){
		return 	this.lectureCodeValid &&  this.lectureDepartmentValid &&
		this.lectureProfessorValid && this.lectureTypeValid &&
		this.lectureNameValid && this.lectureDateValid
		},
	};
//학과코드 입력창 검사 // 테이블에 있는값인지 확인코드 추가
  $("[name=lectureDepartment]").blur(function(){
		var regex= /^.+$/;//형식검사
		var lectureDepartment = $(this).val();
		var isValid= regex.test(lectureDepartment);
		if(isValid){//중복검사
				$.ajax({
					url:"/rest/admin/lecture/checkLectureDepartment",
					method:"post",
					data:{lectureDepartment:lectureDepartment},
					success:function(response){
						if(response){
							status.lectureDepartmentCheckValid=true;
							$("[name=lectureDepartment]").removeClass("success fail fail2")
							.addClass("success");
						}
						else{
	                        status.lectureDepartmentCheckValid=false;
	                        $("[name=lectureDepartment]").removeClass("success fail fail2")
	                        .addClass("fail2");
	                    }
					},
				});
			}
	 		 else{
	     			 $("[name=lectureDepartment]").removeClass("success fail fail2")
	      			.addClass("fail");
	  			}
	  			status.lectureDepartmentValid = isValid;
		});
  
  //교수코드 입력창 검사 // 테이블에 있는값인지 확인코드 추가
  $("[name=lectureProfessor]").blur(function(){
		var regex= /^.+$/;//형식검사
		var lectureProfessor = $(this).val();
		var isValid= regex.test(lectureProfessor);
		if(isValid){//중복검사
				$.ajax({
					url:"/rest/admin/lecture/checkLectureProfessor",
					method:"post",
					data:{lectureProfessor:lectureProfessor},
					success:function(response){
						if(response){
							status.lectureProfessorCheckValid=true;
							$("[name=lectureProfessor]").removeClass("success fail fail2")
							.addClass("success");
						}
						else{
	                        status.lectureProfessorCheckValid=false;
	                        $("[name=lectureProfessor]").removeClass("success fail fail2")
	                        .addClass("fail2");
	                    }
					},
				});
			}
	 		 else{
	     			 $("[name=lectureProfessor]").removeClass("success fail fail2")
	      			.addClass("fail");
	  			}
	  			status.lectureProfessorValid = isValid;
		});
  
  //분류코드 선택창 검사
     $("[name=lectureType]").blur(function(){
            var isValid = $(this).val().length>0;
            $(this).removeClass("success fail")
                        .addClass(isValid ? "success" : "fail");
            status.lectureTypeValid = isValid;
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
		//강의시작시간+강의수업시간+강의요일 모두 선택 or 모두 불 선택	            
      $("[name=lectureTime],[name=lectureDuration],[name=lectureDay]").blur(function(){
          var lectureTime = $("[name=lectureTime]").val();
          var lectureDuration = $("[name=lectureDuration]").val();
          var lectureDay = $("[name=lectureDay]").val();

          var isEmpty = lectureTime.length == 0 
                              && lectureDuration.length == 0 
                              && lectureDay.length == 0;
          var isFill = lectureTime.length > 0
                              && lectureDuration.length > 0
                              && lectureDay.length > 0;
          var isValid = isEmpty || isFill;
          $("[name=lectureTime],[name=lectureDuration],[name=lectureDay]")
                      .removeClass("success fail")
                      .addClass(isValid ? "success" : "fail");
          status.lectureDateValid = isValid;
      });   
		
    //인원 입력
 	 $("[name=lectureCount]").blur(function(){
 	        var isValid = $(this).val()>0;
 	            $(this).removeClass("success fail")
 	                            .addClass(isValid ? "success" : "fail");
 	                status.lectureCountValid = isValid;
 	            });
  
		//단축키 폼 검사
            $(".check-form").submit(function(){
				console.log(status);
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
                <h2>강의 상세정보 수정</h2>
            </div>
            	<div class="row">
            		<label>강의코드</label>
                	<input type="hidden" name="lectureCode" value="${lectureDto.lectureCode}">
                	<div class="field w-100">${lectureDto.lectureCode}</div>
<!-- 학과 코드 입력 중복가능-->
			<div class="row">
                <label>학과 코드 <i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lectureDepartment"  value="${lectureDto.lectureDepartment}"
                        class="field w-100" placeholder="ex)d01">
 				<div class="success-feedback 00b894">올바른 학과 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자로 시작하며,다음 숫자를 2~3자로 작성해주세요.</div>
                 <div class="fail2-feedback d63031">존재하지 않는 코드입니다.</div>
                </div>
<!-- 교수 코드 입력 중복가능-->
			<div class="row">
                <label>교수 코드 <i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lectureProfessor" value="${lectureDto.lectureProfessor}"  
                        class="field w-100" placeholder="ex)prof001">
 				<div class="success-feedback 00b894">올바른 교수 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자로 시작하며,다음 숫자를 3자로 작성해주세요.</div>
                 <div class="fail2-feedback d63031">존재하지 않는 코드입니다.</div>
                </div>
<!-- 분류 선택-->
			<div class="row">
                <label>분류 <i class="fa-solid fa-asterisk red"></i></label>
                <select name="lectureType" class="field w-100" >
                    <option value="">선택하세요</option>
                    <option value="전공" ${lectureDto.lectureType == '전공' ? 'selected' : ''}>전공</option>
                    <option value="교양" ${lectureDto.lectureType == '교양' ? 'selected' : ''}>교양</option>
                    <option value="채플" ${lectureDto.lectureType == '채플' ? 'selected' : ''}>채플</option>
                </select>
                <div class="success-feedback 00b894">올바른 선택입니다.</div>
                <div class="fail-feedback d63031">반드시 선택해야 합니다</div>
            </div>
<!-- 강의명 입력-->
			<div class="row">
                <label>강의 명 <i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lectureName" value="${lectureDto.lectureName}"  
                        class="field w-100" placeholder="ex)학교보건교육론">
 				<div class="success-feedback 00b894">올바른 입력입니다.</div>
                <div class="fail-feedback d63031">한/영 으로만 입력하세요.</div>
                </div>
<!-- 강의 시작 시간입력-->
		<div class="row">
                        <label>강의시작 시간</label>
				<input type="time" name="lectureTime" class="field w-100" value="${lectureDto.lectureTime}">
                        <div class="fail-feedback d63031">3개 모두 입력 해야 합니다</div>
                    </div>
<!-- 강의 수업시간 입력-->
			<div class="row">
				<label>강의 수업 시간</label>
    			<input type="number" name="lectureDuration" class="field w-100" 
    			placeholder="시간" value="${lectureDto.lectureDuration != null ? lectureDto.lectureDuration : ''}">
    			<div class="fail-feedback d63031">3개 모두 입력 해야 합니다</div>
				</div> 
<!-- 강의 수업요일 입력-->
			<div class="row">
                <label>강의요일</label>
                <select name="lectureDay" class="field w-100">
                    <option value="">선택하세요</option>
                    <option value="월요일" ${lectureDto.lectureDay == '월요일' ? 'selected' : ''}>월요일</option>
                    <option value="화요일" ${lectureDto.lectureDay == '화요일' ? 'selected' : ''}>화요일</option>
                    <option value="수요일" ${lectureDto.lectureDay == '수요일' ? 'selected' : ''}>수요일</option>
                    <option value="목요일" ${lectureDto.lectureDay == '목요일' ? 'selected' : ''}>목요일</option>
                    <option value="금요일" ${lectureDto.lectureDay == '금요일' ? 'selected' : ''}>금요일</option>
                    <option value="토요일" ${lectureDto.lectureDay == '토요일' ? 'selected' : ''}>토요일</option>
                    <option value="일요일" ${lectureDto.lectureDay == '일요일' ? 'selected' : ''}>일요일</option>
                </select>
                <div class="fail-feedback d63031">3개 모두 입력 해야 합니다</div>
            </div>
<!-- 강의실 입력-->
			<div class="row">
                <label>강의실</label>
                      <input type="text" name="lectureRoom" value="${lectureDto.lectureRoom}" 
                        class="field w-100" placeholder="ex)강의실">
                </div>
<!-- 인원 입력-->
			<div class="row">
                <label>정원</label>
                      <input type="number" name="lectureCount"  value="${lectureDto.lectureCount}" 
                        class="field w-100" placeholder="인원">
                        <div class="fail-feedback d63031">1명 이상이어야 합니다</div>
                </div>	
				 <div class="row mt-40">
                	<button class="btn btn-positive w-100" onclick="return checkEdit()" >수정하기</button>
                	<div class="row">
                	<a href="detail?lectureCode=${lectureDto.lectureCode}" class="btn btn-netraul w-100" >
                   <i class="fa-solid fa-arrow-rotate-left"></i>
                   뒤로가기
                </a>
                	</div>
            	</div>
            </div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->
