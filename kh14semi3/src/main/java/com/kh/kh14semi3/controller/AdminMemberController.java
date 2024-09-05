package com.kh.kh14semi3.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.kh14semi3.dao.AdminDao;
import com.kh.kh14semi3.dao.DepartmentDao;
import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.dao.ProfessorDao;
import com.kh.kh14semi3.dao.StudentDao;
import com.kh.kh14semi3.dao.TakeOffDao;
import com.kh.kh14semi3.dto.AdminDto;
import com.kh.kh14semi3.dto.DepartmentDto;
import com.kh.kh14semi3.dto.MemberDto;
import com.kh.kh14semi3.dto.ProfessorDto;
import com.kh.kh14semi3.dto.StudentDto;
import com.kh.kh14semi3.dto.TakeOffDto;
import com.kh.kh14semi3.error.TargetNotFoundException;
import com.kh.kh14semi3.vo.PageVO;

@Controller
@RequestMapping("/admin/member")
public class AdminMemberController {
		
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private TakeOffDao takeOffDao;
	
	@Autowired
	private StudentDao studentDao;
	
	@Autowired
	private ProfessorDao professorDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private DepartmentDao departmentDao;
	
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
	public String detail(Model model,
					@RequestParam String memberId,
					@RequestParam(required = false) String memberRank) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		TakeOffDto lastDto = takeOffDao.selectLastOne(memberId);
		model.addAttribute("lastDto", lastDto);
		if("학생".equals(memberDto.getMemberRank())) {
			StudentDto studentDto = studentDao.selectOne(memberId);
			model.addAttribute("studentDto", studentDto);
			DepartmentDto departmentDto = departmentDao.selectOne(studentDto.getStudentDepartment());
			model.addAttribute("sdDto", departmentDto);
		}
		else if("교수".equals(memberDto.getMemberRank())) {
			ProfessorDto professorDto = professorDao.selectOne(memberId);
			model.addAttribute("professorDto", professorDto);
			DepartmentDto departmentDto = departmentDao.selectOne(professorDto.getProfessorDepartment());
			model.addAttribute("pdDto", departmentDto);
//			System.out.println(departmentDto);
		}
		else if("관리자".equals(memberDto.getMemberRank())) {
			AdminDto adminDto = adminDao.selectOne(memberId);
			model.addAttribute("adminDto", adminDto);
		}
		else {
			
		}
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
	
	//관리자 - 회원가입(멤버테이블)
	@GetMapping("/join")
	public String join() {
		return "/WEB-INF/views/admin/member/join.jsp";
	}
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.insert(memberDto);
		return "redirect:joinR?memberId="+memberDto.getMemberId();
	}
	
	//관리자 - 회원가입(하위테이블)
	@GetMapping("/joinR")
	public String joinR(@RequestParam(required=false) String memberId, Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		if(memberDto==null) {
			throw new TargetNotFoundException();
		}
		model.addAttribute("memberDto", memberDto);
		return "/WEB-INF/views/admin/member/joinR.jsp";
	}
	
	@PostMapping("/joinR")
	public String joinR(@ModelAttribute StudentDto studentDto,
							@ModelAttribute ProfessorDto professorDto,
							@ModelAttribute AdminDto adminDto,
							@RequestParam(required=false) String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		
		if("학생".equals(memberDto.getMemberRank())) {
			studentDao.insert(studentDto);
		}
		else if("교수".equals(memberDto.getMemberRank())) {
			professorDao.insert(professorDto);
		}
		else if("관리자".equals(memberDto.getMemberRank())) {
			adminDao.insert(adminDto);
		}
		else {
			
		}
		return "redirect:list";
	}
	
	
	//관리자 - 회원 정보 수정
	@GetMapping("/change")
	public String change(@RequestParam(required=false) String memberId, Model model) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		model.addAttribute("memberDto", memberDto);
		
		if(memberDto == null) {
			throw new TargetNotFoundException("존재하지 않는 회원입니다.");
		}
		String memberRank = memberDto.getMemberRank();
		if("학생".equals(memberRank)) {
	        StudentDto studentDto = studentDao.selectOne(memberId);
	        model.addAttribute("studentDto", studentDto);
	    } 
		else if("교수".equals(memberRank)) {
	        ProfessorDto professorDto = professorDao.selectOne(memberId);
	        model.addAttribute("professorDto", professorDto);
	    } 
	    else if("관리자".equals(memberRank)) {
	        AdminDto adminDto = adminDao.selectOne(memberId);
	        model.addAttribute("adminDto", adminDto);
	    }
	    else {
	    	
	    }
		
		return "/WEB-INF/views/admin/member/change.jsp";
	} 
	
	@PostMapping("/change")
	public String change(@ModelAttribute MemberDto memberDto,
				@ModelAttribute StudentDto studentDto,
				@ModelAttribute ProfessorDto professorDto,
				@ModelAttribute AdminDto adminDto) {
		boolean result = memberDao.updateMemberByAdmin(memberDto);
		if(result == false) {
			throw new TargetNotFoundException("존재하지 않는 회원ID입니다.");

		}
		if("학생".equals(memberDto.getMemberRank())) {
			boolean result2 = studentDao.update(studentDto);
			if(result2 == false) {
				throw new TargetNotFoundException("존재하지 않는 회원ID입니다.");
			}
			return "redirect:detail?memberId="+memberDto.getMemberId()+"&message=change";
		}
		else if("교수".equals(memberDto.getMemberRank())) {
			boolean result3 = professorDao.update(professorDto);
			if(result3 == false) {
				throw new TargetNotFoundException("존재하지 않는 회원ID입니다.");
			}
			return "redirect:detail?memberId="+memberDto.getMemberId()+"&message=change";
		}
		else if("관리자".equals(memberDto.getMemberRank())) {
//			boolean result4 = adminDao.update(adminDto);
//			if(result4 == false) {
//				throw new TargetNotFoundException("존재하지 않는 회원ID입니다.");
//			}
			return "redirect:detail?memberId="+memberDto.getMemberId()+"&message=change";
		}
		else {
			
		}
		return "redirect:detail?memberId="+memberDto.getMemberId()+"&message=change";
	}
	
	//휴학기능
	@GetMapping("/takeOff")
	public String takeOff(@RequestParam String takeOffTarget) {
		MemberDto memberDto = memberDao.selectOne(takeOffTarget);
		if(memberDto == null)
			throw new TargetNotFoundException("존재하지 않는 학생입니다.");
		return "/WEB-INF/views/admin/member/takeOff.jsp";
	}
	
	@PostMapping("/takeOff")
	public String takeOff(@ModelAttribute TakeOffDto takeOffDto) {
		//마지막 이력 조회
		TakeOffDto lastDto = takeOffDao.selectLastOne(takeOffDto.getTakeOffTarget());
		if(lastDto == null || lastDto.getTakeOffType().equals("재학")) {
			takeOffDao.insertTakeOff(takeOffDto);
		}
		return "redirect:detail?memberId="+takeOffDto.getTakeOffTarget();
	}
	
	//복학 기능
	@GetMapping("/takeOn")
	public String takeOn(@RequestParam String takeOffTarget) {
		MemberDto memberDto = memberDao.selectOne(takeOffTarget);
		if(memberDto == null)
			throw new TargetNotFoundException("존재하지 않는 학생입니다.");
		return "/WEB-INF/views/admin/member/takeOn.jsp";
	}
	
	@PostMapping("/takeOn")
	public String takeOn(@ModelAttribute TakeOffDto takeOffDto) {
		TakeOffDto lastDto = takeOffDao.selectLastOne(takeOffDto.getTakeOffTarget());
		if(lastDto != null && lastDto.getTakeOffType().equals("휴학")) {
			takeOffDao.insertTakeOn(takeOffDto);
		}
		return "redirect:detail?memberId="+takeOffDto.getTakeOffTarget();
	}
	
	//제적기능
	@GetMapping("/blockGo")
	public String blockGo(@RequestParam String takeOffTarget) {
		MemberDto memberDto = memberDao.selectOne(takeOffTarget);
		if(memberDto == null)
			throw new TargetNotFoundException("존재하지 않는 학생입니다.");
		return "/WEB-INF/views/admin/member/blockGo.jsp";
	}
			
	@PostMapping("/blockGo")
	public String blockGo(@ModelAttribute TakeOffDto takeOffDto) {
		//마지막 이력 조회
		TakeOffDto lastDto = takeOffDao.selectLastOne(takeOffDto.getTakeOffTarget());
		if(lastDto == null || !lastDto.getTakeOffType().equals("제적")) {
			takeOffDao.blockGo(takeOffDto);
		}
		return "redirect:detail?memberId="+takeOffDto.getTakeOffTarget();
	}
			
	//제적 해제기능
	@GetMapping("/blockNo")
	public String blockNo(@RequestParam String takeOffTarget) {
		MemberDto memberDto = memberDao.selectOne(takeOffTarget);
		if(memberDto == null)
			throw new TargetNotFoundException("존재하지 않는 학생입니다.");
		return "/WEB-INF/views/admin/member/blockNo.jsp";
	}
			
	@PostMapping("/blockNo")
	public String blockNo(@ModelAttribute TakeOffDto takeOffDto) {
		TakeOffDto lastDto = takeOffDao.selectLastOne(takeOffDto.getTakeOffTarget());
		if(lastDto != null && lastDto.getTakeOffType().equals("제적")) {
			takeOffDao.blockNo(takeOffDto);
		}
		return "redirect:detail?memberId="+takeOffDto.getTakeOffTarget();
	}
	
	
	
	
	
}
