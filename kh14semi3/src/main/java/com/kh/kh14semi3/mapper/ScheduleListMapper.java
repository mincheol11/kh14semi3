package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.ScheduleDto;

@Service
public class ScheduleListMapper implements RowMapper<ScheduleDto> {

	@Override
	public ScheduleDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		ScheduleDto scheduleDto = new ScheduleDto();
		scheduleDto.setScheduleNo(rs.getInt("schedule_no"));
		scheduleDto.setScheduleWriter(rs.getString("schedule_writer"));
		scheduleDto.setScheduleType(rs.getString("schedule_type"));
		scheduleDto.setScheduleTitle(rs.getString("schedule_title"));
		//scheduleDto.setScheduleContent(rs.getString("schedule_content"));
		scheduleDto.setScheduleWtime(rs.getDate("schedule_wtime"));
		return scheduleDto;
	}

}
