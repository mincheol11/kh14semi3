<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
.menu{
	flex-direction: column;
}
</style>

<script type="text/javascript">
	/* $(function(){
		$(".menu-on").on("click",function(){
			$(".menu-on li > ul").css("display", "block");
			$(this).removeClass("menu-on").addClass("menu-off");
		});
		$(".menu-off").on("click",function(){
			$(".menu-off li > ul").css("display", "none");
			$(this).removeClass("menu-off").addClass("menu-on");
		});
	}); */
</script>


<div class="w-200 me-30 profile rightline" style="background-color:blue;">
	<!-- 	
		메뉴(Navbar)
		- (중요) 템플릿 페이지의 모든 경로는 전부 다 절대경로를 써야한다
		- 어디서 실행될지 모르기 때문에 상대경로 사용 시 오류가 생긴다
		- 로그인 상태일 때와 비로그인 상태일 때 다르게 표시
		- 로그인 상태 : sessionScope.creadtedUser != null
	 -->
	 <div class="mt-50 ps-30">
	 <c:choose>
	 	<c:when test="${sessionScope.createdUser == null}">
		 	<div class="row center">
				<a href="/member/login" class="link link-animation">
					로그인<i class="fa-solid fa-square-arrow-up-right"></i>
				</a> 하세요
			</div>
	 	</c:when>
	 	<c:when test="${sessionScope.createdRank == '학생'}">
	 		학생 메뉴
	 		<ul class="menu">
      			<li><a href="#" class="menu-on">홈</a>
      				<ul>						
		                <!-- <ul><li></li></ul> 세부항목 양식 -->
						<li><a href="#">포켓몬</a></li> <!-- 절대경로 -->
						<li><a href="#">사원</a></li> <!-- 절대경로 -->
						<li><a href="#">도서</a></li> <!-- 절대경로 -->			
					</ul>
      			</li>
      			<li>
		       		<a href="#" class="menu-on">데이터</a>
		            <ul>						
		                <!-- <ul><li></li></ul> 세부항목 양식 -->
						<li><a href="#">포켓몬</a></li> <!-- 절대경로 -->
						<li><a href="#">사원</a></li> <!-- 절대경로 -->
						<li><a href="#">도서</a></li> <!-- 절대경로 -->			
					</ul>
				</li>
   			</ul>
	 	</c:when>
	 	<c:when test="${sessionScope.createdRank == '교수'}">
	 		교수 메뉴
	 	</c:when>
	 	<c:when test="${sessionScope.createdRank == '관리자'}">
	 		관리자 메뉴
	 	</c:when>
	 	<c:otherwise>
	 	
	 	</c:otherwise>
	 </c:choose>	 
	 </div>
</div>