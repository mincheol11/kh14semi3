<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>

.menu {
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.menu a:hover{
    color: red;
}

.menu > li {
    position: relative;
}

.menu > li > a {
    display: block;
    padding: 15px;
    text-decoration: none;
    color: #333;
    border-bottom: 1px solid #ddd;
}

.menu > li > a:hover {
    background-color: #ddd;
}

.submenu {
    display: none; /* 기본적으로 숨김 처리 */
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.submenu li a {
    padding: 10px 15px;
    display: block;
    text-decoration: none;
    color: #333;
    background-color: #fff;
    border-bottom: 1px solid #ddd;
}

.submenu li a:hover {
    background-color: #f0f0f0;
}
</style>

<script type="text/javascript">
	$(document).ready(function() {
	    $(".menu > li > a").on("click", function(event) {
	        event.preventDefault(); // 기본 링크 동작 방지
	        var submenu = $(this).siblings(".submenu");
	        
	        // 현재 클릭된 메뉴 항목의 서브메뉴를 토글
	        if (submenu.is(":visible")) {
	            submenu.slideUp(); // 서브메뉴 숨기기
	        } else {
	            $(".submenu").slideUp(); // 다른 서브메뉴 숨기기
	            submenu.slideDown(); // 현재 서브메뉴 보이기
	        }
	    });
	});
</script>


<div class="w-200 me-30 profile rightline" style="background-color:80808020;">
	<!-- 	
		메뉴(Navbar)
		- (중요) 템플릿 페이지의 모든 경로는 전부 다 절대경로를 써야한다
		- 어디서 실행될지 모르기 때문에 상대경로 사용 시 오류가 생긴다
		- 로그인 상태일 때와 비로그인 상태일 때 다르게 표시
		- 로그인 상태 : sessionScope.creadtedUser != null
	 -->
	 <div class="mt-50">
	 <c:choose>
	 	<c:when test="${sessionScope.createdUser == null}">
		 	<div class="row center">
				<a href="/member/login" class="link link-animation">
					로그인<i class="fa-solid fa-square-arrow-up-right"></i>
				</a> 하세요
			</div>
	 	</c:when>
	 	<c:when test="${sessionScope.createdRank == '학생'}">	 		
	 		<div class="sidebar">
	            <ul class="menu">
	                <li>
	                    <a href="#">학생 메뉴1</a>
	                    <ul class="submenu ps-30">
	                        <li><a href="#">학생 하위1</a></li>
	                        <li><a href="#">학생 하위2</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">학생 메뉴2</a>
	                    <ul class="submenu">
	                        <li><a href="#">학생 하위1</a></li>
	                        <li><a href="#">학생 하위2</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">학생 메뉴3</a>
	                    <ul class="submenu">
	                        <li><a href="#">학생 하위1</a></li>
	                        <li><a href="#">학생 하위2</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </div>
	 	</c:when>
	 	<c:when test="${sessionScope.createdRank == '교수'}">
	 		<div class="sidebar">
	            <ul class="menu">
	                <li>
	                    <a href="#">교수 메뉴1</a>
	                    <ul class="submenu ps-30">
	                        <li><a href="#">교수 하위1</a></li>
	                        <li><a href="#">교수 하위2</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">교수 메뉴2</a>
	                    <ul class="submenu">
	                        <li><a href="#">교수 하위1</a></li>
	                        <li><a href="#">교수 하위2</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">교수 메뉴3</a>
	                    <ul class="submenu">
	                        <li><a href="#">교수 하위1</a></li>
	                        <li><a href="#">교수 하위2</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </div>
	 	</c:when>
	 	<c:when test="${sessionScope.createdRank == '관리자'}">
	 		<div class="sidebar">
	            <ul class="menu">
	                <li>
	                    <a href="#">관리자 메뉴1</a>
	                    <ul class="submenu ps-30">
	                        <li><a href="#">관리자 하위1</a></li>
	                        <li><a href="#">관리자 하위2</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">관리자 메뉴2</a>
	                    <ul class="submenu">
	                        <li><a href="#">관리자 하위1</a></li>
	                        <li><a href="#">관리자 하위2</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">관리자 메뉴3</a>
	                    <ul class="submenu">
	                        <li><a href="#">관리자 하위1</a></li>
	                        <li><a href="#">관리자 하위2</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </div>
	 	</c:when>
	 	<c:otherwise>
	 	
	 	</c:otherwise>
	 </c:choose>	 
	 </div>
</div>