<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var modal = document.getElementById("scheduleModal");
    var span = document.getElementsByClassName("close")[0];

    // 모달 열기
    function openModal(url) {
        var modalBody = document.getElementById("modalBody");
        modalBody.innerHTML = '<p>Loading...</p>'; // 로딩 메시지

        fetch(url)
            .then(response => response.text())
            .then(data => {
                modalBody.innerHTML = data;
                modal.style.display = "block";
            })
            .catch(error => {
                modalBody.innerHTML = '<p>Failed to load content.</p>'; // 오류 메시지
                console.error('Error:', error);
            });
    }

    // 모달 닫기
    span.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // 링크 클릭 시 모달 열기
    document.querySelectorAll('.modal-trigger').forEach(function(element) {
        element.addEventListener('click', function(event) {
            event.preventDefault();
            var url = this.getAttribute('href');
            openModal(url);
        });
    });
});

function changeMonth(direction) {
    var currentYear = parseInt('${currentYear}');
    var currentMonth = parseInt('${currentMonth}');
    var currentPage = parseInt('${currentPage}') || 1; // 기본값을 1로 설정

    // 월을 이동
    currentMonth += direction;

    // 월과 연도 조정
    if (currentMonth > 12) {
        currentMonth = 1;
        currentYear++;
    } else if (currentMonth < 1) {
        currentMonth = 12;
        currentYear--;
    }

    // URL 파라미터 업데이트
    var url = new URL(window.location.href);
    url.searchParams.set('pageYear', currentYear);
    url.searchParams.set('pageMonth', currentMonth);

    // 페이지 번호 조정
    var totalPages = parseInt('${totalPages}') || 1; // 페이지 수를 모델에서 가져와야 함
    if (currentPage > totalPages) currentPage = totalPages; // 유효한 페이지로 설정
    url.searchParams.set('page', currentPage);

    // 페이지 새로 고침
    window.location.href = url.toString();
}
</script>

<style>
/* 모달의 기본 스타일링 */
.modal {
  display: none; /* 모달은 기본적으로 보이지 않도록 설정 */
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgba(0,0,0,0.4);
}

/* 모달 콘텐츠 스타일 */
.modal-content {
  background-color: #fefefe;
  margin: 10% auto; /* 상단 여백을 줄여서 중앙에 더 가까이 위치 */
  padding: 20px;
  border: 1px solid #888;
  width: 50%; /* 모달 너비를 줄이기 */
  max-width: 900px; /* 최대 너비를 설정 */
  box-shadow: 0 4px 8px rgba(0,0,0,0.2); /* 그림자 추가 */
}

/* 닫기 버튼 스타일 */
.close {
  color: #aaa;
  float: right;
  font-size: 24px; /* 폰트 크기 줄이기 */
  font-weight: bold;
}

.close:hover,
.close:focus {

  color: black;
  text-decoration: none;
  cursor: pointer;
}

/* 탐색 버튼 스타일링 */
.nav-buttons button {
  background-color: transparent; /* 배경색을 투명으로 설정 */
  color: rgb(128, 128, 128); /* 기본 기호 색상 설정 (회색) */
  border: 2px solid rgb(128, 128, 128); /* 버튼 테두리 색상 설정 (회색) */
  padding: 15px 15px; /* 버튼의 패딩을 늘려서 크기를 키움 */
  font-size: 36px; /* 폰트 크기를 증가시켜 버튼을 더 크게 보이게 함 */
  cursor: pointer;
  border-radius: 5px; /* 버튼의 모서리를 둥글게 함 */
  transition: color 0.3s, border-color 0.3s; /* 색상 및 테두리 색상 변화에 부드러운 전환 효과 추가 */
}

/* 탐색 버튼 호버 상태 */
.nav-buttons button:hover {
  color: rgb(0, 168, 255); /* 호버 시 기호 색상을 하늘색으로 변경 */
  border-color: rgb(0, 168, 255); /* 호버 시 테두리 색상도 하늘색으로 변경 */
  background-color: transparent; /* 호버 시 배경색을 투명으로 설정 */
}

/* 버튼 텍스트를 제거하고 기호만 보이도록 설정 */
.nav-buttons button {
  font-family: 'Arial', sans-serif; /* 글꼴 설정 */
  font-size: 36px; /* 글꼴 크기 설정 */
  color: rgb(128, 128, 128); /* 기본 기호 색상 설정 (회색) */
  border: none; /* 테두리 제거 */
  background: none; /* 배경 제거 */
  width: 50px; /* 버튼 너비 설정 */
  height: 50px;  /* 버튼 높이 설정 */
}

.nav-buttons button::before {
  content: attr(data-icon); /* data-icon 속성의 값을 사용하여 기호를 표시 */
}

/* 링크에 마우스를 올렸을 때 스타일 변경 */
.schedule-title:hover {
  color: red; /* 빨간색으로 변경 */
  text-decoration: underline; /* 선택 사항: 밑줄 추가 */
}
.table.table-hover > tbody > tr:hover
{
    background-color: rgb(255, 255, 255)!important;
    
}


</style>

<div class="container w-800 my-50">
  <div class="row left">
    <h1>학사 일정</h1>
  </div>

  <!-- 탐색 버튼 추가 -->
  <div class="row center nav-buttons">
    <button data-icon="‹" onclick="changeMonth(-1)"></button>
    <span>${currentYear}년 ${currentMonth}월</span>
    <button data-icon="›" onclick="changeMonth(1)"></button>
  </div>
  
  <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
  <c:set var="isLogin" value="${sessionScope.createdUser != null}" />

  <c:if test="${isLogin && isAdmin}">
    <div class="row right">
      <a href="add" class="btn btn-neutral">신규등록</a>
    </div>
  </c:if>

  <div class="row">
    <table class="table table-border table-hover w-800">
      <thead>
        <tr>
          <th>작성일</th>
          <th>제목</th>
        </tr>
      </thead>
      <tbody align="center">
        <c:choose>
          <c:when test="${not empty scheduleList}">
            <c:forEach var="scheduleDto" items="${scheduleList}">
            <tr>
              <td class="schedule-wtime" >${scheduleDto.scheduleWtime}</td> <!-- schedule-wtime 클래스 추가 -->
              <td align="right">
                <a href="detail?scheduleNo=${scheduleDto.scheduleNo}" class="schedule-title modal-trigger">${scheduleDto.scheduleTitle}</a> <!-- schedule-title 클래스 추가 -->
              </td>
            </tr>
            </c:forEach>
          </c:when>
          <c:otherwise>
            <tr>
              <td colspan="2">일정이 없습니다.</td>
            </tr>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</div>

<!-- 모달 구조 추가 -->
<div id="scheduleModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <div id="modalBody">
      <!-- 상세 페이지 내용이 여기에 로드됩니다 -->
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
