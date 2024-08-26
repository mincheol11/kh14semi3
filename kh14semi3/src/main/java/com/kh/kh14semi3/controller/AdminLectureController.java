package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.kh14semi3.dao.AdminLectureDao;
import com.kh.kh14semi3.dto.AdminLectureDto;
import com.kh.kh14semi3.dto.LectureDto;

@Controller
@RequestMapping("/admin/lecture")
public class AdminLectureController {
	@Autowired
	private AdminLectureDao adminLectureDao;
	
	//강의 추가
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/lecture/add.jsp";
	}
	@PostMapping("/add")
	public String add(@ModelAttribute LectureDto lectureDto) {
		adminLectureDao.add(lectureDto);
		//학과 상세정보 이동
		return "redirect:detail?lectureCode="+lectureDto.getLectureCode();
	}
}
