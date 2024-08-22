package com.kh.kh14semi3.mapper;

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
		lectureDto.setLectureCode(rs.getInt("lecture_code"));
		lectureDto.setLectureType(rs.getString("lecture_type"));
		lectureDto.setLectureName(rs.getString("lecture_name"));
		lectureDto.setLectureTime(rs.getString("lecture_time"));
		lectureDto.setLectureDuration(rs.getInt("lecture_dutration"));
		lectureDto.setLectureDay(rs.getString("lecture_day"));
		lectureDto.setLectureRoom(rs.getString("lecture_room"));
		lectureDto.setLectureCount(rs.getInt("lecture_count"));
		return lectureDto;
	}
	
}
