<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.pw12{
	font-size: 90%;
}
.menu {
	width: 150px;
    list-style-type: none;
    padding: 0;
    margin: auto; 
}

.menu a:hover{
    color: #004E9C;
}

.menu > li {
    position: relative;
}

.menu > li > a {
    display: block;
    padding: 15px;
    text-decoration: none;
    color: #F1F5F9;
    border-bottom: 1px solid #F1F5F9;
}

.menu > li > a:hover {
	border : 1px solid #F1F5F9;
    /* background-color: #ddd; */
}

.submenu {
	padding-left: 30px !important;
    display: none; /* 기본적으로 숨김 처리 */
    list-style-type: none;
    padding: 0;
    margin: 0;
}

.submenu li a {
    padding: 10px 15px;
    display: block;
    text-decoration: none;
    color: #F1F5F9;
    border-bottom: 1px solid #F1F5F9;
}

.submenu li a:hover {
	border : 1px solid #F1F5F9;
    /* border-color: #f0f0f0; */
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


<div class="w-200 profile">
	<!-- 	
		메뉴(Navbar)
		- (중요) 템플릿 페이지의 모든 경로는 전부 다 절대경로를 써야한다
		- 어디서 실행될지 모르기 때문에 상대경로 사용 시 오류가 생긴다
		- 로그인 상태일 때와 비로그인 상태일 때 다르게 표시
		- 로그인 상태 : sessionScope.creadtedUser != null
	 -->
	 <div class="mt-30">
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
	                    <a href="#">공지사항</a>
	                    <ul class="submenu">
	                        <li><a href="/board/list">공지사항</a></li>
	                        <li><a href="/schedule/list">학사일정</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">수강신청</a>
	                    <ul class="submenu">
	                        <li><a href="/registration/list">수강 신청</a></li>
	                        <li><a href="/registration/regist">수강 목록</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">강의 관리</a>
	                    <ul class="submenu">
	                        <li><a href="/lecture/list">강의 목록</a></li>
	                        <li><a href="/lecture/grade">성적 조회</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">마이페이지</a>
	                    <ul class="submenu">
	                        <li><a href="/member/mypage">내 정보</a></li>
	                        <li><a href="/member/findPw" class="pw12">비밀번호 변경</a></li>
	                        <li><a href="/member/logout">로그아웃</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </div>
	 	</c:when>
	 	<c:when test="${sessionScope.createdRank == '교수'}">
	 		<div class="sidebar">
	            <ul class="menu">
	                <li>
	                    <a href="#">공지사항</a>
	                    <ul class="submenu">
	                        <li><a href="/board/list">공지사항</a></li>
	                        <li><a href="/schedule/list">학사일정</a></li>
	                    </ul>
	                </li>	                
	                <li>
	                    <a href="#">강의 관리</a>
	                    <ul class="submenu">
	                        <li><a href="/lecture/list">강의 목록</a></li>
	                        <li><a href="/lecture/grade">성적 입력</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">마이페이지</a>
	                    <ul class="submenu">
	                        <li><a href="/member/mypage">내 정보</a></li>
	                        <li><a href="/member/findPw" class="pw12">비밀번호 변경</a></li>
	                        <li><a href="/member/logout">로그아웃</a></li>
	                    </ul>
	                </li>
	            </ul>
	        </div>
	 	</c:when>
	 	<c:when test="${sessionScope.createdRank == '관리자'}">
	 		<div class="sidebar">
	            <ul class="menu">
	                <li>
	                    <a href="#">회원 관리</a>
	                    <ul class="submenu">
	                        <li><a href="/admin/member/list">회원 목록</a></li>
	                        <li><a href="/admin/member/join">회원 등록</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">강의 시스템 관리</a>
	                    <ul class="submenu">
	                        <li><a href="/admin/lecture/list">강의 목록</a></li>
	                        <li><a href="/admin/lecture/add">강의 개설</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">학과 시스템 관리</a>
	                    <ul class="submenu">
	                        <li><a href="/admin/department/list">학과 목록</a></li>
	                        <li><a href="/admin/department/expand">학과 개설</a></li>
	                    </ul>
	                </li>
	                <li>
	                    <a href="#">마이페이지</a>
	                    <ul class="submenu">
	                        <li><a href="/member/mypage">내 정보</a></li>
	                        <li><a href="/member/findPw" class="pw12">비밀번호 변경</a></li>
	                        <li><a href="/member/logout">로그아웃</a></li>
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