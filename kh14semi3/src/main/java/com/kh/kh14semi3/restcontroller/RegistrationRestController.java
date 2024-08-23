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
 
	// 수강신청 확인 매핑
	@RequestMapping("/check")
	public RegistrationVO check(HttpSession session, @RequestParam String lectureCode) {
		// 학번 추출
		String studentId = (String) session.getAttribute("createdUser");
		
		RegistrationVO registrationVO = new RegistrationVO();
		
		// 설정
		registrationVO.setChecked(registrationDao.check(studentId, lectureCode));
		registrationVO.setCount(registrationDao.count(lectureCode));
		
		return registrationVO;		
	}
	
	// 수강 신청 혹은 취소 기능 (학번 없으면 못함)
	@RequestMapping("/regist")
	public RegistrationVO regist(HttpSession session, @RequestParam String lectureCode) {
		// 학번 추출
		String studentId = (String) session.getAttribute("createdUser");
		
		boolean isChecked = registrationDao.check(studentId, lectureCode);
		if(isChecked) { // 삭제(등록 이력 있음)
			registrationDao.delete(studentId, lectureCode);
		}
		else { // 등록(등록 이력 없음)
			registrationDao.insert(studentId, lectureCode);
		}
		
		// 갱신(최신화) - 반정규화
		lectureDao.updateRegistration(lectureCode);
		
		// 설정
		RegistrationVO registrationVO = new RegistrationVO();
		registrationVO.setChecked(!isChecked);
		registrationVO.setCount(registrationDao.count(lectureCode));
		
		return registrationVO;
	}
	
	
}
