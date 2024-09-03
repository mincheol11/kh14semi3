<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.min.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<script src="/editor/editor.js">

</script>
<script type="text/javascript">
$(function(){
	
	var picker = new Lightpick({
	    field: document.querySelector("[name=scheduleWtime]"),//설치대상
	    format: "YYYY-MM-DD",//날짜의 표시 형식(momentJS 형식)
	    firstDay:7//일요일부터 표시
	   
	});
	});
</script>

<form action="add" method="post" autocomplete="off">
    <div class="container w-800 my-50">
        <div class="row center">
            <h1>학사일정 작성</h1>
            <p>욕설 또는 무분별한 광고, 비방은 예고 없이 삭제될 수 있습니다</p>
        </div>
        <div class="row">
            <label>제목 <i class="fa-solid fa-asterisk fa-fade"></i></label>
            <input type="text" name="scheduleTitle" class="field w-100" required>
          
        </div>
        <div class="row">
           <label>날짜 <i class="fa-solid fa-asterisk fa-fade"></i></label>
			<input type="text" name="scheduleWtime" class="field w-200" required>
           
         
        </div>
        <div class="row">
            <label>내용 <i class="fa-solid fa-asterisk fa-fade"></i></label>
            <textarea name="scheduleContent" class="field w-800" required rows="10" cols="80"></textarea>
          
        </div>
        <div class="row">
            <button type="submit" class="btn btn-positive w-100 mt-30"><i class="fa-solid fa-pen fa-xs"></i> 작성하기</button>
        </div>
        <div class="row">
			<a href="/schedule/list" class="btn btn-neutral w-100" >
                   <i class="fa-solid fa-arrow-rotate-left"></i> 뒤로가기</a>
		</div>
    </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
