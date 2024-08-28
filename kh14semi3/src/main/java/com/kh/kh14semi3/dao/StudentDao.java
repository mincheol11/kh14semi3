package com.kh.kh14semi3.dao;

import java.util.List;

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
					+ "student_id, student_department, student_level "
					+ ") "
					+ "values(?, ?, ?)";
		Object[] data = {
				studentDto.getStudentId(), studentDto.getStudentDepartment(), studentDto.getStudentLevel()
		};
		jdbcTemplate.update(sql, data);
	}
	
	public StudentDto selectOne(String studentId) {
		String sql = "select * from student where student_id = ?";
		Object[] data = {studentId};
		List<StudentDto> list = jdbcTemplate.query(sql, studentMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public boolean update(StudentDto studentDto) {
		String sql  = "update student set student_id = ? ";
		Object[] data = {studentDto.getStudentId()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean delete(String studentId) {
		String sql = "delete from student where student_id = ?";
		Object[] data = {studentId};
		return jdbcTemplate.update(sql, data) > 0;
	}
}
