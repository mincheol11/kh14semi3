package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.GradeDto;

@Service
public class GradeMapper implements RowMapper<GradeDto> {
	@Override
	public GradeDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		GradeDto gradeDto = new GradeDto();
		gradeDto.setGradeCode(rs.getString("grade_code"));
		gradeDto.setGradeStudent(rs.getString("grade_student"));
		gradeDto.setGradeLecture(rs.getString("grade_lecture"));
		gradeDto.setGradeAttendance(rs.getInt("grade_attendance"));
		gradeDto.setGradeScore1(rs.getInt("grade_score1"));
		gradeDto.setGradeScore2(rs.getInt("grade_score2"));
		gradeDto.setGradeHomework(rs.getInt("grade_homework"));
		
		return gradeDto;
	}
}
