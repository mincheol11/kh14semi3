<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
    // 메시지 표시 함수
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

    // URL의 message 파라미터를 사용하여 메시지를 표시하고, 한 번만 표시되도록 관리
    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');
    if (message) {
        showMessage(message);

        // 메시지 파라미터 제거 후 페이지 이동
        urlParams.delete('message');
        window.history.replaceState(null, '', `${window.location.pathname}?${urlParams}`);
    }
</script>

<style>

/* 링크에 마우스를 올렸을 때 스타일 변경 */
.board-title {
  color: black;  /* 기본 텍스트 색상을 검은색으로 설정 */
  text-decoration: none; /* 기본 상태에서 밑줄 제거 */
  transition: transform 0.3s; /* 확대 효과에 부드러운 전환 추가 */
}

.table.table-hover > tbody > tr:hover {
    background-color: rgb(255, 255, 255)!important;
}
</style>
   
</style>

<div class="container w-800 my-50">
    
  <div class="row center">
    <h1>학생 공지 사항</h1>
    </div>
    
    <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
    <c:set var="isLogin" value="${sessionScope.createdUser != null}" />
    
    <c:if test="${isLogin && isAdmin}">
    <div class="row right">
        <a href="write" class="btn btn-neutral">신규등록</a>
    </div>
    </c:if>
    
    <div class="row center">
        <form action="list" method="get">
            <select name="column" class="field">
                <option value="board_title" <c:if test="${param.column == 'board_title'}">selected</c:if>>제목</option>
                <option value="board_writer" <c:if test="${param.column == 'board_writer'}">selected</c:if>>작성자</option>
            </select>
            <input type="text" name="keyword" placeholder="검색어" value="${param.keyword}" class="field">
            <button type="submit" class="btn btn-positive">검색</button>
        </form>
    </div>
    
    <div class="row">
        <table class="table table-border table-hover w-800">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>작성일</th>
                    <th>조회수</th>
                </tr>
            </thead>
            <tbody align="center">
                <c:forEach var="boardDto" items="${boardList}">
                    <tr>
                        <td>${boardDto.boardNo}</td>
                        <td align="right">
                            <!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
                            <a href="detail?boardNo=${boardDto.boardNo}" class="board-title">${boardDto.boardTitle}</a>
                        </td>
                        <td>${boardDto.boardWriter}</td>
                        <td>${boardDto.boardWtime}</td>
                        <td align="right">
                            <fmt:formatNumber value="${boardDto.boardViews}" pattern="#,##0"/>
                        </td>
                       
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
	<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>