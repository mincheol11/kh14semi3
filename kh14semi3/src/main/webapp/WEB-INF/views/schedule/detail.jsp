<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
 <link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>


<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<style>
.reply-wrapper {
	display: flex;
}

.reply-wrapper>.image-wrapper {
	width: 100px;
	min-width: 100px;
	padding: 10px;
}

.reply-wrapper>.image-wrapper>img {
	width: 100%;
}

.reply-wrapper>.content-wrapper {
	flex-grow: 1;
	font-size: 16px;
}

.reply-wrapper>.content-wrapper>.reply-title {
	font-size: 1.25em;
}

.reply-wrapper>.content-wrapper>.reply-content {
	font-size: 0.95em;
	min-height: 50px;
}

.reply-wrapper>.content-wrapper>.reply-info {
	
}
</style>

<script type="text/template" id="reply-edit-template">
	<!-- 댓글 수정 영역 -->
	<div class="reply-wrapper reply-edit-wrapper">
		<!-- 프로필 영역 -->
		<div class="image-wrapper">
			<img src="https://picsum.photos/100">
		</div>

		<!-- 내용 영역 -->
		<div class="content-wrapper">
			<div class="reply-title">댓글 작성자</div>
			<textarea class="field w-100 reply-edit-input"></textarea>
			<div class="right">
				<button class="btn btn-neutral reply-cancel-btn">취소</button>
				<button class="btn btn-positive reply-done-btn">완료</button>
			</div>
		</div>
	</div>
</script>





<div class="container w-800">
	<!-- 작성자 -->
	<div class="row">${scheduleDto.scheduleWriter}</div>
	<!-- 작성일 -->
	<div class="row right">
		<fmt:formatDate value="${scheduleDto.scheduleWtime}"
			pattern="y년 M월 d일 E a h시 m분 s초" />
	</div>
	<!-- 내용 -->
	<div class="row" style="min-height: 200px">
		<!-- pre 태그는 내용을 작성된 형태 그대로 출력한다
				Rich Text Editor를 쓸 경우는 할 필요가 없다 -->
		${scheduleDto.scheduleContent}
	</div>
	
	<!-- 각종 이동버튼들 -->
	<div class="row right">
		<a class="btn btn-positive" href="add">글쓰기</a> 
		

		<%-- 본인 글만 표시되도록 조건 설정 --%>
		<c:set var="isAdmin" value="${sessionScope.createdLevel == '관리자'}" />
		<c:set var="isLogin" value="${sessionScope.createdUser != null}" />
		<c:set var="isOwner"
			value="${sessionScope.createdUser == scheduleDto.scheduleWriter}" />

		<c:if test="${isLogin}">
			<c:if test="${isOwner}">
				<a class="btn btn-negative" href="edit?scheduleNo=${scheduleDto.scheduleNo}">수정</a>
			</c:if>
			<c:if test="${isOwner || isAdmin}">
				<a class="btn btn-negative"
					href="delete?scheduleNo=${scheduleDto.scheduleNo}">삭제</a>
			</c:if>
		</c:if>

		<a class="btn btn-neutral" href="list">목록</a>
	</div>
</div>