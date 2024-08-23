<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800 my-50">
    
    <div class="row center">
    <h1>게시글 목록</h1>
    </div>
    <div class="row right">
    <a href="add" class="btn btn-neutral">신규등록</a>
    </div>
    <div class="row center">
    <form action="list" method="get">
	<select name="column" class="field">
    <option value="schedule_title" <c:if test="${param.column == 'schedule_title'}">selected</c:if>>제목</option>
    <option value="schedule_writer" <c:if test="${param.column == 'schedule_writer'}">selected</c:if>>작성자</option>
	</select>
	<input type="text" name="keyword" placeholder="검색어" value="${param.keyword}" class="field">
	<button type="submit" class="btn btn-positive">검색</button>
</form>
    </div>
    <div class="row">
    ${pageVO.page}/${pageVO.lastBlock}페이지
    </div>
    <div class="row">
    ${pageVO.beginRow}-${pageVO.endRow}/${pageVO.count}개
    </div>
    
    <div class="row">
    <table class="table table-border table-hover w-800">
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th >글 분류</th>
		</tr>
	</thead>
	<tbody align="center">
		<c:forEach var="scheduleDto" items="${scheduleList}">
		<tr>
			<td >${scheduleDto.scheduleNo}</td>
			
			<td  align="right">
			<!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
				<a href="detail?scheduleNo=${scheduleDto.scheduleNo}">${scheduleDto.scheduleTitle} </a>
				
			</td>
			
			<td >${scheduleDto.scheduleWriter}</td>
			<td >${scheduleDto.scheduleWtime }</td>
				<td >${scheduleDto.scheduleType}</td>
			<td >${scheduleDto.scheduleNo}</td>
			</tr>
		</c:forEach>
		
	</tbody>
</table>
    </div>
    </div>
     <jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>