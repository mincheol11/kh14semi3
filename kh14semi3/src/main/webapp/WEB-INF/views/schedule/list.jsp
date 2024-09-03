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
  
    // 이벤트 텍스트 크기 조정
    function adjustEventTextSize() {
        var events = document.querySelectorAll('.event');
        events.forEach(function(event) {
            var textLength = event.textContent.length;
             event.style.fontSize = '10px'; 
           
        });
    }
    // 페이지 로드 후 텍스트 크기 조정
    adjustEventTextSize();
//생년월일 입력창에 DatePicker 설정
});
</script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // 캘린더 셀의 높이를 고정시키는 함수
    function fixCellHeight() {
        var cells = document.querySelectorAll('.calendar-table td');
        var maxHeight = 0;
        // 모든 셀의 최대 높이를 계산
        cells.forEach(function(cell) {
            cell.style.height = 'auto'; // 기존 높이를 제거
            var height = cell.offsetHeight;
            if (height > maxHeight) {
                maxHeight = height;
            }
        });
        // 최대 높이로 모든 셀의 높이를 설정
        cells.forEach(function(cell) {
            cell.style.height = maxHeight + 'px';
        });
    }
    fixCellHeight(); // 페이지 로드 후 셀 높이 조정
});
</script>
<!-- CSS 스타일 -->
<style>
.kh-container{
    height: auto !important; 
}
 /* 캘린더 컨테이너 */
.calendar-container {
  width: 100%;
  max-width: 1100px;
  margin: 100px auto;
  padding: 20px;
  background: #fff;
  border-radius: 8px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  position: relative;
}
.calendar-header {
  display: flex;
  align-items: center;
  justify-content: center; /* 버튼과 날짜를 가운데 정렬 */
  margin-bottom: 20px;
}
.calendar-header .nav-buttons {
  display: flex;
  align-items: center;
  margin: 0 10px; /* 버튼과 날짜 간의 간격 조정 */
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
  margin: 0 5px; /* 버튼 간의 좌우 간격 조정 */
}
.calendar-header .nav-buttons button:hover {
  color: #0056b3;
}
.calendar-header h2 {
  margin: 0;
  font-size: 24px;
}
/* 캘린더 테이블 스타일 */
.calendar-table {
  width: 100%;
   
  border-collapse: collapse;
}
/* 헤더 및 데이터 셀 */
.calendar-table th, .calendar-table td {
width: 1%; 
  padding: 9px;
  border: 0.1px solid #ddd;
  text-align: center;
  vertical-align: top;
  box-sizing: border-box;
  height: 50px;
  
}
/* 헤더 셀 */
.calendar-table th {
  background-color: #f2f2f2;
  font-weight: bold;
}
/* 데이터 셀 */
.calendar-table td {
  height: 10px;
 
}
/* 비어있는 셀 */
.calendar-table .empty {
  background-color: #f9f9f9;
  color: #999;
  border: 0.1px solid #ddd;
}
/* 데이터 셀에 마우스 오버 효과 */
.calendar-table td:hover {
  background-color: #eaeaea;
}
/* '토요일' 및 '일요일' 텍스트 색상 강조 스타일 */
.calendar-table th.saturday, .calendar-table td.saturday {
  color: #007bff; /* 파란색 */
}
.calendar-table th.sunday, .calendar-table td.sunday {
  color: #ff0000; /* 빨간색 */
}
/* 이벤트 스타일 */
.event {
  display: block;
  background-color: #007bff;
  color: white;
  padding: 5px; /* 패딩을 약간 늘려줌 */
  margin: 2px 0;
  text-decoration: none;
  border-radius: 4px;
  font-size: 1px; /* 기본 텍스트 크기 조정 */
  max-width: 100%; /* 텍스트가 컨테이너를 넘지 않도록 설정 */
 
}
/* 이벤트 텍스트가 긴 경우 줄바꿈 */
.event.long-text {
  font-size: 12px; /* 작은 텍스트 크기 */
}
/* 이벤트 마커 스타일 */
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
  transition: transform 0.3s ease-in-out, opacity 0.3s ease-in-out;
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
      <th class="sunday">일</th>
      <th>월</th>
      <th>화</th>
      <th>수</th>
      <th>목</th>
      <th>금</th>
      <th class="saturday">토</th>
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
              <c:set var="dayOfWeek" value="${(week * 7 + day) % 7}" />
              <td class="<c:choose>
                <c:when test='${dayOfWeek == 0}'>sunday</c:when>
                <c:when test='${dayOfWeek == 6}'>saturday</c:when>
                <c:otherwise>day</c:otherwise>
              </c:choose>">
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
<c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
    <c:set var="isLogin" value="${sessionScope.createdUser != null}" />
    <div class="right mb-20">
     <c:if test="${isLogin && isAdmin}">
   
      <a class="btn btn-positive" href="add"><i class="fa-solid fa-pen fa-xs"></i> 학사 일정등록</a>
    </c:if>
    </div>
  </tbody>
</table>
  
</div>
<!-- 모달 팝업 HTML -->
<div id="eventModal" class="modal">
  <div class="modal-content">
    <span class="modal-close" onclick="closeModal()">&times;</span>
    <div id="modal-body">
      <!-- 상세 페이지 내용이 여기에 동적으로 로드됩니다. -->
    </div>
  </div>
</div>
<script>
var modal = document.getElementById("eventModal");
//모달 열기
function openModal(url) {
var modalBody = document.getElementById("modal-body");
console.log("Opening modal with URL: " + url); // 로그 추가
//AJAX 요청으로 상세 페이지 내용 로드
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
//모달 닫기
function closeModal() {
modal.classList.remove('show'); // 모달 닫기
}
//모달 외부 클릭 시 모달 닫기
window.onclick = function(event) {
if (event.target == modal) {
closeModal();
}
}
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>