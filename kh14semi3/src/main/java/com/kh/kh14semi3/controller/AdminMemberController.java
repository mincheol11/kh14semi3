package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
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
	
	//관리자 - 회원가입
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/admin/member/join.jsp";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "redirect:list";
	}
	
	//관리자 - 회원 정보 수정
	@GetMapping("/change")
	public String change(@RequestParam String memberId, Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null)
			throw new TargetNotFoundException("존재하지 않는 회원입니다.");
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/admin/member/change.jsp";
	}
//	@PostMapping("/change")
//	public String change(@ModelAttribute MemberDto memberDto) {
//		boolean result = memberDao.updateMemberByAdmin(memberDto);
//		if(result == false)
//			throw new TargetNotFoundException("존재하지 않는 회원ID입니다.");
//		return "redirect:detail?memberId="+memberDto.getMemberId();
//	}
	
}
