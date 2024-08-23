package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.vo.PageVO;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
		
	@Autowired
	private MemberDao memberDao;
	
	
	//회원 관리 목록
	@RequestMapping("/list")
	public String list(
			@ModelAttribute("pageVO") PageVO pageVO, Model model) {
			model.addAttribute("memberList", memberDao.selectListByPaging(pageVO));
			int count = memberDao.countWithPaging(pageVO);
			pageVO.setCount(count);
		
		return "/WEB-INF/views/admin/member/list.jsp";
	}
	//재적 기능(미완성)
	@GetMapping("/block")
	public String takeOff(@RequestParam String takeOffTarget, Model model) {
		return "/WEB-INF/views/member/block.jsp";
	}

}
