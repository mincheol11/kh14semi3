package com.kh.kh14semi3.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.mapper.LectureMapper;

@Repository
public class LectureDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private LectureMapper lectureMapper;
	
	
	public void insert(LectureDto lectureDto) {
		String sql = "insert into lecture("
							+ "lecture_code, lecture_department, lecture_professor, "
							+ "lecture_type, lecture_name"
								+ ") values(?, ?, ?, ?, ?)";
		Object[] data = {
				lectureDto.getLectureCode(), lectureDto.getLectureDepartment(), lectureDto.getLectureProfessor(),
				lectureDto.getLectureType(), lectureDto.getLectureName()
		};
		jdbcTemplate.update(sql, data);
	}
	
	
}
