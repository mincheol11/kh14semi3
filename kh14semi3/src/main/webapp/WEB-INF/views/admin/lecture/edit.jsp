<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->

  <script type="text/javascript">
  function checkEdit(){
		return confirm("정말 수정하시겠습니까?");
  	}
  
  $(function(){
	
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
<!-- 학과코드 입력 -->
			<div class="row">
                <label>학과코드 <i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lecture_department" 
                        class="field w-100" placeholder="ex)d01">
 				<div class="success-feedback 00b894">올바른 학과코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자 'd'로 시작하며,다음 숫자를 2~3자로 작성해주세요.</div>
                	</div>
<!-- 강사코드 입력 -->
			<div class="row">
                <label>강사코드 <i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lecture_professor" 
                        class="field w-100" placeholder="ex)prof001">
 				<div class="success-feedback 00b894">올바른 학과코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자 'prof'로 시작하며,다음 숫자를 3자로 작성해주세요.</div>
                	</div>
<!-- 분류 선택 -->
			<div class="row">
                <label>강사코드 <i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lecture_professor" 
                        class="field w-100" placeholder="ex)prof001">
 				<div class="success-feedback 00b894">올바른 학과코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자 'prof'로 시작하며,다음 숫자를 3자로 작성해주세요.</div>
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
                        <div class="fail-feedback d63031">반드시 선택해야 합니다</div>
                    </div>
<!-- 강의 수업시간 입력-->
			<div class="row">
				<label>강의 수업 시간</label>
    			<input type="number" name="lectrueDuration" class="field w-100" placeholder="시간">
    			<div class="fail-feedback d63031">반드시 선택해야 합니다</div>
				</div> 
<!-- 강의 수업요일 입력-->
			<div class="row">
                <label>강의요일<i class="fa-solid fa-asterisk"></i></label>
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
                <div class="fail-feedback d63031">반드시 선택해야 합니다</div>
            </div>
<!-- 강의실 입력-->
			<div class="row">
                <label>강의실</label>
                      <input type="text" name="lectureRoom" 
                        class="field w-100" placeholder="ex)강의실">
 				<div class="success-feedback 00b894">올바른 입력입니다.</div>
                <div class="fail-feedback d63031">한글로 입력하세요.</div>
                </div>
<!-- 인원 입력-->
			<div class="row">
                <label>정원</label>
                      <input type="number" name="lectureCount" 
                        class="field w-100" placeholder="인원">
 				<div class="success-feedback 00b894">올바른 입력입니다.</div>
                <div class="fail-feedback d63031">숫자만을 입력하세요.</div>
                </div>               	
				 <div class="row mt-40">
                	<button class="btn btn-positive w-100" onclick="return checkEdit()" >수정하기</button>
            	</div>
            </div>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> <!-- footer 추가 -->
