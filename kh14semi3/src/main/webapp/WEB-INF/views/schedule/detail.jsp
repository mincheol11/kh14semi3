<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.20/dist/summernote-lite.min.js"></script>
<link rel="stylesheet" type="text/css" href="/editor/editor.css">
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('a[href*="delete"]').addEventListener('click', function(event) {
        event.preventDefault();
        if (confirm('정말 삭제하시겠습니까?')) {
            window.location.href = this.href + "&confirm=true";
        }
    });
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
    var urlParams = new URLSearchParams(window.location.search);
    var message = urlParams.get('message');
    
    if (message) {
        showMessage(message);
    }
});
</script>


<!-- CSS 스타일 -->
<style>
  .container {
    
    margin: auto;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }

  .header-title {
    text-align: center;
    margin-bottom: 20px;
    font-size: 24px;
    font-weight: bold;
  }

  .info-block {
    margin-bottom: 20px;
  }

  .info-block strong {
    display: block;
    margin-bottom: 5px;
    color: #333;
  }

  .info-block .info-content {
    background: #fff;
    padding: 10px;
    border-radius: 5px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
  }


  .modal {
    display: none; /* 기본적으로 모달을 숨김 */
    position: fixed;
    z-index: 1; /* 가장 위에 표시 */
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4); /* 배경 색상 투명도 */
  }

  .modal-content {
    background-color: #fff;
    margin: 10% auto;
    padding: 20px;
    border: 1px solid #ddd;
    width: 80%;
    max-width: 800px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  }

  
</style>

<!-- 페이지 내용 -->
<div class="container">
 
  <!-- 작성자 -->
  <div class="info-block">
    <strong>작성자</strong>
    <div class="info-content">${scheduleDto.scheduleWriter}</div>
  </div>

  <!-- 작성일 -->
  <div class="info-block">
    <strong>작성일</strong>
    <div class="info-content">
      <fmt:formatDate value="${scheduleDto.scheduleWtime}" pattern="yyyy년 MM월 dd일 E a hh시 mm분" />
    </div>
  </div>

  <!-- 내용 -->
  <div class="info-block">
    <strong>내용</strong>
    <div class="info-content">${scheduleDto.scheduleContent}</div>
  </div>

  <!-- 버튼들 -->
  <div class="row right">
    <c:set var="isAdmin" value="${sessionScope.createdRank == '관리자'}" />
    <c:set var="isLogin" value="${sessionScope.createdUser != null}" />
    <c:if test="${isLogin && isAdmin}">
      <a class="btn btn-positive" href="edit?scheduleNo=${scheduleDto.scheduleNo}">수정</a>
      <a class="btn btn-negative" href="delete?scheduleNo=${scheduleDto.scheduleNo}">삭제</a>
     
    </c:if>
    <a class="btn btn-neutral" href="list">목록</a>
  </div>
</div>

<!-- 모달 팝업 HTML -->
<div id="eventModal" class="modal">
  <div class="modal-content">
   
    <div id="modal-body">
      <!-- 상세페이지 내용이 여기에 동적으로 로드됩니다. -->
    </div>
  </div>
</div>

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

  
  // 모달 외부 클릭 시 모달 닫기
  window.onclick = function(event) {
    if (event.target == modal) {
      modal.style.display = "none";
    }
  }
</script>