<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form id="takeOnForm" action="takeOn" method="post">
    <div class="container w-500 my-50">
        <div class="row center">
            <h1>복학 및 복직 사유</h1>
        </div>
        <div class="row center">
            <input type="hidden" name="takeOffTarget" value="${param.takeOffTarget}">
            <textarea id="takeOffMemo" class="w-100" name="takeOffMemo" rows="10" cols="60"></textarea>
        </div>
        <div class="row right">
            <button type="submit" class="btn btn-positive">제출</button>
            <a class="btn btn-neutral" href="list">취소</a>
        </div>
    </div>
</form>

<script>
document.getElementById('takeOnForm').addEventListener('submit', function(event) {
    var textarea = document.getElementById('takeOffMemo');
    if (textarea.value.trim() === '') {
        alert('내용을 작성해주세요');
        event.preventDefault(); // 제출 방지
    }
});
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
