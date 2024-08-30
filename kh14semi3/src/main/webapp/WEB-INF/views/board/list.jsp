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
	.target {
		display: none;
	}
    .container {
        background-color: #F1F5F9;
        padding: 20px;
        margin: 1px 20px; /* 위아래 여백을 20px로 설정 */
    }

    .row {
        margin-bottom: 10px; /* 여백을 10px로 설정 */
    }

  /*   .btn {
        display: inline-block;
        padding: 8px 16px;
        font-size: 14px;
        border-radius: 5px;
        text-decoration: none;
        color: #ffffff;
        background-color: #007bff;
        transition: background-color 0.3s, transform 0.2s;
    } */

    .btn:hover {
        background-color: #0056b3;
        transform: scale(1.05);
    }

    .btn-neutral {
        background-color: #f8f9fa;
        color: #007bff;
    }

    .btn-neutral:hover {
        background-color: #e2e6ea;
    } */

    .field {
        padding: 6px;
        border-radius: 5px;
        border: 1px solid #ddd;
    }

    .search-form {
        display: flex;
        justify-content: center;
        gap: 8px; /* 간격을 8px로 조정 */
    }

    .table {
        border-collapse: collapse;
        width: 100%; /* 테이블 너비를 100%로 설정 */
        margin-top: 20px;
    }

    .table th, .table td {
        padding: 8px; /* 셀 패딩을 줄임 */
        border: 1px solid #ddd;
        font-size: 14px; /* 폰트 크기를 줄임 */
    }

    .table th {
        background-color: #007bff;
    }

    .table tbody tr:hover {
        background-color: #f1f1f1;
    }

    .board-title {
        color: #007bff;
        text-decoration: none;
        transition: color 0.3s, text-decoration 0.3s;
    }

    .board-title:hover {
        color: #0056b3;
        text-decoration: underline;
    }

    .info-block {
        margin-bottom: 10px; /* 여백을 줄임 */
    }

    .info-block strong {
        display: block;
        margin-bottom: 5px;
        color: #333;
    }

    .info-block .info-content {
/*         background: #fff; */
/*         padding: 8px; /* 패딩을 줄임 */ */
/*         border-radius: 5px; */
/*         box-shadow: 0 2px 4px rgba(0,0,0,0.1); */
/*         font-size: 14px; /* 폰트 크기 조정 */ */
    }

    .info-block .info-contentViews {
        /* background: #fff;
        padding: 8px;
        border-radius: 5px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        width: 30px;
        max-width: 100%;
        height: 30px;
        line-height: 1;
        font-size: 12px;
        */
    }

    .faq-section {
        background-color: #f9f9f9;
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
    
    /* 링크에 마우스를 올렸을 때 스타일 변경 */
.board-title {
  color: black;  /* 기본 텍스트 색상을 검은색으로 설정 */
  text-decoration: none; /* 기본 상태에서 밑줄 제거 */
  transition: transform 0.3s; /* 확대 효과에 부드러운 전환 추가 */
}
    
</style>

<div class="container">
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
                    <th style="width: 5%;">번호</th>
                    <th style="width: 10%;">제목</th>
                    <th style="width: 9%;">작성자</th>
                    <th style="width: 9%;">작성일</th>
                    <th style="width: 2.5%;">조회수</th>
                </tr>
            </thead>
            <tbody align="center">
                <c:forEach var="boardDto" items="${boardList}">
                    <tr class="info-block">
                        <td class="info-content">${boardDto.boardNo}</td>
                        <td class="info-content">
                            <a href="detail?boardNo=${boardDto.boardNo}" class="board-title info-content">${boardDto.boardTitle}</a>
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
