package com.kh.kh14semi3.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.ProfessorDto;
import com.kh.kh14semi3.mapper.ProfessorMapper;

@Repository
public class ProfessorDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ProfessorMapper professorMapper;
	
	public void insert(ProfessorDto professorDto) {
		String sql = "insert into professor("
				+ "professior_id, department_code "
				+ ") "
				+ "values(?, ?)";
		Object[] data = {professorDto.getProfessorId(), professorDto.getProfessorDepartment()};
		jdbcTemplate.update(sql, data);
	}
	
	
}
