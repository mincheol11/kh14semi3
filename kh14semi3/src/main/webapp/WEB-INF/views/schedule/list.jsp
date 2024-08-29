<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- CSS 스타일 -->
<style>
  .calendar-container {
    width: 100%;
    max-width: 800px;
    margin: 20px auto;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: relative; /* 버튼 위치 조정을 위한 설정 */
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
    border: 1px solid #ddd;
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
    border: none;
    color: #999;
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
  }

  .close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
  }

  .close:hover,
  .close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
  }
</style>

<!-- 캘린더 영역 -->
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
          <span></span> <!-- 빈 공간을 추가하여 버튼 위치 맞추기 -->
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
          <span></span> <!-- 빈 공간을 추가하여 버튼 위치 맞추기 -->
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
                  <!-- 목록 페이지에서 이벤트 링크 수정 -->
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
    <span class="close">&times;</span>
    <div id="modal-body">
      <!-- 상세페이지 내용이 여기에 동적으로 로드됩니다. -->
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

<script>
  // 모달과 닫기 버튼
  var modal = document.getElementById("eventModal");
  var span = document.getElementsByClassName("close")[0];

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

  // 닫기 버튼 클릭 시 모달 닫기
  span.onclick = function() {
    modal.style.display = "none";
  }

  // 모달 외부 클릭 시 모달 닫기
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
</script>
