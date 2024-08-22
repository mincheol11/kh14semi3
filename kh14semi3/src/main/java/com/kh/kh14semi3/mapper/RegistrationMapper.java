package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.RegistrationDto;

@Service
public class RegistrationMapper implements RowMapper<RegistrationDto> {
	
	@Override
	public RegistrationDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		RegistrationDto registrationDto = new RegistrationDto();
		registrationDto.setRegistrationCode(rs.getString("registration_code"));
		registrationDto.setRegistrationStudent(rs.getString("registration_student"));
		registrationDto.setRegistrationLecture(rs.getString("registration_lecture"));
		registrationDto.setRegistrationDate(rs.getDate("registration_date"));
		return registrationDto;
	}
}
