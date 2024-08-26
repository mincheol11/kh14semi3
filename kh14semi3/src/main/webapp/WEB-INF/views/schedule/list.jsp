<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 <script type="text/javascript">
 document.addEventListener('DOMContentLoaded', function() {
	  var modal = document.getElementById("scheduleModal");
	  var span = document.getElementsByClassName("close")[0];
	  
	  // 모달 열기
	  function openModal(url) {
	    fetch(url)
	      .then(response => response.text())
	      .then(data => {
	        document.getElementById("modalBody").innerHTML = data;
	        modal.style.display = "block";
	      });
	  }

	  // 모달 닫기
	  span.onclick = function() {
	    modal.style.display = "none";
	  }

	  window.onclick = function(event) {
	    if (event.target == modal) {
	      modal.style.display = "none";
	    }
	  }

	  // 링크 클릭 시 모달 열기
	  document.querySelectorAll('.modal-trigger').forEach(function(element) {
	    element.addEventListener('click', function(event) {
	      event.preventDefault();
	      var url = this.getAttribute('href');
	      openModal(url);
	    });
	  });
	});
	 
 </script>
 
 
 <style>
/* 모달의 기본 스타일링 */
.modal {
  display: none; /* 모달은 기본적으로 보이지 않도록 설정 */
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}

/* 모달 콘텐츠 스타일 */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

/* 닫기 버튼 스타일 */
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
 
<div class="container w-800 my-50">
    
    <div class="row left">
    <h1>학사 일정</h1>
    </div>

 <jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>


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
		<c:forEach var="scheduleDto" items="${scheduleList}">
		<tr>
			
		<td>${scheduleDto.scheduleWtime }</td>
		<td  align="right">
			<!-- 제목에 링크를 부여해서 상세 페이지로 이동하도록 구현 -->
				<a href="detail?scheduleNo=${scheduleDto.scheduleNo}" class="modal-trigger">${scheduleDto.scheduleTitle} </a>

			</td>
			

			</tr>
		</c:forEach>

	</tbody>
</table>
    </div>
    </div>
    
    <!-- 모달 구조 추가 -->
<div id="scheduleModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <div id="modalBody">
      <!-- 상세 페이지 내용이 여기에 로드됩니다 -->
    </div>
  </div>
  </div>
 