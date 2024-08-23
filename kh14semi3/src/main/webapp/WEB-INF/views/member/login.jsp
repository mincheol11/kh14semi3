<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix= "c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
       
    
    <form action="login" method="post" autocomplete="off">
    <div class="container w-400 my-50">
    	<div class="row center">
    		<h1>로그인</h1>
    	</div>
    
    
    </div>
    	아이디<input type="text" name="memberId" required><br>
    	비밀번호<input type="text" name="memberPw" required><br>
    	<button>로그인</button>
    </form>
    
    <c:if test="${parm.error != null }">
    	<h3 style="color:red">아이디 또는 비밀번호가 잘못 되었습니다.</h3>
    </c:if>