package com.kh.kh14semi3.interceptor;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.kh14semi3.dao.ScheduleDao;
import com.kh.kh14semi3.dto.ScheduleDto;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Service
public class ScheduleInterceptor implements HandlerInterceptor{

	@Autowired 
	private ScheduleDao scheduleDao;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		String createdRank =(String) session.getAttribute("createdRank");
		boolean isAdmin = createdRank != null && createdRank.equals("관리자");
		boolean isDelete = request.getRequestURI().equals("/schedule/delete");
		if(isAdmin && isDelete) return true;
		
		String createdUser = (String)session.getAttribute("createdUser");
		if(createdUser == null) {
			//response.sendError(401, "You do not have any authority for acess.");
			response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You do not have any authority for acess.");
			return false;
		}
		
		int scheduleNo = Integer.parseInt(request.getParameter("scheduleNo"));
		ScheduleDto scheduleDto = scheduleDao.selectOne(scheduleNo);
		
		boolean isOwner = createdUser.equals(scheduleDto.getScheduleWriter());
		
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