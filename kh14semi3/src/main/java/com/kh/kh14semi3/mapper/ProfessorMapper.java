package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.ProfessorDto;

@Service
public class ProfessorMapper implements RowMapper<ProfessorDto> {
	@Override
	public ProfessorDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ProfessorDto professorDto = new ProfessorDto();
		professorDto.setProfessorId(rs.getString("professor_id"));
		professorDto.setProfessorDepartment(rs.getString("professor_department"));
		return null;
	}
}
