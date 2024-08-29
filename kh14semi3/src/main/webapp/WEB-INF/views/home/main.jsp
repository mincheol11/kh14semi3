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
/* 특정 h2 요소 내의 <span> 스타일을 정의 */
h2 span#currentYear, h2 span#currentMonth {
    font-size: 0.9em; /* 상대적인 크기로 조정, 필요에 따라 px로도 조정 가능 */
    /* 추가 스타일을 여기에 넣을 수 있습니다 */
}
.link-more {
	color: D1DFEC;
	font-size: 14px;
	text-decoration: underline;
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
           			// console.log(response);
           			
	              	// Clear the existing content
	              	$('#scheduleTable tbody').empty();
	
	              	// Populate the table with new data
	              	$.each(ScheduleList, function(index, schedule) {
						if(index<3){
							$('#scheduleTable tbody').append(
								'<tr>' +
								'<td>' + schedule.scheduleTitle + '</td>' +
	                            '<td>' + schedule.scheduleWtime + '</td>' +
                            	'</tr>'
							);							
						}
					});
	             // Insert the current month, page, and year into the HTML
	                $('#currentYear').text(response.currentYear +'년');
	                $('#currentMonth').text(response.currentMonth +'월');
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
				<h2 class=" mt-0 mb-10">공지사항
				 	<a href="/board/list" class="link link-more">더보기</a></h2>
				 <table id="boardTable" class="left">		
				 <thead>
                <tr>
                  
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
				<h2 class=" mt-0 mb-10">강의목록
				<a href="/lecture/list" class="link link-more">더보기</a></h2>
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
        <h2 class="mt-0 mb-10">학사일정 (<span id="currentYear"></span>
    <span id="currentMonth"></span>)
    <a href="/schedule/list" class="link link-more">더보기</a></h2>
  
        <table id="scheduleTable" class="left">
            <thead>
                <tr>
                    
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
	