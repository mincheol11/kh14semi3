<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var modal = document.getElementById("scheduleModal");
    var span = document.getElementsByClassName("scheduleModalClose")[0];

    function openModal(url) {
        var modalBody = document.getElementById("modalBody");
        modalBody.innerHTML = '<p>Loading...</p>';

        fetch(url)
            .then(response => response.text())
            .then(data => {
                modalBody.innerHTML = data;
                modal.style.display = "block";
            })
            .catch(error => {
                modalBody.innerHTML = '<p>Failed to load content.</p>';
                console.error('Error:', error);
            });
    }

    span.onclick = function() {
        modal.style.display = "none";
        window.location.href = "list"; // 목록 페이지로 이동
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
            window.location.href = "list"; // 목록 페이지로 이동
        }
    }

    document.querySelectorAll('.modal-trigger').forEach(function(element) {
        element.addEventListener('click', function(event) {
            event.preventDefault();
            var url = this.getAttribute('href');
            openModal(url);
        });
    });

    function showMessage(message) {
        if (message === 'updateSuccess') {
            alert('수정이 완료되었습니다.');
        } else if (message === 'deleteSuccess') {
            alert('삭제가 완료되었습니다.');
        } else if (message === 'deleteFail') {
            alert('삭제에 실패하였습니다.');
        } else if (message === 'addSuccess') {
            alert('등록되었습니다.');
        }
    }

    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');
    if (message) {
        showMessage(message);
        urlParams.delete('message');
        window.history.replaceState(null, '', `${window.location.pathname}?${urlParams}`);
    }

    function changeMonth(direction) {
        var currentYear = parseInt('${currentYear}');
        var currentMonth = parseInt('${currentMonth}');
        var currentPage = parseInt('${currentPage}') || 1;

        currentMonth += direction;

        if (currentMonth > 12) {
            currentMonth = 1;
            currentYear++;
        } else if (currentMonth < 1) {
            currentMonth = 12;
            currentYear--;
        }

        var url = new URL(window.location.href);
        url.searchParams.set('pageYear', currentYear);
        url.searchParams.set('pageMonth', currentMonth);

        var totalPages = parseInt('${totalPages}') || 1;
        if (currentPage > totalPages) currentPage = totalPages;
        url.searchParams.set('page', currentPage);

        window.location.href = url.toString();
    }

    document.querySelectorAll('.nav-buttons button').forEach(function(button) {
        button.addEventListener('click', function(event) {
            var direction = this.getAttribute('data-icon') === '‹' ? -1 : 1;
            changeMonth(direction);
        });
    });
});
</script>

<style>

.modal {
  display: none; 
  position: fixed;
  z-index: 1100;
top: 0px;
    left: 0px;
    right: 0px;
    bottom: 0px;
  width: 100%;
  height: 100%;
 background-color: rgba(0,0,0,0.4);
}

/* 모달 콘텐츠 스타일 */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  border: 1px solid rgb(0, 168, 255);
  width: 100%;
  max-width: 1000px;
  height: 95%; /* 높이를 줄여서 아래쪽 여백을 확보합니다 */
  min-height: 300px;
  box-shadow: 0 4px 8px rgba(0,0,0,0.2);
  z-index: 1001;
  overflow-y: auto;
  padding: 20px; /* 콘텐츠에 패딩을 추가하여 여백 조정 */
  box-sizing: border-box; /* 패딩과 테두리가 높이 및 너비에 포함되도록 설정 */

}

/* 모달 콘텐츠 내부 여백 조정 */
.modal-content {
  margin-bottom: 350px; /* 모달 콘텐츠의 아래쪽 여백을 없애거나 줄입니다 */
}
/* 닫기 버튼 스타일 */
.scheduleModalClose {
  color: #aaa;
  float: right;
  font-size: 24px;
  font-weight: bold;
}

.scheduleModalClose:hover,
.scheduleModalClose:focus {
  color: black;
  text-decoration: none;
  cursor: pointer; 
}

/* 탐색 버튼 스타일링 */
.nav-buttons button {
  background-color: transparent; /* 배경색을 투명으로 설정 */
  color: rgb(0, 168, 255) !important; /* 기본 기호 색상 설정 (회색) */
  border: 2px solid rgb(128, 128, 128); /* 버튼 테두리 색상 설정 (회색) */
  padding: 15px 15px; /* 버튼의 패딩을 늘려서 크기를 키움 */
  font-size: 36px; /* 폰트 크기를 증가시켜 버튼을 더 크게 보이게 함 */
  cursor: pointer;
  border-radius: 5px; /* 버튼의 모서리를 둥글게 함 */
  transition: color 0.3s, border-color 0.3s; /* 색상 및 테두리 색상 변화에 부드러운 전환 효과 추가 */
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
.schedule-title {
  color: black;  /* 기본 텍스트 색상을 검은색으로 설정 */
  text-decoration: none; /* 기본 상태에서 밑줄 제거 */
  transition: transform 0.3s; /* 확대 효과에 부드러운 전환 추가 */
}

.table.table-hover > tbody > tr:hover {
    background-color: rgb(255, 255, 255)!important;
}

/* 테이블 스타일 */
.table {
  width: 100%;
  border-collapse: collapse; /* 테두리 중복 제거 */
}

.table th, .table td {  
  width: 50%; /* 열 너비 설정 */
  text-align: center; /* 텍스트 중앙 정렬 */
  min-height: 50px; /* 최소 높이 설정 */
  vertical-align: middle; /* 세로 정렬 */
  border: 1px solid #ddd; /* 셀 테두리 설정 */
}
 
/* 테이블 헤더 스타일 */
.table th {
  background-color: #f4f4f4; /* 헤더 배경색 설정 */
  font-weight: bold; /* 헤더 글씨를 두껍게 설정 */
}

/* 테이블의 행에 호버 효과 추가 */     
.table tr:hover {
  background-color: #f1f1f1; /* 호버 시 배경색 설정 */
}
</style>

<div class="container w-800 ">
  <div class="row center">
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
              <td class="schedule-wtime">${scheduleDto.scheduleWtime}</td> <!-- schedule-wtime 클래스 추가 -->
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
<div class="screen-wrapper flex-core">
  <div class="modal-content">
    <span class="scheduleModalClose">&times;</span>
    <div id="modalBody">
      <!-- 상세 페이지 내용이 여기에 로드됩니다 -->
    </div>
  </div>
</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>