 package com.kh.kh14semi3.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.configuration.CustomCertProperties;
import com.kh.kh14semi3.dao.AdminDao;
import com.kh.kh14semi3.dao.CertDao;
import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.dao.ProfessorDao;
import com.kh.kh14semi3.dao.StudentDao;
import com.kh.kh14semi3.dao.TakeOffDao;
import com.kh.kh14semi3.dto.AdminDto;
import com.kh.kh14semi3.dto.CertDto;
import com.kh.kh14semi3.dto.MemberDto;
import com.kh.kh14semi3.dto.ProfessorDto;
import com.kh.kh14semi3.dto.StudentDto;
import com.kh.kh14semi3.dto.TakeOffDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
import com.kh.kh14semi3.service.EmailService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller

@RequestMapping("/member")

public class MemberController {
	
	@Autowired
	private PasswordEncoder encoder; 
	
	@Autowired
	private EmailService emailService;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private CertDao certDao;
	
	@Autowired
	private CustomCertProperties customCertProperties;
	
	@Autowired
	private TakeOffDao takeOffDao;	
	
	@Autowired
	private StudentDao studentDao;
	
	@Autowired
	private ProfessorDao professorDao;
	
	@Autowired
	private AdminDao adminDao;
	
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
		String rawPw = memberDto.getMemberPw(); // Db에 있는 비밀번호

		boolean isValid = encoder.matches(memberPw,rawPw);
		if (!isValid) {
		    return "redirect:/member/login?error";
		}
		
		StudentDto studentDto = studentDao.selectOne(memberId);
		ProfessorDto professorDto = professorDao.selectOne(memberId);
		AdminDto adminDto = adminDao.selectOne(memberId);
		boolean nullCheck = memberDto != null && studentDto == null 
									&& professorDto == null && adminDto == null;
		if(nullCheck) {
			return "redirect:/member/login?error";
		}
		
		
		//3번 차단
		TakeOffDto takeOffDto = takeOffDao.selectLastOne(memberId);
		boolean isBlock = takeOffDto != null && takeOffDto.getTakeOffType().equals("제적");
		if (isBlock)
			return "redirect:block";
		
		//4번
		session.setAttribute("createdUser", memberId);
		session.setAttribute("createdRank", memberDto.getMemberRank()); //? 관리자 메뉴추가할때 썼던 코드
//		memberDao.updateMemberLogin(memberId); 최종 로그인 시각이 반영되도록 할때 필요한 코드
		
		//쿠키를 사용한 아이디저장 기능 코드
		if(remember != null) {//아이디저장체크o
			Cookie ck = new Cookie("saveId", memberId);//쿠키생성
			ck.setPath("/");
			ck.setMaxAge(4 * 7 * 24 * 60 * 60); //기간4주
			response.addCookie(ck);
		}
		else {//아이디저장체크x
			Cookie ck = new Cookie("saveId", memberId);//쿠키생성
			ck.setPath("/");
			ck.setMaxAge(0); //0초=삭제
			response.addCookie(ck);
		}		
		return "redirect:/home/main"; //성공시 메인으로
	}
	
	//로그아웃 필요없으면 주석 처리하세용
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("createdUser");
		session.removeAttribute("createdRank"); // ? 관리자 메뉴추가 할때 썻던 코드
		return "redirect:/home/main";
	}
	
	//비밀번호 찾기(재설정 링크 방식)
	@GetMapping("/findPw")
	public String findPw() {
		return "/WEB-INF/views/member/findPw.jsp";
	}
	
	@PostMapping("/findPw")
	public String findPw(@RequestParam(required = true) String memberId,
	                     @RequestParam(required = true) String memberEmail) throws IOException, MessagingException {
	    // 아이디로 회원 정보 조회
	    MemberDto memberDto = memberDao.selectOne(memberId);
	    if(memberDto == null) {
	        return "redirect:findPw?error";
	    }
	    // 이메일 비교
	    if(!memberEmail.equals(memberDto.getMemberEmail())) {
	        return "redirect:findPw?error";
	    }
	    // 템플릿을 불러와 재설정 메일 발송
	    emailService.sendResetPw(memberId, memberEmail);
	    return "redirect:findPwFinish";
	}

	
	@RequestMapping("/findPwFinish")
	public String findPwFinish() {
		return "/WEB-INF/views/member/findPwFinish.jsp";
	}	
	
	
	//비밀번호 변경(홈페이지에서 로그인 했을 경우)
	@GetMapping("/changePw")
	public String changePw() {
		return "/WEB-INF/views/member/changePw.jsp";
	}
	
	@PostMapping("/changePw")
	public String changePw(@RequestParam(required = true) String memberId,
			@RequestParam(required = true) String memberEmail) throws IOException, MessagingException {
		// 아이디로 회원 정보 조회
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto == null) {
			return "redirect:changePw?error";
		}
		// 이메일 비교
		if(!memberEmail.equals(memberDto.getMemberEmail())) {
			return "redirect:changePw?error";
		}
		// 템플릿을 불러와 재설정 메일 발송
		emailService.sendResetPw(memberId, memberEmail);
		return "redirect:changePwFinish";
	}
	
	
	@RequestMapping("/changePwFinish")
	public String changePwFinish() {
		return "/WEB-INF/views/member/changePwFinish.jsp";
	}	
	
	//비밀번호 재설정 페이지
	@GetMapping("/resetPw") 
	public String resetPw(@ModelAttribute CertDto certDto,
						@RequestParam String memberId,
							Model model) {
		boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
		if(isValid) {			
			model.addAttribute("certDto", certDto);
			model.addAttribute("memberId", memberId);
			return "/WEB-INF/views/member/resetPw.jsp";
		}
		else {
			throw new TargetNotFoundException("올바르지 않은 접근");
		}
	}
	
	@PostMapping("/resetPw")
	public String resetPw(@ModelAttribute CertDto certDto,
									@ModelAttribute MemberDto memberDto) {
		//인증정보확인
		boolean isValid = certDao.check(certDto, customCertProperties.getExpire());
		if(!isValid) {
			throw new TargetNotFoundException("올바르지 않은 접근");
		}
		//인증성공시 인증번호 삭제(1회접근페이지)
		certDao.delete(certDto.getCertEmail());
		
		//비밀번호변경
		memberDao.updateMemberPw(
				memberDto.getMemberId(), memberDto.getMemberPw());
		return "redirect:resetPwFinish";
	}
	
	@RequestMapping("/resetPwFinish")
	public String resetPwFinish() {
		return "/WEB-INF/views/member/resetPwFinish.jsp";
	}
	
	@RequestMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		String memberId = (String) session.getAttribute("createdUser");
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto); // 멤버정보 jsp로 전송
		TakeOffDto lastDto = takeOffDao.selectLastOne(memberId);
		model.addAttribute("lastDto", lastDto); // 멤버의 휴복학정보 jsp로 전송
		if("학생".equals(memberDto.getMemberRank())){
			StudentDto studentDto = studentDao.selectOne(memberId);
			model.addAttribute("studentDto", studentDto); // 학생정보 jsp로 전송
		}
		else if("교수".equals(memberDto.getMemberRank())) {
			ProfessorDto professorDto = professorDao.selectOne(memberId);
			model.addAttribute("professorDto", professorDto); // 교수정보 jsp로 전송
		}
		else if("관리자".equals(memberDto.getMemberRank())) {
			AdminDto adminDto = adminDao.selectOne(memberId);
			model.addAttribute("adminDto", adminDto); // 관리자정보 jsp로 전송
		}
		else {}
		return "/WEB-INF/views/member/mypage.jsp";
	}
	
	@GetMapping("/edit")
	public String change(Model model, HttpSession session) {
		String memberId = (String) session.getAttribute("createdUser");
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto); // 멤버정보 jsp로 전송
		TakeOffDto lastDto = takeOffDao.selectLastOne(memberId);
		model.addAttribute("lastDto", lastDto); // 멤버의 휴복학정보 jsp로 전송
		if("학생".equals(memberDto.getMemberRank())){
			StudentDto studentDto = studentDao.selectOne(memberId);
			model.addAttribute("studentDto", studentDto); // 학생정보 jsp로 전송
		}
		else if("교수".equals(memberDto.getMemberRank())) {
			ProfessorDto professorDto = professorDao.selectOne(memberId);
			model.addAttribute("professorDto", professorDto); // 교수정보 jsp로 전송
		}
		else if("관리자".equals(memberDto.getMemberRank())) {
			AdminDto adminDto = adminDao.selectOne(memberId);
			model.addAttribute("adminDto", adminDto); // 관리자정보 jsp로 전송
		}
		else {}
		return "/WEB-INF/views/member/edit.jsp";
	}
	
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto,
						@ModelAttribute StudentDto studentDto,
						@ModelAttribute ProfessorDto professorDto,
						@ModelAttribute AdminDto adminDto) {
		boolean member = memberDao.updateMemberByAdmin(memberDto); 
		// 메서드가 관리자전용이지만 memberId와 memberRank를 readonly로 수정불가하게 하여 전달함으로 
		// 사용 가능하게 됨 그래서 씀
		
		boolean student = false;
		boolean professor = false;
		boolean admin = false;
		if("학생".equals(memberDto.getMemberRank())){
			student = studentDao.update(studentDto);
		}
		else if("교수".equals(memberDto.getMemberRank())) {
			professor = professorDao.update(professorDto);
		}
		else if("관리자".equals(memberDto.getMemberRank())) {
//			admin = adminDao.update(adminDto); // admin 테이블의 컬럼이 PK 1개뿐이라 수정 불가
			admin = true; // 그래서 true로 설정해 통과 시켜주어야 한다
		}
		else {}
		boolean result = member && (student || professor || admin);
		if(result == false)
			throw new TargetNotFoundException("존재하지 않는 회원ID입니다.");
		return "redirect:mypage";
		
	}
	
	@RequestMapping("/block") //제적jsp
	public String block() {
		return "/WEB-INF/views/member/block.jsp";
	}
	
	
}
