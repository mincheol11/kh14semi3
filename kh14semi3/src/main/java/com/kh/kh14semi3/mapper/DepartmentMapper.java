package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.DepartmentDto;

@Service
public class DepartmentMapper implements RowMapper<DepartmentDto> {
	@Override
	public DepartmentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		DepartmentDto departmentDto = new DepartmentDto();
		departmentDto.setDepartmentCode(rs.getString("department_Code"));
		departmentDto.setDepartmentName(rs.getString("department_name"));
		return departmentDto;
	}
}
