<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
 
<h1>제적을 당했습니다.</h1>


createdUser = ${sessionScope.createdUser} , 
createdRank = ${sessionScope.createdRank}
	
  <p>
    궁금한 사항이 있으시면 학부에 연락 부탁드리겠습니다.
 </p>
    <a href="logout">로그아웃</a>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include> 