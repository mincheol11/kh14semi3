package com.kh.kh14semi3.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.StudentDto;
import com.kh.kh14semi3.mapper.StudentMapper;

@Repository
public class StudentDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private StudentMapper studentMapper;
	
	public void insert(StudentDto studentDto) {
		String sql = "insert into student("
					+ "student_id, department_code, student_level "
					+ ") "
					+ "values(?, ?, ?)";
		Object[] data = {
				studentDto.getStudentId(), studentDto.getStudentDepartment(), studentDto.getStudentLevel()
		};
		jdbcTemplate.update(sql, data);
	}
	
	
}
