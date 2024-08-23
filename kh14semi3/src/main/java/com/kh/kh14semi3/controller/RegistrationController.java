package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.kh14semi3.dao.DepartmentDao;
import com.kh.kh14semi3.dao.LectureDao;
import com.kh.kh14semi3.dao.RegistrationDao;
import com.kh.kh14semi3.dto.StudentDto;
import com.kh.kh14semi3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/registration")
public class RegistrationController {
	
	@Autowired
	private RegistrationDao registrationDao;
	@Autowired
	private LectureDao lectureDao; 
	@Autowired
	private DepartmentDao departmentDao;
	
	// 강의 전체 목록 + 검색 기능
	@RequestMapping("/list")
	public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
		model.addAttribute("lectureList", lectureDao.selectListByPaging(pageVO));
		model.addAttribute("departmentList", departmentDao.selectListByPaging(pageVO));
		int count = lectureDao.countByPaging(pageVO);
		pageVO.setCount(count);
		return "/WEB-INF/views/registration/list.jsp";
	}
	
	// 로그인 중인 유저가 수강 신청한 강의 목록을 조회
	@RequestMapping("/regist")
	public String regist(HttpSession session, Model model) {
		String studentId = (String) session.getAttribute("createdUser");
		model.addAttribute("RegistrationList", lectureDao.selectListByRegistration(studentId));
		return "/WEB-INF/views/registration/regist.jsp";
	}
	
	
}
