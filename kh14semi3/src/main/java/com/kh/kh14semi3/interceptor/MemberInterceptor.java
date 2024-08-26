package com.kh.kh14semi3.interceptor;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class MemberInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//목표 : 로그인 한 사람은 통과, 아닌 사람은 차단(+로그인페이지 이동)
		HttpSession session = request.getSession();
		String createdUser = (String)session.getAttribute("createdUser");
		
		boolean isLogin = createdUser != null; 
		
		if(isLogin) {//로그인 한 사람이라면
			return true;//통과
		}
		else {//로그인 안한 사람이라면
			response.sendRedirect("/member/login");//로그인페이지로 추방
			//response.sendError(401);//401번은 권한 없음(Unauthorized)
			return false;//차단
		}
	}
}
