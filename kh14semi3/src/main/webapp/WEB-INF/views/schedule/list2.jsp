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
    text-align: center;
    margin-bottom: 20px;
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

  .nav-buttons {
    position: absolute; /* 절대 위치 설정 */
    top: 20px;
    left: 0;
    right: 0;
    display: flex;
    justify-content: space-between;
    padding: 0 20px;
  }

  .nav-buttons button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    cursor: pointer;
  }
</style>

<!-- 캘린더 영역 -->
<div class="calendar-container">
  <div class="nav-buttons">
    <c:choose>
      <c:when test="${showPreviousButton}">
        <form action="${pageContext.request.contextPath}list2" method="get">
          <input type="hidden" name="pageYear" value="${currentYear}" />
          <input type="hidden" name="pageMonth" value="${currentMonth - 1}" />
          <button type="submit">&lt;</button>
        </form>
      </c:when>
      <c:otherwise>
        <span></span> <!-- 빈 공간을 추가하여 버튼 위치 맞추기 -->
      </c:otherwise>
    </c:choose>
    <c:choose>
      <c:when test="${showNextButton}">
        <form action="${pageContext.request.contextPath}list2" method="get">
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

  <div class="calendar-header">
    <h2>
      <fmt:formatDate value="${firstDayOfMonthDate}" pattern="yyyy"/>년 
      <fmt:formatDate value="${firstDayOfMonthDate}" pattern="MM"/>월
    </h2>
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
                        <a href="detail?scheduleNo=${event.scheduleNo}" class="event">
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

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
