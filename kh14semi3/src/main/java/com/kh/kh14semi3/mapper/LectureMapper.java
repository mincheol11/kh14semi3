package com.kh.kh14semi3.mapper;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.LectureDto;

@Service
public class LectureMapper implements RowMapper<LectureDto>{

	@Override
	public LectureDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		LectureDto lectureDto = new LectureDto();
		lectureDto.setLectureCode(rs.getString("lecture_code"));
		lectureDto.setLectureDepartment(rs.getString("lecture_department"));
		lectureDto.setLectureProfessor(rs.getString("lecture_professor"));
		lectureDto.setLectureType(rs.getString("lecture_type"));
		lectureDto.setLectureName(rs.getString("lecture_name"));
		lectureDto.setLectureTime(rs.getDate("lecture_time"));
		lectureDto.setLectureDuration(rs.getInt("lecture_duration"));
		lectureDto.setLectureDay(rs.getDate("lecture_day"));
		lectureDto.setLectureRoom(rs.getString("lecture_room"));
		lectureDto.setLectureCount(rs.getInt("lecture_count"));
		lectureDto.setLectureRegist(rs.getInt("lecture_regist"));
		
		return lectureDto;
	}

}
