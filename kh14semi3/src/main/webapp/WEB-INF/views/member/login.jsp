<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix= "c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
       
    
    <form action="login" method="post" autocomplete="off">
    <div class="container w-400 my-50">
    	<div class="row center">
    		<h1>Kh 대학교 로그인</h1>
    	</div>
    	<div class="row">
    		<label>아이디</label> 
    		<input type="text" name="memberId" class="field w-100"
    																			value="${cookie.saveId.value}">
    	</div>
		<div class="row">
			<label>비밀번호</label> <input type="password" name="memberPw" class="field w-100">
		</div>
		
		<%--쿠키를 이용한 아이디저장 체크박스 --%>
		<div class="row">
		<label>
			<input type="checkbox" name="remember" 
			<c:if test="${cookie.saveId != null}">checked</c:if>>
			<span>아이디 저장</span>
		</label>
		</div>

		<div>
			<button class="btn btn-positive w-100" >로그인</button>	
		</div>
		
		<c:if test="${param.error != null}">
			<div class="row center">
				<h3 style="color: red">아이디 또는 비밀번호가 잘못되었습니다</h3>
			</div>
		</c:if>
		
	</div>
</form>