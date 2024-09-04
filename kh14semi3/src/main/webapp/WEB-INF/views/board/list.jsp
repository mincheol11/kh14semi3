<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
    // 메시지 표시 함수
    function showMessage(message) {
        if (message === 'updateSuccess') {
        	loadCheck1();
        } else if (message === 'deleteSuccess') {
        	loadCheck2();
        } else if (message === 'deleteFail') {
        	loadCheck3();
        } else if (message === 'writeSuccess') {
        	loadCheck4();
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
    
    function loadCheck1() {
		 Swal.fire({
          icon: 'success',
          iconColor: "#6695C4",
          title: '수정 완료.',
          showConfirmButton: false,
          timer: 1500         
 		 });
	};	
    function loadCheck2() {
		 Swal.fire({
          icon: 'success',
          iconColor: "#6695C4",
          title: '삭제 완료.',
          showConfirmButton: false,
          timer: 1500         
 		 });
	};	
    function loadCheck3() {
		 Swal.fire({
          icon: 'error',
          iconColor: "red",
          title: '삭제 실패.',
          showConfirmButton: false,
          timer: 1500         
 		 });
	};	
    function loadCheck4() {
		 Swal.fire({
          icon: 'success',
          iconColor: "#6695C4",
          title: '등록 완료.',
          showConfirmButton: false,
          timer: 1500         
 		 });
	};	

</script>

   
<style>
	
	
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

    
    <div class="row center">
        <form action="list" method="get" autocomplete="off" class="search-form">
            <select name="column" class="field">
                <option value="board_title" <c:if test="${param.column == 'board_title'}">selected</c:if>>제목</option>
                <option value="board_writer" <c:if test="${param.column == 'board_writer'}">selected</c:if>>작성자</option>
            </select>
            <input type="text" name="keyword" placeholder="검색어" value="${param.keyword}" class="field">
            <button type="submit" class="btn btn-positive"><i class="fa-solid fa-magnifying-glass"></i></button>
        	<c:if test="${isLogin && isAdmin}">
				<a class="btn btn-neutral" type="button" href="write" ><i class="fa-solid fa-right-to-bracket"></i> 등록</a>
    		</c:if>
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
                    <tr class="info-block" onclick="location.href='detail?boardNo=${boardDto.boardNo}'" style="cursor: pointer;">
                        <td class="info-content">${boardDto.boardNo}</td>
                        <td class="info-content">${boardDto.boardTitle}</td>
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


</div>
<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>