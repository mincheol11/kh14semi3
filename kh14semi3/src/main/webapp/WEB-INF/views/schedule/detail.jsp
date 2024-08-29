<!-- 상세 JSP 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<link
    href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css"
    rel="stylesheet">
<script
    src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" type="text/css" href="/editor/editor.css">

<div class="container w-800">
    <!-- 작성자 -->
    <div class="row">${scheduleDto.scheduleWriter}</div>
    <!-- 작성일 -->
    <div class="row right">
        <fmt:formatDate value="${scheduleDto.scheduleWtime}"
           pattern="yyyy년 MM월 dd일 E a hh시 mm분 ss초" />
    </div>
    <!-- 내용 -->
    <div class="row" style="min-height: 200px">
        <!-- 내용에 미디어 파일이 포함될 수 있도록 처리 -->
        ${scheduleDto.scheduleContent}
    </div>

    <!-- 각종 이동 버튼들 -->
    <div class="row right">
        <c:if test="${isLogin && isAdmin}">
            <a class="btn btn-negative" href="edit?scheduleNo=${scheduleDto.scheduleNo}">수정</a>
            <a class="btn btn-negative" href="delete?scheduleNo=${scheduleDto.scheduleNo}">삭제</a>
            <a class="btn btn-positive" href="add">등록</a>
        </c:if>
        <a class="btn btn-neutral" href="list2">목록</a>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
