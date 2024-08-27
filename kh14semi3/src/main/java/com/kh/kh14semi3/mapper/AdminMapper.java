package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.AdminDto;

@Service
public class AdminMapper implements RowMapper<AdminDto> {
	@Override
	public AdminDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		AdminDto adminDto = new AdminDto();
		adminDto.setAdminId(rs.getString("admin_id"));
		return adminDto;
	}
}
