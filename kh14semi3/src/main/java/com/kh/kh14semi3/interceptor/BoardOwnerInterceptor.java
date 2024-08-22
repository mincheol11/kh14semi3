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
	
	@Autowired BoardDao boardDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String createdLevel =(String) session.getAttribute("createdLevel");
		boolean isAdmin = createdLevel != null && createdLevel.equals("관리자");
		boolean isDelete = request.getRequestURI().equals("/board/delete");
		
		if(isAdmin && isDelete) {
			return true;
		}
		String createdUser = (String)session.getAttribute("createdUser");
		if(createdUser == null) {
			response.sendError(401);
			return false;
		}
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDto boardDto = boardDao.selectOne(boardNo);
		boolean isOwner = createdUser.equals(boardDto.getBoardWriter());
		if(isOwner) {
			return true;
		}
		else {
			response.sendError(403);
			return false;
		}
				
	}
	}
