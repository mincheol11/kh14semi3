package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.GradeDao;
import com.kh.kh14semi3.dao.LectureDao;
import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
import com.kh.kh14semi3.vo.PageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/lecture")
public class LectureController {
	
	@Autowired
	private LectureDao lectureDao;
	@Autowired
	private GradeDao gradeDao;
	
	// 강의 전체 목록 + 검색 기능
	// 학생이면 수강중인 강의 목록을 보여주고 교수라면 가르치는 강의 목록을 보여준다
	@RequestMapping("/list")
	public String list(HttpSession session, @ModelAttribute("PageVO") PageVO pageVO, Model model) {
		// 학생인지 교수인지 알 수 없으므로 memberId로 표현
		String memberId = (String) session.getAttribute("createdUser");
		// 학생이 수강중인 강의 목록을 전송
		model.addAttribute("RegistrationList", lectureDao.selectListByRegistration(pageVO, memberId));
		// 교수가 가르치는 강의 목록을 전송
		model.addAttribute("ProfessorList", lectureDao.selectListByTeaching(pageVO, memberId));
		int count = lectureDao.countByPaging(pageVO);
		pageVO.setCount(count);
		return "/WEB-INF/views/lecture/list.jsp";
	}
	
	// 강의 상세 정보
	@RequestMapping("/detail")
	public String detail(@RequestParam String lectureCode, Model model) {
		LectureDto lectureDto = lectureDao.selectOne(lectureCode); // 조회
		if(lectureDto == null) throw new TargetNotFoundException("미등록 강의 입니다.");
		model.addAttribute("lectureDto", lectureDto);
		return "/WEB-INF/views/lecture/detail.jsp";
	}
	
	// 성적 조회
	@RequestMapping("/grade")
	public String grade(@ModelAttribute("PageVO") PageVO pageVO, Model model) {		
		model.addAttribute("gradeList", gradeDao.selectListByPaging(pageVO));
		int count = gradeDao.countByPaging(pageVO);
		pageVO.setCount(count);
		return "/WEB-INF/views/lecture/grade.jsp";
	}
	
	// 성적 입력
	@RequestMapping("/grade/insert")
	public String gradeInsert() {
		return "/WEB-INF/views/lecture/gradeInsert.jsp";
	}
	
}
