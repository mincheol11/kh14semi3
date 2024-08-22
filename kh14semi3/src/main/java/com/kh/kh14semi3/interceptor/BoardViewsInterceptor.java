package com.kh.kh14semi3.interceptor;

import java.util.HashSet;

import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.kh14semi3.dao.BoardDao;
import com.kh.kh14semi3.dto.BoardDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;





@Service
public class BoardViewsInterceptor implements HandlerInterceptor {

	@Autowired
	private BoardDao boardDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String createdUser = (String) session.getAttribute("createdUser");
		if(createdUser == null) {
			return true;
		}
		
		int boardNo = Integer.parseInt(request.getParameter("boardNo"));
		BoardDto boardDto = boardDao.selectOne(boardNo);
		
		if(createdUser.equals(boardDto.getBoardWriter())) {
			return true;
		}
		
		
		Set<Integer> history = (Set<Integer>) session.getAttribute("history");
		if(history == null) {
			history = new HashSet<>();
		}
		if(history.add(boardNo) ) {
		boardDao.updateBoardViews(boardNo);
		}
		
		//session.setAttribute("history", history);
		return true;
	}
	
}

