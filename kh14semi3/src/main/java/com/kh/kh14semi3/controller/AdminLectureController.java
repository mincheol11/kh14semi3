package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.AdminLectureDao;
import com.kh.kh14semi3.dao.DepartmentDao;
import com.kh.kh14semi3.dao.LectureDao;
import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.dto.DepartmentDto;
import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.dto.MemberDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
import com.kh.kh14semi3.vo.LectureMemberVO;
import com.kh.kh14semi3.vo.PageVO;


@Controller
@RequestMapping("/admin/lecture")
public class AdminLectureController {
	@Autowired
	private AdminLectureDao adminLectureDao;
	@Autowired
	private LectureDao lectureDao;
	@Autowired
	private DepartmentDao departmentDao;
	@Autowired
	private MemberDao memberDao;
	
	//강의 추가
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/lecture/add.jsp";
	}
	@PostMapping("/add")
	public String add(@ModelAttribute LectureDto lectureDto) {
//		System.out.println("lectureDto : "+lectureDto);
		adminLectureDao.add(lectureDto);
		//학과 상세정보 이동
		return "redirect:detail?lectureCode="+lectureDto.getLectureCode();
	}
	
	//학과 상세정보
	@RequestMapping("detail")
	public String detail(@RequestParam String lectureCode, Model model) {
		LectureDto lectureDto = lectureDao.selectOne(lectureCode);
		if(lectureDto == null) throw new TargetNotFoundException("미등록 강의 입니다.");
		model.addAttribute("lectureDto", lectureDto);
		
		DepartmentDto departmentDto =  departmentDao.selectOne(lectureDto.getLectureDepartment());
		model.addAttribute("departmentDto", departmentDto);
		
		MemberDto memberDto = memberDao.selectOne(lectureDto.getLectureProfessor());
		model.addAttribute("memberDto", memberDto);
		
		return "/WEB-INF/views/admin/lecture/detail.jsp";
	}
		
	//학과 시스템 관리
	@RequestMapping("list")
	public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
		model.addAttribute("lectureList", lectureDao.selectListByPaging(pageVO));
		int count = lectureDao.countByPaging(pageVO);
		pageVO.setCount(count);
		return "/WEB-INF/views/admin/lecture/list.jsp";
	}
	
	//학과 통폐합
	@RequestMapping("/remove")
	public String remove(@RequestParam String lectureCode, @ModelAttribute PageVO pageVO) {
		boolean result = adminLectureDao.remove(lectureCode);
		if(result == false)
			throw new TargetNotFoundException("존재하지 않는 학과입니다.");
		return "redirect:list?page=" + pageVO.getPage() + "&message=remove"; 
	}
	
	//학과 상세정보 수정
	@GetMapping("/edit")
	public String edit(Model model, @RequestParam String lectureCode) {
		LectureDto lectureDto = adminLectureDao.selectOne(lectureCode);
		if(lectureDto == null) throw new TargetNotFoundException();
		model.addAttribute("lectureDto", lectureDto);
		return "/WEB-INF/views/admin/lecture/edit.jsp";
	}
	@PostMapping("/edit")
	public String edit(@ModelAttribute LectureDto lectureDto) {
		boolean result = adminLectureDao.edit(lectureDto);
		if(result == false) throw new TargetNotFoundException("수정할 학과가 없습니다.");
		return "redirect:detail?lectureCode="+lectureDto.getLectureCode()  + "&message=edit";
	}
		
			
			
}
