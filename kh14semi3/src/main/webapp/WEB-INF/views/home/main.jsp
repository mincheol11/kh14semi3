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
	width: 450px;
	height: 250px;
	background-color : #F1F5F9;
	border-radius: 30px;
}
/* #boardTable td{
	padding-left:30px;
	padding-right:30px;
} */
/* #lectureTable td{
	padding-left:10px;
	padding-right:10px;
}
#scheduleTable td{
	padding-left:10px;
	padding-right:10px;
} */
/* 특정 h2 요소 내의 <span> 스타일을 정의 */
h2 span#currentYear, h2 span#currentMonth {
    font-size: 0.9em; /* 상대적인 크기로 조정, 필요에 따라 px로도 조정 가능 */
    /* 추가 스타일을 여기에 넣을 수 있습니다 */
}
.link-more {
	font-size: 14px;
	text-decoration: underline;
}
.mb-60{
	margin-bottom: 60px !important;
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
				    $('#mypage-preview').html('<p>로그인 시 확인 가능합니다</p>');
				    $('#mypage-preview').css("display", "block").removeClass("left flex-box column-2").addClass("center");
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
                    
                    // 기존 내용을 비웁니다.
                    $('#boardTable tbody').empty();
                    
                	// 제목의 최대 길이를 설정합니다.
                    var maxTitleLength = 15; // 예를 들어, 15자로 설정
					
                    if(boardList.length > 0){ 
                    	// 새로운 데이터를 테이블에 추가합니다.
	                    $.each(boardList, function(index, board) {
							if(index<3){
								// 제목이 길면 잘라내고 `...`을 추가합니다.
		                        var title = board.boardTitle;
		                        if (title.length > maxTitleLength) {
		                            title = title.substring(0, maxTitleLength) + '...';
		                        }
		                        $('#boardTable tbody').append(
		                            '<tr>' +
		                            '<td class="left">' + title + '</td>' +
		                            '<td class="ps-50">' + board.boardWtime + '</td>' +
		                            '</tr>'
		                        );							
							}
	                    });

            } else {
                $('#boardTable').parent().append('<p>등록된 공지사항이 없습니다</p>');
            }
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
	              	$('#lectureTable thead').empty();
	              	$('#lectureTable tbody').empty();
	              	
	              	if(LectureList.length > 0){ 
		              	$('#lectureTable thead').append(
						        '<tr>'+    
							        '<th class="pe-50">분류</th>'+        
							        '<th>강의명</th>'+        
							        '<th class="ps-50">시간</th>'+        
							        '<th class="ps-50">교실</th>'+        
						        '</tr>'
		              	);
		              	// Populate the table with new data
		              	$.each(LectureList, function(index, lecture) {
							if(index<5){
								$('#lectureTable tbody').append(
									'<tr>'+
		                            /* '<td>' + lecture.lectureDepartment + '</td>' + */
		                            /* '<td>' + lecture.lectureProfessor + '</td>' + */
		                            '<td class="pe-50">' + lecture.lectureType + '</td>' +
		                            '<td>' + lecture.lectureName /* + '[' + lecture.lectureCode + ']' */ + '</td>' +
		                            '<td class="ps-50">' + lecture.lectureTime + '</td>' +
		                            '<td class="ps-50">' + lecture.lectureRoom + '</td>' +
		                            '</tr>' 
								);							
							}
						});
	              	 }
	              	else{
           				$('#lectureTable').parent().append('<p>등록된 강의 목록이 없습니다</p>');           				
           			}
					// Update pagination controls if needed
					// $('#pagination').html('...'); // Update pagination HTML
				},
				error: function(xhr, status, error) {
					$('#lectureTable').html('<p>로그인 시 확인 가능합니다</p>');
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
           			// console.log(ScheduleList.length);
           			
	              	// Clear the existing content
	              	$('#scheduleTable tbody').empty();
	
           			if(ScheduleList.length > 0){           			
		              	// Populate the table with new data
		              	$.each(ScheduleList, function(index, schedule) {
							if(index<3){
								$('#scheduleTable tbody').append(
									'<tr>' +
									'<td class="left">' + schedule.scheduleTitle + '</td>' +
		                            '<td class="ps-50">' + schedule.scheduleWtime + '</td>' +
	                            	'</tr>'
								);							
							}
						});
           			}
           			else{
           				$('#scheduleTable').parent().append('<p>등록된 학사 일정이 없습니다</p>');           				
           			}
           			
	             	// Insert the current month, page, and year into the HTML
	                $('#currentYear').text(response.currentYear +'년');
	                $('#currentMonth').text(response.currentMonth +'월');
					// Update pagination controls if needed
					// $('#pagination').html('...'); // Update pagination HTML
					
				},
				/* error: function(xhr, status, error) {
					console.error('Error fetching data:', status, error);
				} */
			});
		}
      	
		// Load schedule list when the page loads
      	loadScheduleList();
      	
        
	});
</script>


<div class="container w-100 my-50 px-50">
	<div class="row flex-box mx-10 my-20" style="min-height:50%">
		
		<div class="w-50 mx-10 flex-core preview">
			<div class="row center w-100">	
				<div>		
					<h2>개인정보
						<a href="/member/mypage">
							<i class="fa-regular fa-square-plus" style="color: #2D3436"></i>
						</a>
					</h2>					
				</div>
				<div id="mypage-preview" class="left flex-box column-2">
					<div id="preview-text" class="w-40 center">
						<!-- <img src="https://placehold.co/100x100"> -->
						<c:if test="${sessionScope.createdUser != null}">
							<img src="/images/empGo.png" width="100px;" height="100px;">
						</c:if>
						<p id="memberName" class="my-0"></p>						
					</div>
					<div id="preview-text" class="w-60">
						<p id="memberId"></p>
						<p id="memberRank"></p>
						<%-- <p id="takeOffType"></p> --%>
						<p id="memberJoin"></p>
					</div>
				</div>				

			</div>
		</div>
		
		<div class="w-50 mx-10 flex-core preview">
			
			<div class="row center w-100">			
				<div>
					<h2>공지사항
				 		<a href="/board/list"><i class="fa-regular fa-square-plus" style="color: #2D3436"></i></a>
					</h2>
				</div>
				
				 <table id="boardTable" class="flex-box flex-core">		
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
			
			
	<div class="row flex-box mx-10 my-20" style="min-height:50%">
	
		<div class="w-50 mx-10 flex-core preview">
			<div class="row center w-100">	
				<div>
					<h2>강의목록
						<a href="/lecture/list"><i class="fa-regular fa-square-plus" style="color: #2D3436"></i></a>
					</h2>
				</div>		
				
				<c:if test="${sessionScope.createdUser == null}">
					<p class="mt-40">로그인 시 확인 가능합니다</p>
				</c:if>
				<c:if test="${sessionScope.createdUser != null}">
				<div class="flex-box flex-core">
			 	<table id="lectureTable">
			        <thead>
                			<tr>
                				<th>분류</th>
                				<th>강의명</th>
                				<th>시간</th>
                				<th>강의실</th>
                 			</tr>
            			</thead>			 
			        	<tbody>
			            	<!-- AJAX로 채워질 내용 -->
			        	</tbody>
			    </table>	
				</div>
			    </c:if>	
			</div>
			
		</div>
		

		<div class="w-50 mx-10 flex-core preview">
			<div class="row center w-100">	
				<div>
					<h2 class="my-0">학사일정
						<a href="/schedule/list"><i class="fa-regular fa-square-plus" style="color: #2D3436"></i></a>
					</h2>
					
					<div class="mt-0 mb-10">
						(<span id="currentYear"></span>
   						<span id="currentMonth"></span>)
   					</div>			
				</div>
					
       		 	<table id="scheduleTable" class="flex-box flex-core">
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
	