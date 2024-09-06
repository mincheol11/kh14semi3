<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/editor/editor.css">
<script src="${pageContext.request.contextPath}/editor/editor.js"></script>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>


<script type="text/javascript">
$(function(){
	
	 var picker = new Lightpick({
	        field: document.querySelector("[name=scheduleWtime]"),//설치대상
	        format: "YYYY-MM-DD",//날짜의 표시 형식(momentJS 형식)
	        firstDay:7,//일요일부터 표시
	        minDate: moment(),//종료일을 오늘로 설정
	   
	});
	});
</script>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    // 메시지 표시 함수
    function showMessage(message) {
        if (message === 'updateSuccess') {
        	loadCheck1();
        } else if (message === 'deleteSuccess') {
        	loadCheck2();
        } else if (message === 'deleteFail') {
        	loadCheck3();
        } else if (message === 'addSuccess') {
        	loadCheck4();
        }
    }
    // URL의 message 파라미터를 사용하여 메시지를 표시하고, 한 번만 표시되도록 관리
    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');
    if (message) {
        showMessage(message);
        // 메시지 파라미터 제거 후 페이지 이동
        urlParams.delete('message');
        window.history.replaceState(null, '', `${window.location.pathname}?${urlParams}`);
    }
  
    // 이벤트 텍스트 크기 조정
    function adjustEventTextSize() {
        var events = document.querySelectorAll('.event');
        events.forEach(function(event) {
            var textLength = event.textContent.length;
             event.style.fontSize = '10px'; 
           
        });
    }
    // 페이지 로드 후 텍스트 크기 조정
    adjustEventTextSize();
//생년월일 입력창에 DatePicker 설정
});
function loadCheck1() {
	 Swal.fire({
     icon: 'success',
     iconColor: "#6695C4",
     title: '수정 완료.',
     showConfirmButton: false,
     timer: 1500         
	 });
};	
function loadCheck2() {
	 Swal.fire({
     icon: 'success',
     iconColor: "#6695C4",
     title: '삭제 완료.',
     showConfirmButton: false,
     timer: 1500         
	 });
};	
function loadCheck3() {
	 Swal.fire({
     icon: 'error',
     iconColor: "red",
     title: '삭제 실패.',
     showConfirmButton: false,
     timer: 1500         
	 });
};	
function loadCheck4() {
	 Swal.fire({
     icon: 'success',
     iconColor: "#6695C4",
     title: '등록 완료.',
     showConfirmButton: false,
     timer: 1500         
	 });
};	
</script>
<style>
 .kh-container{
    height: auto !important; 
}
</style>

<form action="edit" method="post" autocomplete="off">
    <div class="container w-800 my-50">
        <div class="row center">
            <h1>학사일정 수정</h1>
        </div>
        <div class="row">
            <input type="hidden" name="scheduleNo" class="field w-100" value="${scheduleDto.scheduleNo}">
        </div>
        <div class="row">
            <label>제목 <i class="fa-solid fa-asterisk fa-fade"></i></label>
            <input type="text" name="scheduleTitle" class="field w-100" value="${scheduleDto.scheduleTitle}" required>
            <br><br>
        </div>
        <div class="row">
            <label>날짜 <i class="fa-solid fa-asterisk fa-fade"></i></label>
            <input type="text " name="scheduleWtime" class="field w-200" value="${scheduleDto.scheduleWtime}" required>
            <br><br>
        </div>
        <div class="row">
            <label>내용 <i class="fa-solid fa-asterisk fa-fade"></i></label>
            <textarea name="scheduleContent" class="field w-100" rows="10" cols="80" required>${scheduleDto.scheduleContent}</textarea>
            <br><br>
        </div>
        <div class="row mt-40">
            <button class="btn btn-positive w-100">수정하기</button>
        </div>
    </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>