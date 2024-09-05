<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<form id="takeOffForm" action="takeOff" method="post">
    <div class="container w-500 my-50">
        <div class="row center">
            <h1>휴학 및 휴직 사유</h1>
        </div>
        <div class="row center">
            <input type="hidden" name="takeOffTarget" value="${param.takeOffTarget}">
            <textarea id="takeOffMemo" class="w-100" name="takeOffMemo" rows="10" cols="60"></textarea>
        </div>
        <div class="row right">
            <button type="submit" class="btn btn-negative">제출</button>
            <a class="btn btn-neutral" href="list">취소</a>
        </div>
    </div>
</form>

<script>
    document.getElementById('takeOffForm').addEventListener('submit', function(event) {
        var textarea = document.getElementById('takeOffMemo');
        if (textarea.value.trim() === '') {
            event.preventDefault(); // 폼 제출을 막습니다.
            alert('내용을 작성해주세요.'); // 경고 메시지 표시
            textarea.focus(); // 포커스를 텍스트 영역으로 이동
        }
    });
</script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>



