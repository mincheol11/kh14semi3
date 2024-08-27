<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<script src="/editor/editor.js"></script>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('a[href*="delete"]').addEventListener('click', function(event) {
        event.preventDefault();
        if (confirm('정말 삭제하시겠습니까?')) {
            window.location.href = this.href + "&confirm=true";
        }
    });

    function showMessage(message) {
        if (message === 'updateSuccess') {
            alert('수정이 완료되었습니다.');
        } else if (message === 'deleteSuccess') {
            alert('삭제가 완료되었습니다.');
        } else if (message === 'deleteFail') {
            alert('삭제에 실패하였습니다.');
        }
        else if (message === 'addSuccess') {
            alert('등록되었습니다.');
        }

    }

    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');
    
    if (message) {
        showMessage(message);
    }
});
</script>




<div class="container w-400">
    <!-- 작성자 -->
    <div class="row center">${scheduleDto.scheduleWriter}</div>
    <!-- 작성일 -->
    <div class="row center">
        <fmt:formatDate value="${scheduleDto.scheduleWtime}"
           pattern="y년 M월 d일 E a h시 m분 s초" />
    </div>
    <!-- 내용 -->
    <div class="row center" style="min-height:300px;">
        ${scheduleDto.scheduleContent}
    </div>
    
    <!-- 각종 이동버튼들 -->
    <div class="row right">
        <%-- 관리자만 수정,삭제,등록 가능 --%>
        <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
        <c:set var="isLogin" value="${sessionScope.createdUser != null}" />

        <c:if test="${isLogin && isAdmin}">
            <!-- 관리자만 수정 버튼을 볼 수 있음 -->
            <a class="btn btn-negative"  href="edit?scheduleNo=${scheduleDto.scheduleNo}" >수정</a>
            <!-- 관리자만 삭제 버튼을 볼 수 있음 -->
            <a class="btn btn-negative"  href="delete?scheduleNo=${scheduleDto.scheduleNo}"  >삭제</a>
            <!-- 관리자만 등록 버튼을 볼 수 있음 -->
            <a class="btn btn-positive" href="add">등록</a>
        </c:if>
        
        <a class="btn btn-neutral" href="list">목록</a>
    </div>
</div>

