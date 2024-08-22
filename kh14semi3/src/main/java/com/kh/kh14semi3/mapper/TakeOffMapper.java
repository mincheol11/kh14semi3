package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.TakeOffDto;

@Service
public class TakeOffMapper implements RowMapper<TakeOffDto> {

	@Override
	public TakeOffDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		TakeOffDto takeOffDto = new TakeOffDto();
		takeOffDto.setTakeOffNo(rs.getInt("takeOff_no"));
		takeOffDto.setTakeOffType(rs.getString("takeOff_type"));
		takeOffDto.setTakeOffMemo(rs.getString("takeOff_memo"));
		takeOffDto.setTakeOffTime(rs.getDate("takeOff_time"));
		takeOffDto.setTakeOffTarget(rs.getString("takeOff_target"));
		return takeOffDto;
	}

}
