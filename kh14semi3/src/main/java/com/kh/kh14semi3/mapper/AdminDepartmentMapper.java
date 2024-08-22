package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.AdminDepartmentDto;

@Service
public class AdminDepartmentMapper implements RowMapper<AdminDepartmentDto>{

	@Override
	public AdminDepartmentDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		AdminDepartmentDto adminDepartmentDto = new AdminDepartmentDto();
		adminDepartmentDto.setDepartmentCode(rs.getString("department_code"));
		adminDepartmentDto.setDepartmentName(rs.getString("department_name"));
		return adminDepartmentDto;
	}

}
