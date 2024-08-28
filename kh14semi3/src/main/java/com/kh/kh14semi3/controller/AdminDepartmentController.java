package com.kh.kh14semi3.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.AdminDepartmentDao;
import com.kh.kh14semi3.dto.DepartmentDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
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
	public String expand(@ModelAttribute DepartmentDto departmentDto) {
		adminDepartmentDao.insert(departmentDto);
		//학과 상세정보 이동
		return "redirect:detail?departmentCode="+departmentDto.getDepartmentCode();
	}
	
	//학과 상세정보
	@RequestMapping("detail")
	public String detail(@RequestParam String departmentCode, Model model) {
		DepartmentDto departmentDto = adminDepartmentDao.selectOne(departmentCode);
		model.addAttribute("departmentDto", departmentDto);
		return "/WEB-INF/views/admin/department/detail.jsp";
	}
	
	//학과 시스템 관리
	@RequestMapping("list")
	public String list(@ModelAttribute("pageVO") PageVO pageVO, Model model) {
		model.addAttribute("departmentList", adminDepartmentDao.selectListByPaging(pageVO));
		int count = adminDepartmentDao.countByPaging(pageVO);
		pageVO.setCount(count);
		return "/WEB-INF/views/admin/department/list.jsp";
	}
	
	//학과 통폐합
	@RequestMapping("/reduce")
	public String reduce(@RequestParam String departmentCode, @ModelAttribute PageVO pageVO) {
		boolean result = adminDepartmentDao.reduce(departmentCode);
		if(result == false)
			throw new TargetNotFoundException("존재하지 않는 학과입니다.");
		return "redirect:list?page=" + pageVO.getPage() + "&message=reduce"; 
	}
	
	//학과 상세정보 수정
		@GetMapping("/edit")
		public String edit(Model model, @RequestParam String departmentCode) {
			DepartmentDto departmentDto = adminDepartmentDao.selectOne(departmentCode);
			if(departmentDto == null) throw new TargetNotFoundException();
			model.addAttribute("departmentDto", departmentDto);
			return "/WEB-INF/views/admin/department/edit.jsp";
		}
		@PostMapping("/edit")
		public String edit(@ModelAttribute DepartmentDto departmentDto) {
			boolean result = adminDepartmentDao.edit(departmentDto);
			if(result == false) throw new TargetNotFoundException("수정할 학과가 없습니다.");
			return "redirect:detail?departmentCode="+departmentDto.getDepartmentCode()+ "&message=edit";
		}
}
