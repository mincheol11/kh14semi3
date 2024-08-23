package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.dto.MemberDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
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



	//회원 상세
	@RequestMapping("/detail")
	public String detail(Model model, @RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/admin/member/detail.jsp";
	}
	
	//회원 삭제
	@RequestMapping("/delete")
	public String delete(@RequestParam String memberId) {
		boolean result = memberDao.delete(memberId);
		if(result == false)
			throw new TargetNotFoundException("존재하지 않는 회원ID");
		return "redirect:list";
	}
	

}
