<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.campus > .fa-solid,fa-regular{
		color: #2D3436;
	}
</style>
    
			</div>
		</div>
		
		<!-- 하단(Footer) -->
		<%-- <hr> --%>
			
		<div class="row my-0 flex-box flex-core column-3 kh-footer">
			
		    <div class="w-50">
		        <div class="row center">
		            <h3>KH 대학교</h3>
		            <div>서울시 어쩌구 아무동 OOO-OOO</div>
		            <div>이사장 : 권이사장</div>
		            <div>총장 : 권총장</div>
		            <div>문의전화 : OOO-OOOO-OOOO</div>
		        </div>
		    </div>
			    
		    <div class="w-25">			    
		        <div class="row center">
		            <h3>캠퍼스 정보</h3>
		            <div>
		            	<a href="${pageContext.request.contextPath}/home/map?mapW=gangNam" data-lat="37.499" data-lng="127.0328" class="link link-animation campus">강남 캠퍼스
		                <i class="fa-solid fa-square-arrow-up-right"></i></a>
		            </div>
		            <div>
		            	<a href="${pageContext.request.contextPath}/home/map?mapW=jongRo" data-lat="37.5679" data-lng="126.983" class="link link-animation campus">종로 캠퍼스
		                <i class="fa-solid fa-square-arrow-up-right"></i></a>
		            </div>
		            <div>
		            	<a href="${pageContext.request.contextPath}/home/map?mapW=dangSan"  data-lat="37.533826" data-lng="126.896837" class="link link-animation campus">당산 캠퍼스
		                <i class="fa-solid fa-square-arrow-up-right"></i></a>
		            </div>
				</div>
		    </div>
			    
		    <!-- <div class="w-25">
		    	<div class="row">
		            <h3>KH 대학교</h3>
		        	<div>
		            	<a href="#" class="link link-animation items">개인정보 처리방침
		                <i class="fa-solid fa-square-arrow-up-right"></i></a>
		        	</div>
		        	<div>
		            	<a href="#" class="link link-animation items">대학정보공시
		                <i class="fa-solid fa-square-arrow-up-right"></i></a>
		        	</div>
		        	<div>
		            	<a href="#" class="link link-animation items">예결산공고
		                <i class="fa-solid fa-square-arrow-up-right"></i></a>
		        	</div>
		        	<div>
		            	<a href="#" class="link link-animation items">이용약관
		                <i class="fa-solid fa-square-arrow-up-right"></i></a>
		        	</div>
		        	<div>
		            	<a href="#" class="link link-animation items">공익 신고
		                <i class="fa-solid fa-square-arrow-up-right"></i></a>
		        	</div>
	    		</div>
			</div> -->	
					
		</div>	
	
	</body>
</html>