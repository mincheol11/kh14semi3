package com.kh.kh14semi3.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.TakeOffDto;
import com.kh.kh14semi3.mapper.TakeOffMapper;

@Repository
public class TakeOffDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private TakeOffMapper takeOffMapper;
	
	//재적 등록(미완성)
	public void insertTakeOff(TakeOffDto takeOffDto) {
		String sql = "insert into TakeOff("
						+ "takeOff_no, takeOff_type, "
						+ "takeOff_memo, takeOff_time, takeOff_target" 
						+ ") "
						+ "value(takeOff_seq.nextval, '재적', ?, ?, ?)";
		Object[] data = {takeOffDto.getTakeOffMemo(), takeOffDto.getTakeOffTime(), takeOffDto.getTakeOffTarget()};
		jdbcTemplate.update(sql, data);
	}
}
