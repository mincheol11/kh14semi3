package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.dto.MemberDto;


import jakarta.servlet.http.HttpSession;

@Controller

@RequestMapping("/member")

public class MemberController {
	@Autowired
	private MemberDao memberDao;
	//로그인
	@GetMapping("/login")
	public String login() {
		return "/WEB-INF/views/member/login.jsp";
	}
	@PostMapping("/login")
	public String login(@RequestParam String memberId,
								@RequestParam String memberPw,
								HttpSession session) {
//		public String login(@ModelAttribute MemberDto memberDto) {
		//1. 아이디에 해당하는 정보(MemberDto)를 불러옴
		//->없으면 실패
		//2. MemberDto와 비밀번호를 비교
		//->안맞으면 실패
		//3. 1,2 다 성공시 성공
		
		//1번
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) return "redirect:/member/login?error"; //redirect는 get으로 감
		
		//2번
//		System.out.println("memberPw : "+memberPw);
//		System.out.println("memberDto.getMemberPw() : "+memberDto.getMemberPw());
		boolean isValid = memberPw.equals(memberDto.getMemberPw());
//		System.out.println("isValid : "+isValid);
		if(isValid == false) return "redirect:/member/login";
		
//		//3번 차단
//		BlockDto blockDto = blockDao.selectLastOne(memberId);
//		boolean isBlock = blockDto != null && blockDto.getBlockType().equals("차단");
//		if (isBlock)
//			return "redirect:/member/block";
		
		//4번
		session.setAttribute("createdUser", memberId);
		session.setAttribute("createdRank", memberDto.getMemberRank());
		return "redirect:/home/main"; //성공시 메인으로
	}
	
}
