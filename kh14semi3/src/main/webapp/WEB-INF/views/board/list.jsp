<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
        } else if (message === 'writeSuccess') {
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

   <script type="text/javascript">
        $(function(){
        	$(document).ready(function(){
        	  });
            $(".btn-toggle").click(function(){
                $(".target").slideToggle();
            });
        });
   </script>
   
<style>
.kh-container{
    height: auto !important; 
}
	.target {
		display: none;
	}
    .search-form {
        display: flex;
        justify-content: center;
        gap: 8px; /* 간격을 8px로 조정 */
    }

    .info-block {
        margin-bottom: 10px; /* 여백을 줄임 */
    }

    .info-block strong {
        display: block;
        margin-bottom: 5px;
    }

    .faq-section {
        border-radius: 5px;
        padding: 10px; /* 패딩 추가 */
    }

    .faq-item {
        margin-bottom: 10px; /* 여백을 줄임 */
    }

    .faq-item strong {
        display: block;
        margin-bottom: 5px;
    }
    

</style>

<div class="container w-900 my-50">
    <div class="row center">
        <h1>학생 공지 사항</h1>
    </div>

    <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
    <c:set var="isLogin" value="${sessionScope.createdUser != null}" />

    <c:if test="${isLogin && isAdmin}">
        <div class="row center">
            <a href="write" class="btn btn-neutral">신규등록</a>
        </div>
    </c:if>

    <div class="row center">
        <form action="list" method="get" class="search-form">
            <select name="column" class="field">
                <option value="board_title" <c:if test="${param.column == 'board_title'}">selected</c:if>>제목</option>
                <option value="board_writer" <c:if test="${param.column == 'board_writer'}">selected</c:if>>작성자</option>
            </select>
            <input type="text" name="keyword" placeholder="검색어" value="${param.keyword}" class="field">
            <button type="submit" class="btn btn-positive">검색</button>
        </form>
    </div>

    <div class="row center">
        <table class="table table-horizontal table-hover">
            <thead>
                <tr>
                    <th style="width: 10%;">번호</th>
                    <th style="width: 40%;">제목</th>
                    <th style="width: 20%;">작성자</th>
                    <th style="width: 20%;">작성일</th>
                    <th style="width: 10%;">조회수</th>
                </tr>
            </thead>
            <tbody align="center">
                <c:forEach var="boardDto" items="${boardList}">
                    <tr class="info-block">
                        <td class="info-content">${boardDto.boardNo}</td>
                        <td class="info-content">
                            <a href="detail?boardNo=${boardDto.boardNo}" class="link link-animation info-content">${boardDto.boardTitle}</a>
                        </td>
                        <td class="info-content">${boardDto.boardWriter}</td>
                        <td class="info-content">${boardDto.boardWtime}</td>
                        <td class="info-contentViews">
                            <fmt:formatNumber value="${boardDto.boardViews}" pattern="#,##0"/>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <h3><button type="button" class="btn btn-neutral btn-toggle">자주 묻는 질문</button></h3>
    <div class="faq-section target">
        <div class="faq-item">
            <strong>Q1: 공지사항을 어떻게 검색하나요?</strong>
            <p>A1: 페이지 상단의 검색 기능을 사용하여 제목이나 작성자명으로 공지사항을 검색할 수 있습니다.</p>
        </div>
        <div class="faq-item">
            <strong>Q2: 공지사항을 작성하려면 어떻게 하나요?</strong>
            <p>A2: 관리자인 경우, 페이지 상단의 '신규등록' 버튼을 클릭하여 새로운 공지사항을 작성할 수 있습니다.</p>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
