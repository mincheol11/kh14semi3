package com.kh.kh14semi3.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.AdminDepartmentDao;
import com.kh.kh14semi3.dto.AdminDepartmentDto;
import com.kh.kh14semi3.vo.PageVO;


@Controller
@RequestMapping("/admin/department")
public class AdminDepartmentController {

	@Autowired
	private AdminDepartmentDao adminDepartmentDao;

	//학과 증설
	@GetMapping("/expand")
	public String expand() {
		return "/WEB-INF/views/admin/department/expand.jsp";
	}
	@PostMapping("/expand")
	public String expand(@ModelAttribute AdminDepartmentDto adminDepartmentDto) {
		adminDepartmentDao.insert(adminDepartmentDto);
		//학과 상세정보 이동
		return "redirect:list";
//		return "redirect:detail?departmentCode="+adminDepartmentDto.getDepartmentCode();
	}
	
	//학과 상세정보
	@RequestMapping("detail")
	public String detail(@RequestParam int departmentCode, Model model) {
		AdminDepartmentDto adminDepartmentDto = adminDepartmentDao.selectOne(departmentCode);
		model.addAttribute("adminDepartmentDto", adminDepartmentDto);
		return "/WEB-INF/views/admin/department/detail.jsp";
	}
	
	//학과 시스템 관리
//	@RequestMapping("list")
//	public String list(Model model,
//			@RequestParam(required = false) String column,
//			@RequestParam(required = false) String keyword) {
//		//목록
//		boolean isSearch = column != null && keyword !=null;
//		//검색
//		List<AdminDepartmentDto> list = isSearch?
//				adminDepartmentDao. selectList(column, keyword) : adminDepartmentDao.selectList();
//		model.addAttribute("column", column);
//		model.addAttribute("keyword", keyword);
//		model.addAttribute("list", list);
//		return "/WEB-INF/views/admin/department/list.jsp";
//	}
	
	@RequestMapping("/list")
	public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
		model.addAttribute("adminDepartmentList", adminDepartmentDao.selectListByPaging(pageVO));
		int count = adminDepartmentDao.countByPaging(pageVO);
		pageVO.setCount(count);
		return "/WEB-INF/views/admin/department/list.jsp";
	}
	
}
