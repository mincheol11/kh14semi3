package com.kh.kh14semi3.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.kh14semi3.dao.AdminLectureDao;
import com.kh.kh14semi3.dao.DepartmentDao;
import com.kh.kh14semi3.dao.ProfessorDao;
import com.kh.kh14semi3.dto.DepartmentDto;
import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.dto.ProfessorDto;

@CrossOrigin(origins = {"http://127.0.0.1:5500"})
@RestController
@RequestMapping("/rest/admin/lecture")
public class AdminLectureRestController {
	@Autowired
	private AdminLectureDao adminLectureDao;
	@Autowired
	private ProfessorDao professorDao;
	@Autowired
	private DepartmentDao departmentDao;
	//코드 중복 검사
			@PostMapping("/checkLectureCode")
			public boolean checkLectureCode(@RequestParam String lectureCode) {
				LectureDto lectureDto =
						adminLectureDao.selectOneByLectureCode(lectureCode);
				return lectureDto==null;
			}
			//과목코드 DB에 있는것만 검사
			@PostMapping("/checkLectureDepartment")
			public boolean checkLectureDepartment(@RequestParam String lectureDepartment) {
				DepartmentDto lectureDto =
						departmentDao.selectOne(lectureDepartment);
				return lectureDto!=null; 
			}
			//교수코드 DB에 있는것만 검사
			@PostMapping("/checkLectureProfessor")
			public boolean checkLectureProfessor(@RequestParam String lectureProfessor) {
				ProfessorDto lectureDto =
						professorDao.selectOne(lectureProfessor);
				return lectureDto!=null; 
			}
			//강의명 중복검사
			@PostMapping("/checkLectureName")
			public boolean checkLectureName(@RequestParam String lectureName) {
				LectureDto lectureDto =
						adminLectureDao.selectOneByLectureName(lectureName);
				return lectureDto==null; 
			}
			
}
