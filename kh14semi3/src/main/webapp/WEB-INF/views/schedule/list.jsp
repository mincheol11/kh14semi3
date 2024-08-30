<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
   
    // 메시지 표시 함수
    function showMessage(message) {
        if (message === 'updateSuccess') {
            alert('수정이 완료되었습니다.');
        } else if (message === 'deleteSuccess') {
            alert('삭제가 완료되었습니다.');
        } else if (message === 'deleteFail') {
            alert('삭제에 실패하였습니다.');
        }
        else if (message === 'addSuccess') {
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
  
    });

</script>


<!-- CSS 스타일 -->
<style>
  .calendar-container {
    width: 100%;
    max-width: 800px;
    margin: 0 370px;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: absolute;
}
  .calendar-header {
    display: flex; /* 플렉스 박스 사용 */
    align-items: center; /* 세로 정렬 */
    justify-content: center; /* 중앙 정렬 */
    margin-bottom: 20px;
  }

  .calendar-header .nav-buttons {
    display: flex; /* 플렉스 박스 사용 */
    align-items: center; /* 세로 정렬 */
  }

  .calendar-header .nav-buttons form {
    display: inline-block; /* 폼을 버튼처럼 보이도록 설정 */
  }

  .calendar-header .nav-buttons button {
    background-color: transparent; /* 기본 배경 제거 */
    color: #007bff; /* 버튼 텍스트 색상 설정 */
    border: none; /* 기본 테두리 제거 */
    font-size: 24px; /* 버튼 크기 조정 */
    cursor: pointer; /* 클릭 커서 변경 */
    margin: 0 10px; /* 버튼 사이 간격 */
  }

  .calendar-header .nav-buttons button:hover {
    color: #0056b3; /* 버튼에 마우스를 올렸을 때 색상 변경 */
  }

  .calendar-header h2 {
    margin: 0 20px; /* 텍스트와 버튼 사이의 여백 */
  }

  .calendar-table {
    width: 100%;
    border-collapse: collapse;
  }

  .calendar-table th, .calendar-table td {
    padding: 10px;
    border: 1px solid #ddd; /* 기본 테두리 색상 설정 */
    text-align: center;
    vertical-align: top;
    width: 14.28%; /* 100% / 7 days */
    box-sizing: border-box;
    position: relative; /* 빨간색 원을 표시하기 위한 설정 */
  }

  .calendar-table th {
    background-color: #f2f2f2;
    font-weight: bold;
  }

  .calendar-table td {
    height: 60px;
  }

  .calendar-table .empty {
    background-color: #f9f9f9;
    color: #999; /* 회색 숫자 유지 */
    border: 2px solid #ddd; /* 회색 네모난 테두리 추가 */
    box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.1); /* 테두리 강조를 위한 그림자 */
  }

  .calendar-table td:hover {
    background-color: #eaeaea; /* 마우스 오버 시 배경색 변경 */
  }

  .event {
    display: block;
    background-color: #007bff;
    color: white;
    padding: 2px;
    margin: 2px 0;
    text-decoration: none;
    border-radius: 4px;
    font-size: 12px;
  }

  .event-marker {
    position: absolute;
    bottom: 5px;
    right: 5px;
    width: 8px;
    height: 8px;
    background-color: red;
    border-radius: 50%;
  }

  /* 모달 스타일 */
  .modal {
    display: none; /* 기본적으로 모달을 숨김 */
    position: fixed;
    z-index: 1; /* 가장 위에 표시 */
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgb(0,0,0); /* 배경 색상 */
    background-color: rgba(0,0,0,0.4); /* 배경 색상 투명도 */
  }

  .modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 80%;
    position: relative; /* 닫기 버튼을 위한 설정 */
 
  }

  .modal-close {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
    font-size: 18px;
    color: #aaa;
  }

  .modal-close:hover {
    color: #000;
  }
 

</style>

<div class="calendar-container">
  <div class="calendar-header">
    <div class="nav-buttons">
      <c:choose>
        <c:when test="${showPreviousButton}">
          <form action="${pageContext.request.contextPath}list" method="get">
            <input type="hidden" name="pageYear" value="${currentYear}" />
            <input type="hidden" name="pageMonth" value="${currentMonth - 1}" />
            <button type="submit">&lt;</button>
          </form>
        </c:when>
        <c:otherwise>
          <span></span>
        </c:otherwise>
      </c:choose>
    </div>
    <h2>
      <fmt:formatDate value="${firstDayOfMonthDate}" pattern="yyyy"/>년 
      <fmt:formatDate value="${firstDayOfMonthDate}" pattern="MM"/>월
    </h2>
    <div class="nav-buttons">
      <c:choose>
        <c:when test="${showNextButton}">
          <form action="${pageContext.request.contextPath}list" method="get">
            <input type="hidden" name="pageYear" value="${currentYear}" />
            <input type="hidden" name="pageMonth" value="${currentMonth + 1}" />
            <button type="submit">&gt;</button>
          </form>
        </c:when>
        <c:otherwise>
          <span></span>
        </c:otherwise>
      </c:choose>
    </div>
  </div>

  <table class="calendar-table">
    <thead>
      <tr>
        <th>일</th>
        <th>월</th>
        <th>화</th>
        <th>수</th>
        <th>목</th>
        <th>금</th>
        <th>토</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="week" begin="0" end="${(daysInMonth + firstDayOfWeek - 1) / 7}">
        <tr>
          <c:forEach var="day" begin="0" end="6">
            <c:set var="currentDay" value="${week * 7 + day - firstDayOfWeek + 1}" />
            <c:choose>
              <c:when test="${currentDay < 1 || currentDay > daysInMonth}">
                <td class="empty">
                  <c:choose>
                    <c:when test="${currentDay < 1}">
                      <c:out value="${daysInMonth + currentDay}"/>
                    </c:when>
                    <c:otherwise>
                      <c:out value="${currentDay - daysInMonth}"/>
                    </c:otherwise>
                  </c:choose>
                </td>
              </c:when>
              <c:otherwise>
                <td class="day">
                  <c:out value="${currentDay}"/>
                  <c:choose>
                    <c:when test="${eventDays.contains(currentDay)}">
                      <div class="event-marker"></div>
                    </c:when>
                  </c:choose>
                  <c:forEach var="event" items="${eventList}">
                    <c:choose>
                      <c:when test="${event.dayOfMonth == currentDay}">
                        <a href="#" onclick="openModal('detail?scheduleNo=${event.scheduleNo}&title=' + encodeURIComponent('${event.scheduleTitle}')); return false;" class="event">
                          ${event.scheduleTitle}
                        </a>
                      </c:when>
                    </c:choose>
                  </c:forEach>
                </td>
              </c:otherwise>
            </c:choose>
          </c:forEach>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
<!-- 모달 팝업 HTML -->
<div id="eventModal" class="modal">
  <div class="modal-content">
    <span class="modal-close" onclick="closeModal()">&times;</span>
    <div id="modal-body">
      <!-- 상세페이지 내용이 여기에 동적으로 로드됩니다. -->
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

<script>
  // 모달
  var modal = document.getElementById("eventModal");

  // 모달 열기
  function openModal(url) {
    var modalBody = document.getElementById("modal-body");

    // AJAX 요청으로 상세 페이지 내용 로드
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);
    xhr.onload = function() {
      if (xhr.status === 200) {
        modalBody.innerHTML = xhr.responseText;
        modal.style.display = "block"; // 모달 열기
      } else {
        modalBody.innerHTML = "내용을 불러오는 데 실패했습니다.";
      }
    };
    xhr.send();
  }

  // 모달 닫기
  function closeModal() {
    modal.style.display = "none";
  }

  // 모달 외부 클릭 시 모달 닫기
  window.onclick = function(event) {
    if (event.target == modal) {
      closeModal();
    }
  }
</script>
