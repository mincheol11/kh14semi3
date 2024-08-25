package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.dto.MemberDto;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
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
								@RequestParam(required = false) String remember,//아이디 저장하기 기능넣을시 활용용
								HttpSession session, HttpServletResponse response) {
		//1. 아이디에 해당하는 정보(MemberDto)를 불러옴
		//->없으면 실패
		//2. MemberDto와 비밀번호를 비교
		//->안맞으면 실패
		//3.차단회원 차단 되게 
		//4. 1,2,3 다 성공시 로그인 성공
		
		//1번
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) return "redirect:/member/login?error"; //redirect는 get으로 감
		
		//2번
		boolean isValid = memberPw.equals(memberDto.getMemberPw());
		if(isValid == false) return "redirect:/member/login?error"; //
		
//		//3번 차단
//		BlockDto blockDto = blockDao.selectLastOne(memberId);
//		boolean isBlock = blockDto != null && blockDto.getBlockType().equals("차단");
//		if (isBlock)
//			return "redirect:/member/block";
		
		//4번
		session.setAttribute("createdUser", memberId);
		session.setAttribute("createdRank", memberDto.getMemberRank()); //? 관리자 메뉴추가할때 썼던 코드
//		memberDao.updateMemberLogin(memberId); 최종 로그인 시각이 반영되도록 할때 필요한 코드
		
		//쿠키를 사용한 아이디저장 기능 코드
		if(remember != null) {//아이디저장체크o
			Cookie ck = new Cookie("saveId", memberId);//쿠키생성
			ck.setMaxAge(4 * 7 * 24 * 60 * 60); //기간4주
			response.addCookie(ck);
		}
		else {//아이디저장체크x
			Cookie ck = new Cookie("saveId", memberId);//쿠키생성
			ck.setMaxAge(0); //0초=삭제
			response.addCookie(ck);
		}

		
		return "redirect:/home/main"; //성공시 메인으로
}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("createdRank"); // ? 관리자 메뉴추가 할때 썻던 코드
		return "redirect:/";
	}
	
}
