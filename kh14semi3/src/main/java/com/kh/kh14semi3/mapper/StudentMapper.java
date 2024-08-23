package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.StudentDto;

@Service
public class StudentMapper implements RowMapper<StudentDto> {
	
	@Override
	public StudentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		StudentDto studentDto = new StudentDto();
		studentDto.setStudentId(rs.getString("student_id"));
		studentDto.setStudentDepartment(rs.getString("student_department"));
		studentDto.setStudentLevel(rs.getInt("student_level"));
		
		return studentDto;
	}
}
