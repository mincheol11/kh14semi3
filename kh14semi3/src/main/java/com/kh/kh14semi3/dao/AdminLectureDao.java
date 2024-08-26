package com.kh.kh14semi3.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.mapper.LectureMapper;

@Repository
public class AdminLectureDao {
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	LectureMapper lectureMapper;
	
	//강의 추가
	public void add(LectureDto lectureDto) {
		String sql = "insert into lecture("
				+ "lecture_code, lecture_department, lecture_professor, "
				+ "lecture_type, lecture_name, lecture_time, "
				+ "lecture_duration, lecture_day, lecture_room, lecture_count"
				+ ") values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				lectureDto.getLectureCode(), lectureDto.getLectureDepartment(),
				lectureDto.getLectureProfessor(), lectureDto.getLectureType(), 
				lectureDto.getLectureName(), lectureDto.getLectureTime(), 
				lectureDto.getLectureDuration(), lectureDto.getLectureDay(), 
				lectureDto.getLectureRoom(), lectureDto.getLectureCount()
				};
		jdbcTemplate.update(sql,data);		
	}
	
	

}
