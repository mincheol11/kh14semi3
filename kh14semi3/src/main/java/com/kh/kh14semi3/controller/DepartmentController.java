package com.kh.kh14semi3.controller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.DepartmentDao;
import com.kh.kh14semi3.dto.DepartmentDto;

@Controller
@RequestMapping("/admin/department")
public class DepartmentController {

	@Autowired
	private DepartmentDao departmentDao;
	@Transactional

	//학과 증설
	@GetMapping("/expand")
	public String expand() {
		return "/WEB-INF/views/admin/department/expand.jsp";
	}
	@PostMapping("/expand")
	public String expand(@ModelAttribute DepartmentDto departmentDto) {
		departmentDao.insert(departmentDto);
		//학과 상세정보 이동
		return "redirect:detail?departmentCode="+departmentDto.getDepartmentCode();
	}
		
	//학과 상세정보
	@RequestMapping("detail")
	public String detail(@RequestParam int departmentCode, Model model) {
		DepartmentDto departmentDto = departmentDao.selectOne(departmentCode);
		model.addAttribute("departmentDto", departmentDto);
		return "/WEB-INF/views/admin/department/detail.jsp";
	}
	
	//학과 시스템 관리
	@RequestMapping("list")
	public String list(Model model,
			@RequestParam(required = false) String column,
			@RequestParam(required = false) String keyword) {
		//목록
		boolean isSearch = column != null && keyword !=null;
		//검색
		List<DepartmentDto> list = isSearch?
				departmentDao. selectList(column, keyword) : departmentDao.selectList();
		model.addAttribute("column", column);
		model.addAttribute("keyword", keyword);
		model.addAttribute("list", list);
		return "/WEB-INF/views/admin/department/list.jsp";
	}
	
}
