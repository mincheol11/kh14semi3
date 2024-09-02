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
        } else if (message === 'addSuccess') {
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
    max-width: 1335px;
    margin: 10px 5px;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    position: relative; /* position:absolute에서 position:relative로 변경 */
  }

  .calendar-header {
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 20px;
  }

  .calendar-header .nav-buttons {
    display: flex;
    align-items: center;
  }

  .calendar-header .nav-buttons form {
    display: inline-block;
  }

  .calendar-header .nav-buttons button {
    background-color: transparent;
    color: #007bff;
    border: none;
    font-size: 24px;
    cursor: pointer;
    margin: 0 10px;
  }

  .calendar-header .nav-buttons button:hover {
    color: #0056b3;
  }

  .calendar-header h2 {
    margin: 0 20px;
  }

  .calendar-table {
    width: 100%;
    border-collapse: collapse;
  }

  .calendar-table th, .calendar-table td {
    padding: 15px;
    border: 1px solid #ddd;
    text-align: center;
    vertical-align: top;
    width: 14.28%;
    box-sizing: border-box;
  }

  .calendar-table th {
    background-color: #f2f2f2;
    font-weight: bold;
  }

  .calendar-table td {
    height: 80px;
  }

  .calendar-table .empty {
    background-color: #f9f9f9;
    color: #999;
    border: 2px solid #ddd;
    box-shadow: inset 0 0 0 1px rgba(0, 0, 0, 0.1);
  }

  .calendar-table td:hover {
    background-color: #eaeaea;
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
    bottom: 10px;
    right: 10px;
    width: 12px;
    height: 12px;
    background-color: red;
    border-radius: 50%;
  }

  /* 모달 스타일 */
  .modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0, 0, 0, 0.5);
    transition: opacity 0.3s ease;
    opacity: 0;
  }

  .modal.show {
    display: block;
    opacity: 1;
  }

  .modal-content {
    background-color: #fff;
    margin: 10% auto;
    padding: 30px;
    border-radius: 8px;
    width: 80%;
    max-width: 600px;
    position: relative;
    transition: transform 0.3s ease-in-out;
    transform: translateY(-30px);
    opacity: 0;
  }

  .modal.show .modal-content {
    transform: translateY(0);
    opacity: 1;
  }

  .modal-close {
    position: absolute;
    top: 10px;
    right: 10px;
    cursor: pointer;
    font-size: 24px;
    color: #aaa;
    transition: color 0.3s ease;
  }

  .modal-close:hover {
    color: #000;
  }

</style>

<div class="calendar-container">
  <div class="calendar-header">
  <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
    <c:set var="isLogin" value="${sessionScope.createdUser != null}" />
    
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
    <c:if test="${isLogin && isAdmin}">
     <a class="btn btn-positive" href="add">학사 일정등록</a>
    </c:if>
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

    console.log("Opening modal with URL: " + url); // 로그 추가

    // AJAX 요청으로 상세 페이지 내용 로드
    var xhr = new XMLHttpRequest();
    xhr.open("GET", url, true);
    xhr.onload = function() {
      if (xhr.status === 200) {
        modalBody.innerHTML = xhr.responseText;
        modal.classList.add('show'); // 모달 열기
      } else {
        modalBody.innerHTML = "내용을 불러오는 데 실패했습니다.";
      }
    };
    xhr.send();
  }

  // 모달 닫기
  function closeModal() {
    modal.classList.remove('show'); // 모달 닫기
  }

  // 모달 외부 클릭 시 모달 닫기
  window.onclick = function(event) {
    if (event.target == modal) {
      closeModal();
    }
  }
</script>