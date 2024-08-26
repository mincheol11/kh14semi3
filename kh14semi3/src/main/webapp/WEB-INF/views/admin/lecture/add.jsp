<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include> <!-- hearder 추가 -->
    
    <!--lightpick cdn-->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>
 
  <script type="text/javascript">
        $(function(){

        //날짜	
         var picker = new Lightpick({
            field: document.querySelector("[name=lectureDay]"),
            format:"YYYY-MM-DD",
            firstDay:7,
            maxDate: moment().add(-1,'days')
        	});
        });
  </script>

 <form action="add" method="post" autocomplete="off" class="check-form">
        <div class="container w-400 my-50">
            <div class="row center">
                <h1>강의 추가</h1>
            </div>
 <!-- 강의 코드 입력 -->               
			<div class="row">
                <label>강의 코드<i class="fa-solid fa-asterisk red"></i></label>
                    <input type="text" name="lectureCode" 
                        class="field w-100" placeholder="ex)l01">
                <div class="success-feedback 00b894">올바른 강의 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자 'l'로 시작하며,다음 숫자를 2~3자로 작성해주세요.</div>
                <div class="fail2-feedback d63031">이미 사용중인 코드입니다.</div>
			</div>
<!-- 학과 코드 입력 중복가능-->
			<div class="row">
                <label>학과 코드<i class="fa-solid fa-asterisk red"></i></label>
                      <input type="text" name="lectureDepartment" 
                        class="field w-100" placeholder="ex)d01">
 				<div class="success-feedback 00b894">올바른 학과 코드입니다.</div>
                <div class="fail-feedback d63031">코드는 앞 영문 소문자 'd'로 시작하며,다음 숫자를 2~3자로 작성해주세요.</div>
                </div>
<!-- 교수 코드 입력 중복가능-->
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
                        <label>강의요일</label>
                        <input type="text" name="lectureDay" class="field w-100">
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
<!-- 전송버튼 -->
            <div class="row">
                <button type="submit" class="btn btn-positive w-100" >
                   <i class="fa-solid fa-landmark"></i>
                   학과개설
                </button>
            </div>
        </div>
    </form>

