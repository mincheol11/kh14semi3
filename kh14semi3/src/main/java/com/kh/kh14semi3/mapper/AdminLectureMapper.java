package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.AdminLectureDto;

@Service
public class AdminLectureMapper implements RowMapper<AdminLectureDto>{

	@Override
	public AdminLectureDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		AdminLectureDto adminLectureDto = new AdminLectureDto();
		 adminLectureDto.setLectureCode(rs.getString("lecture_code"));
		 adminLectureDto.setLectureDepartment(rs.getString("lecture_department"));
		 adminLectureDto.setLectureProfessor(rs.getString("lecture_professor"));
		 adminLectureDto.setLectureType(rs.getString("lecture_type"));
		 adminLectureDto.setLectureName(rs.getString("lecture_name"));
		 adminLectureDto.setLectureTime(rs.getDate("lecture_time"));
		 adminLectureDto.setLectureDuration(rs.getInt("lecture_dutration"));
		 adminLectureDto.setLectureDay(rs.getDate("lecture_day"));
		 adminLectureDto.setLectureRoom(rs.getString("lecture_room"));
		 adminLectureDto.setLectureCount(rs.getInt("lecture_count"));
		return  adminLectureDto;
	}
	
}
