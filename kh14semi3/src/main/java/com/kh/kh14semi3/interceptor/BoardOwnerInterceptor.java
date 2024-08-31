package com.kh.kh14semi3.interceptor;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.kh14semi3.dao.BoardDao;
import com.kh.kh14semi3.dto.BoardDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class BoardOwnerInterceptor implements HandlerInterceptor  {

	// (주의) 인터셉터에서 DB를 가게 만들면 성능저하가 심하다 (반드시 필요한 경우에만)
	@Autowired
	private BoardDao boardDao;
			
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
				
		// 수정과 삭제 페이지는 본인만 접근 가능하도록 설정
		
		// 사전검사 : 관리자의 경우는 무조건 통과
		HttpSession session = request.getSession();
		String createdRank = (String) session.getAttribute("createdRank");
		boolean isAdmin = createdRank != null && createdRank.equals("관리자");
		boolean isDelete = request.getRequestURI().equals("/board/delete");
		if(isAdmin && isDelete) return true;		
		
		// 현재 로그인한 회원의 아이디 조회 (HttpSession)		
		String createdUser = (String) session.getAttribute("createdUser");
		if(createdUser==null) {
			//response.sendError(401, "You do not have any authority for acess.");
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You do not have any authority for acess.");
			return false;		
		}
		
		// 해당 개시글의 번호를 추출하여 작성자 조회 (Parameter)
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDto boardDto = boardDao.selectOne(boardNo);
					
		// 작성자와 회원의 아이디가 같은지 확인
		boolean isOwner = createdUser.equals(boardDto.getBoardWriter());
		
		if(isOwner) {
			return true;			
		}
		else {
			//response.sendError(403, "You do not have any authority for acess.");
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You do not have any authority for acess.");
			return false;
		}
		
	}
	
}
