package com.kh.kh14semi3.restcontroller;

import org.apache.jasper.tagplugins.jstl.core.Remove;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.kh14semi3.dao.AdminDao;
import com.kh.kh14semi3.dao.AdminDepartmentDao;
import com.kh.kh14semi3.dao.DepartmentDao;
import com.kh.kh14semi3.dao.MemberDao;
import com.kh.kh14semi3.dao.ProfessorDao;
import com.kh.kh14semi3.dao.StudentDao;
import com.kh.kh14semi3.dto.AdminDto;
import com.kh.kh14semi3.dto.DepartmentDto;
import com.kh.kh14semi3.dto.MemberDto;
import com.kh.kh14semi3.dto.ProfessorDto;
import com.kh.kh14semi3.dto.StudentDto;
 
@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/member")
public class MemberRestController {
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private StudentDao studentDao;
	
	@Autowired
	private ProfessorDao professorDao;
	
	@Autowired
	private AdminDao adminDao;
	
	@Autowired
	private     DepartmentDao   departmentDao;
	
	//아이디 중복 여부 확인
	@PostMapping("/checkId")
	public boolean checkId(@RequestParam String memberId) {
		MemberDto memberDto = memberDao.selectOne(memberId);
		StudentDto studentDto = studentDao.selectOne(memberId);
		ProfessorDto professorDto = professorDao.selectOne(memberId);
		AdminDto adminDto = adminDao.selectOne(memberId);
		boolean nullCheck = memberDto != null && studentDto == null 
									&& professorDto == null && adminDto == null;
		if(nullCheck) {
			memberDao.delete(memberId);
		}
		return memberDto == null;
	}
	
	//코드 중복 검사
			@PostMapping("/checkDepartmentCode")
			public boolean checkDepartmentCode(@RequestParam String departmentCode) {
				DepartmentDto departmentDto =
						departmentDao.selectOne(departmentCode);
				System.out.println("123123 "+departmentDto);
				return departmentDto!=null;
			}
	
}