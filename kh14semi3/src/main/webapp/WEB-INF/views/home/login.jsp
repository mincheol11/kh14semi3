<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
 <%@ taglib prefix= "c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
       
    
    <form action="login" method="post" autocomplete="off">
    <div class="container w-400 my-50">
    	<div class="row center">
    		<h1>환영합니다.</h1>
    		<h2>Kh 대학교</h2>
    	</div>
		<div>
			<a href="/member/login" class="btn btn-positive w-100">로그인</a>
		</div>
		</div>
</form>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>	