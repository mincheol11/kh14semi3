<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 
	문서 설정
	 - HTML 버전 지정(기본 설정은 HTML 5)
	 - 무조건 작성해야함, 대소문자 구분X
-->
<!Doctype HTML>
<html> <!-- HTML 문서의 범위를 나타내는 태그 -->
	<head> <!-- 문서의 정보를 표시하는 태그 (각 탭에 적히는 내용)-->
		<title>나의 홈페이지</title>
		<meta charset="UTF-8"> <!-- jsp에 정의해서 중복되지만 HTML만 사용할 때는 써야함 -->
		
		<!-- google font cdn -->
	    <link rel="preconnect" href="https://fonts.googleapis.com">
	    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	   
	    <!-- my css (절대주소 필수) -->
	    <link rel="stylesheet" type="text/css" href="/css/commons.css">
	    <link rel="stylesheet" type="text/css" href="/css/commons.css">
		<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> --> 
	
	    <!-- font awesome icon cdn-->
	    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
	    
	    <!-- 자바스크립트 -->
	    
	    <!-- moment cdn (시간 관련 js) -->
		<script src="https://cdn.jsdelivr.net/npm/moment@2.30.1/moment.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/locale/ko.min.js"></script>
	    
	    <!-- jquery cdn -->
	    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
	    <!-- my jquery library (무조건 jquery cdn 뒤에 있어야 제대로 돌아간다!)-->
	    <script src="/js/checkbox.js"></script>
	    <script src="/js/confirm-link.js"></script>	    
	    <script src="/js/multipage.js"></script>
	    
	    <!-- chart.js cdn -->
    	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	    
	    <!-- swiper cdn -->
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
	    <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
		    
	    <style>	    
        .profile{
        	border: 1px solid black;
        	border-top: none;
            border-left: none;
            border-bottom: none;
            padding-left: 0;
            padding-right: 0;
            border-radius: 0;
        }
	    </style>
	</head>
	<body>
	
	<div class="container w-1400">
		
	        <div class="row my-0 flex-box">
	            <div class="w-25 flex-core">
	                <img src="https://placehold.co/295x70">
	            </div>
	            <div class="w-50">
	                <h2 class="center">KH 대학교 학사정보사이트</h2>
	            </div>
	            <div class="w-25 flex-core">
	                <img src="https://placehold.co/295x70">
	            </div>
	        </div>	      
	          
	        <hr>
	        
	        <div class="row my-0 flex-box" style="min-height: 400px;">
	        
	        <%-- menu.jsp에 존재하는 내용을 불러오도록 설정 --%>
			<jsp:include page="/WEB-INF/views/template/menu.jsp"></jsp:include>
			
			<div style="flex-grow: 1;">
