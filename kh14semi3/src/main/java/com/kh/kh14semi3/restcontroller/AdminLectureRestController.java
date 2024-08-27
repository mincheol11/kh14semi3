package com.kh.kh14semi3.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.kh14semi3.dao.AdminLectureDao;
import com.kh.kh14semi3.dto.LectureDto;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/admin/lecture")
public class AdminLectureRestController {
	@Autowired
	private AdminLectureDao adminLectureDao;
	//코드 중복 검사
			@PostMapping("/checkLectureCode")
			public boolean checkLectureCode(@RequestParam String lectureCode) {
				LectureDto lectureDto =
						adminLectureDao.selectOneByLectureCode(lectureCode);
				return lectureDto==null;
			}
			
}
