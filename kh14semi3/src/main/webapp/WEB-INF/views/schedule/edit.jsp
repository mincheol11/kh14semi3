<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<script src="/editor/editor.js"></script>

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
            <input type="date" name="scheduleDate" class="field w-200" value="${scheduleDto.scheduleDate}" required>
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
