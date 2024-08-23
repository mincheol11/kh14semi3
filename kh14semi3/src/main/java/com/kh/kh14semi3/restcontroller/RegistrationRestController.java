package com.kh.kh14semi3.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.kh14semi3.dao.LectureDao;
import com.kh.kh14semi3.dao.RegistrationDao;
import com.kh.kh14semi3.vo.RegistrationVO;

import jakarta.servlet.http.HttpSession;

@CrossOrigin
@RestController
@RequestMapping("/rest/registration")
public class RegistrationRestController {
	
	@Autowired
	private RegistrationDao registrationDao;
	@Autowired
	private LectureDao lectureDao;
 
//	// 수강신청 확인 매핑
//	@RequestMapping("/check")
//	public RegistrationVO check(HttpSession session, @RequestParam String lectureCode) {
//		// 학번 추출
//		String studentId = (String) session.getAttribute("")
//	}
	
	
}
