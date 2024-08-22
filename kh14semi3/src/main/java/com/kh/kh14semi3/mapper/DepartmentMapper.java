package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.DepartmentDto;

@Service
public class DepartmentMapper implements RowMapper<DepartmentDto>{

	@Override
	public DepartmentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		DepartmentDto departmetnDto = new DepartmentDto();
		departmetnDto.setDepartmentCode(rs.getInt("department_code"));
		departmetnDto.setDepartmentName(rs.getString("department_name"));
		return departmetnDto;
	}

}
