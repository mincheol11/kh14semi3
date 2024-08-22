package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.MemberDto;
import com.kh.kh14semi3.mapper.MemberMapper;

@Repository
public class MemberDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private MemberMapper memberMapper;
	//회원 상세
	public MemberDto selectOne(String memberId) {
		String sql = "select * from member where member_id = ?";
		Object[] data  = {memberId};
		List<MemberDto>list = jdbcTemplate.query(sql,memberMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
}
