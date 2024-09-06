<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/editor/editor.css">
<script src="${pageContext.request.contextPath}/editor/editor.js"></script>


<!-- <script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    function showMessage(message) {
        if (message === 'updateSuccess') {
        	alert('수정이 완료되었습니다.');
        } else if (message === 'deleteSuccess') {
        	alert('삭제가 완료되었습니다.');
        } else if (message === 'deleteFail') {
        	alert('삭제에 실패하였습니다.');
        }
        else if (message === 'writeSuccess') {
        	alert('등록되었습니다.');
        }
    }

    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');

    if (message) {
        showMessage(message);
    }
});
</script> -->

<form action="edit" method="post" autocomplete="off">
	<div class="container w-800 my-50">
		<div class="row center">
			<h1>게시글 수정</h1>
		</div>
		<div class="row">
			<input type="hidden" name="boardNo" class="field w-100"
				value="${boardDto.boardNo}">
		</div>
		<div class="row">
			<label>제목 <i class="fa-solid fa-asterisk fa-fade"></i></label> <input
				type="text" name="boardTitle" class="field w-100"
				value="${boardDto.boardTitle}" required> <br>
			<br>
		</div>
		<div class="row">

			<label>내용 <i class="fa-solid fa-asterisk fa-fade"></i></label>
			<%--textarea는 value 속성이 없고 시작과 종료태그 사이에 작성 --%>
			<textarea name="boardContent" class="field w-100"
				value="${boardDto.boardContent}" rows="10" cols="80" required>${boardDto.boardContent}</textarea>
			<br>
			<br>
		</div>
		<div class="row mt-40">
			<button class="btn btn-positive w-100">수정하기</button>
		</div>
	</div>
</form>