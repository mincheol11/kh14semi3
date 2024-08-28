<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%-- header.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.profile{
	min-height:150px;
}
#mypage-preview{
	display: flex;
	margin-top: 20px;	
	min-width: 300px;
}
#mypage-preview img{
	border-radius: 25%;
}
.preview{
	background-color : white;
	border-radius: 30px;
}
#boardTable td{
	padding-left:30px;
	padding-right:30px;
}
#lectureTable td{
	padding-left:10px;
	padding-right:10px;
}
#scheduleTable td{
	padding-left:30px;
	padding-right:30px;
}
/* 탐색 버튼 스타일링 */
.nav-buttons button {
  background-color: transparent; /* 배경색을 투명으로 설정 */
  color: rgb(0, 168, 255) !important; /* 기본 기호 색상 설정 (하늘색) */
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
</style>

<script type="text/javascript">
	$(function(){
		
		// mypage
		$(document).ready(function() {
			$.ajax({
				url: '/rest/home/main/mypage-preview',
				method: 'GET',
				success: function(data) {					
					$('#memberId').text("학번 : "+data.memberId);
					$('#memberName').text(data.memberName);
					$('#memberRank').text("구분 : "+data.memberRank);
					/* $('#takeOffType').text(data.takeOffType); */
					$('#memberJoin').text("최근접속일 : "+data.memberJoin);
				},
				error: function() {
				    $('#mypage-preview').html('<p>Error loading preview</p>');
				}
			});
		});
		
		// board
		function loadBoardList() {
            $.ajax({
                url: '/rest/home/main/board-preview',
                method: 'GET',
                dataType: 'json',
                success: function(response) {
                    var boardList = response.boardList;
                    
                    // Clear the existing content
                    $('#boardTable tbody').empty();

                    // Populate the table with new data
                    $.each(boardList, function(index, board) {
						if(index<3){
	                        $('#boardTable tbody').append(
	                            '<tr>' +
	                            '<td>' + ' [' + board.boardNo + '] ' + board.boardTitle + '</td>' +
	                            '<td>' + board.boardWtime + '</td>' +
	                            '</tr>'
	                        );							
						}
                    });

                    // Update pagination controls if needed
                    // $('#pagination').html('...'); // Update pagination HTML
                },
                error: function(xhr, status, error) {
                    console.error('Error fetching data:', status, error);
                }
            });
        }

        // Load board list when the page loads
        loadBoardList();
		
		// lecture
		function loadLectureList() {
     		$.ajax({
          		url: '/rest/home/main/lecture-preview',
          		method: 'GET',
          		dataType: 'json',
          		success: function(response) {
           			var LectureList = response.lectureList;
	              	// Clear the existing content
	              	$('#lectureTable tbody').empty();
	
	              	// Populate the table with new data
	              	$.each(LectureList, function(index, lecture) {
						if(index<3){
							$('#lectureTable tbody').append(
								'<tr>' +
	                            '<td>' + lecture.lectureDepartment + '</td>' +
	                            '<td>' + lecture.lectureProfessor + '</td>' +
	                            '<td>' + lecture.lectureType + '</td>' +
	                            '<td>' + lecture.lectureName + '[' + lecture.lectureCode + ']' + '</td>' +
	                            '<td>' + lecture.lectureTime + '</td>' +
	                            '<td>' + lecture.lectureRoom + '</td>' +
                            	'</tr>'
							);							
						}
					});

					// Update pagination controls if needed
					// $('#pagination').html('...'); // Update pagination HTML
				},
				error: function(xhr, status, error) {
					console.error('Error fetching data:', status, error);
				}
			});
		}
	
      	// Load lecture list when the page loads
      	loadLectureList();
      	
		// schedule
		function loadScheduleList() {
     		$.ajax({
          		url: '/rest/home/main/schedule-preview',
          		method: 'GET',
          		dataType: 'json',
          		success: function(response) {
           			var ScheduleList = response.scheduleList;
           			console.log(response);
           			
	              	// Clear the existing content
	              	$('#scheduleTable tbody').empty();
	
	              	// Populate the table with new data
	              	$.each(ScheduleList, function(index, schedule) {
						if(index<3){
							$('#scheduleTable tbody').append(
								'<tr>' +
								'<td>' + ' [' + schedule.scheduleNo + '] ' + schedule.scheduleTitle + '</td>' +
	                            '<td>' + schedule.scheduleWtime + '</td>' +
                            	'</tr>'
							);							
						}
					});
	             // Insert the current month, page, and year into the HTML
	                $('#currentYear').text(response.currentYear + ' 년');
	                $('#currentMonth').text(response.currentMonth + ' 월');
					// Update pagination controls if needed
					// $('#pagination').html('...'); // Update pagination HTML
				},
				error: function(xhr, status, error) {
					console.error('Error fetching data:', status, error);
				}
			});
		}
      	
		// Load schedule list when the page loads
      	loadScheduleList();
      	
        
	});
</script>




<div class="right">
	createdUser = ${sessionScope.createdUser},
	createdRank = ${sessionScope.createdRank}
</div>

<div class="container w-1000 mb-30">

	<div class="row flex-box">
		
		<div class="w-50 mx-10 flex-core preview">
			<div class="row">			
				<h2 class="left ps-50 my-0">개인정보</h2>
				<div id="mypage-preview" class="flex-box mt-10">
					<div id="preview-text" class="w-40 center">
						<img src="https://placehold.co/100x100">
						<p id="memberName" class="my-0"></p>					
					</div>
					<div id="preview-text" class="w-60 ms-10">
						<p id="memberId"></p>
						<p id="memberRank"></p>
						<%-- <p id="takeOffType"></p> --%>
						<p id="memberJoin"></p>
					</div>
				</div>				
			</div>
		</div>
		
		<div class="w-50 mx-10 flex-core preview">
			<div class="row center">			
				<h2 class=" mt-0 mb-10">공지사항</h2>
				 <table id="boardTable" class="left">		
				 <thead>
                <tr>
                   <th>제목</th>
                    <th>작성일</th>
                 </tr>
            </thead>			 
			        <tbody>
			            <!-- AJAX로 채워질 내용 -->
			        </tbody>
			    </table>				
			</div>
		</div>
		
	</div>
			
	<div class="row flex-box">
	
		<div class="w-50 mx-10 flex-core preview">
			<div class="row center">			
				<h2 class=" mt-0 mb-10">강의목록</h2>
				 <table id="lectureTable">
				 	 <thead>
			            <tr>
			                <th>학과</th>
			                <th>교수</th>
			                <th>분류</th>
			                <th>강의명</th>
			                <th>시간</th>
			                <th>교실</th>
			            </tr>
			        </thead>			 
			        <tbody>
			            <!-- AJAX로 채워질 내용 -->
			        </tbody>
			    </table>				
			</div>
		</div>
		
		<div class="w-50 mx-10 flex-core preview">
    <div class="row center">
        <h2 class="mt-0 mb-10">학사일정</h2>
        <!-- 탐색 버튼 추가 -->
  <div class="row center nav-buttons">
    <button data-icon="‹" onclick="changeMonth(-1)"></button>
<!--     구분선 -->
	<span id="currentYear"></span>
    <span id="currentMonth"></span>
<!-- 	구분선 -->
    <button data-icon="›" onclick="changeMonth(1)"></button>
  </div>
        <table id="scheduleTable" class="left">
            <thead>
                <tr>
                    <th>제목</th>
                    <th>작성일</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty scheduleList}">
                        <c:forEach var="scheduleDto" items="${scheduleList}">
                            <tr>
                                <td>${scheduleDto.scheduleTitle}</td>
                                <td>${scheduleDto.scheduleWtime}</td>
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
		
		
	</div>
	
</div>

<%-- footer.jsp에 존재하는 내용을 불러오도록 설정 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	
	