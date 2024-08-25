<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="container w-600 my-10 center">
    <div class="row mb-0">
        <!-- <h2>페이지 네비게이터</h2> -->
        <span>${pageVO.page} / ${pageVO.lastBlock} 페이지</span>
    </div>
    <div class="row mt-0">
        <div class="pagination">
            <c:choose>
                <c:when test="${pageVO.hasPrev()}">
                    <a href="list?page=${pageVO.getPrevBlock()}&column=${param.column}&keyword=${param.keyword}"><i class="fa-solid fa-chevron-left"></i></a>
                </c:when>
                <c:otherwise>
                    <i class="fa-solid fa-chevron-left"></i>
                </c:otherwise>
            </c:choose>	<%-- startBlock부터 finishBlock과 lastBlock중 작은값까지 반복문으로 링크 출력 --%>            
            <c:forEach var="n" begin="${pageVO.getStartBlock()}" end="${pageVO.getFinishBlock()}" step="1">
                <c:choose>
                    <c:when test="${param.page==n}">
                        <a class="on">${n}</a>
                    </c:when>
                    <c:otherwise>
                        <a href="list?page=${n}&column=${param.column}&keyword=${param.keyword}">${n}</a>
                    </c:otherwise>
                </c:choose>		
            </c:forEach>
            <c:choose> <%-- 다음 버튼은 마지막 구간이 아닐 때(finishBlock < lastBlock) 나온다 --%>
                <c:when test="${pageVO.hasNext()}">		
                    <a href="list?page=${pageVO.getNextBlock()}&column=${param.column}&keyword=${param.keyword}"><i class="fa-solid fa-chevron-right"></i></a>
                </c:when>
                <c:otherwise>
                    <i class="fa-solid fa-chevron-right"></i>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>