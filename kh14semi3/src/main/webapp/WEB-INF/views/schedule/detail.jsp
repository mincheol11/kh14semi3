<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
 
 
 
 <script type="text/javascript">
 
 </script>
 
 
 <link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>


<link rel="stylesheet" type="text/css" href="/editor/editor.css">

<div class="container w-800">
    <!-- 작성자 -->
    <div class="row center">${scheduleDto.scheduleWriter}</div>
    <!-- 작성일 -->
    <div class="row center">
        <fmt:formatDate value="${scheduleDto.scheduleWtime}"
           pattern="y년 M월 d일 E a h시 m분 s초" />
    </div>
    <!-- 내용 -->
    <div class="row center" style="min-height: 200px">
        <!-- pre 태그는 내용을 작성된 형태 그대로 출력한다
                Rich Text Editor를 쓸 경우는 할 필요가 없다 -->
        ${scheduleDto.scheduleContent}
    </div>
    
    <!-- 각종 이동버튼들 -->
    <div class="row right">
        <%-- 관리자만 수정,삭제,등록 가능 --%>
        <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
        <c:set var="isLogin" value="${sessionScope.createdUser != null}" />

        <c:if test="${isLogin && isAdmin}">
            <!-- 관리자만 수정 버튼을 볼 수 있음 -->
            <a class="btn btn-negative" href="edit?scheduleNo=${scheduleDto.scheduleNo}">수정</a>
            <!-- 관리자만 삭제 버튼을 볼 수 있음 -->
            <a class="btn btn-negative" href="delete?scheduleNo=${scheduleDto.scheduleNo}">삭제</a>
            <!-- 관리자만 등록 버튼을 볼 수 있음 -->
            <a class="btn btn-positive" href="add">등록</a>
        </c:if>
        
        <a class="btn btn-neutral" href="list">목록</a>
    </div>
</div>