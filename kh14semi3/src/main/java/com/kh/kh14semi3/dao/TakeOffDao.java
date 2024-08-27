package com.kh.kh14semi3.dao;

import java.util.List;

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
	
	//휴학 등록
	public void insertTakeOff(TakeOffDto takeOffDto) {
		String sql = "insert into takeOff("
						+ "takeOff_no, takeOff_type, "
						+ "takeOff_memo, takeOff_time, takeOff_target" 
						+ ") "
						+ "values(takeOff_seq.nextval, '휴학', ?, sysdate, ?)";
		Object[] data = {takeOffDto.getTakeOffMemo(), takeOffDto.getTakeOffTarget()};
		jdbcTemplate.update(sql, data);
	}

	//복학 등록
	public void insertTakeOn(TakeOffDto takeOffDto) {
		String sql = "insert into takeOff("
				+ "takeOff_no, takeOff_type, "
				+ "takeOff_memo, takeOff_time, takeOff_target "
				+ ") "
				+ "values(takeOff_seq.nextval, '복학', ?, sysdate, ?)";
		Object[] data = {takeOffDto.getTakeOffMemo(), takeOffDto.getTakeOffTarget()};
		jdbcTemplate.update(sql, data);
	}
	
	
	
	// 주어진 아이디의 마지막 takeOff 정보를 상세조회하는 기능
	public TakeOffDto selectLastOne(String takeOffTarget) {
		String sql = "select * from takeOff where takeOff_no = ("
				+ "select max(takeOff_no) from takeOff where takeOff_target = ? "
				+ ")";
		Object[] data = {takeOffTarget};
		List<TakeOffDto>list = jdbcTemplate.query(sql, takeOffMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
