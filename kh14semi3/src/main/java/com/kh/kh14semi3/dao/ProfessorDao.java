package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.AdminDto;
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
				+ "professor_id, professor_department "
				+ ") "
				+ "values(?, ?)";
		Object[] data = {professorDto.getProfessorId(), professorDto.getProfessorDepartment()};
		jdbcTemplate.update(sql, data);
	}
	
	public ProfessorDto selectOne(String professorId) {
		String sql = "select * from professor where professor_id = ?";
		Object[] data = {professorId};
		List<ProfessorDto> list = jdbcTemplate.query(sql, professorMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public boolean update(ProfessorDto professorDto) {
		String sql = "update professor set professor_department = ? where professor_id = ?";
		Object[] data = {professorDto.getProfessorDepartment(), professorDto.getProfessorId()};
		return jdbcTemplate.update(sql, data) > 0 ;
	}
	
	public boolean delete(String professorId) {
		String sql = "delete from professor where professor_id = ?";
		Object[] data = {professorId};
		return jdbcTemplate.update(sql, data) > 0 ;
	}

}