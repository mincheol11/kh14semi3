package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.MemberDto;

@Service
public class MemberMapper implements RowMapper<MemberDto> {

	@Override
	public MemberDto mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberDto memberDto = new MemberDto();
		memberDto.setMemberId(rs.getString("member_id"));
		memberDto.setMemberPw(rs.getString("member_pw"));		
		memberDto.setMemberName(rs.getString("member_name"));
		memberDto.setMemberRank(rs.getString("member_rank"));
		memberDto.setMemberEmail(rs.getString("member_email"));
		memberDto.setMemberCell(rs.getString("member_cell")); 
		memberDto.setMemberBirth(rs.getString("member_birth"));
		memberDto.setMemberPost(rs.getString("member_post"));
		memberDto.setMemberAddress1(rs.getString("member_address1"));
		memberDto.setMemberAddress2(rs.getString("member_address2"));
		memberDto.setMemberJoin(rs.getDate("member_join"));
		memberDto.setMemberLogin(rs.getDate("member_login"));
		
		return memberDto;
	}
	
}
