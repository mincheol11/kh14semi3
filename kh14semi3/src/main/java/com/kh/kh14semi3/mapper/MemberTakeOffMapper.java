package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.vo.MemberTakeOffVO;

@Service
public class MemberTakeOffMapper implements RowMapper<MemberTakeOffVO> {

	@Override
	public MemberTakeOffVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberTakeOffVO memberTakeOffVO = new MemberTakeOffVO();
		memberTakeOffVO.setMemberId(rs.getString("member_id"));
		memberTakeOffVO.setMemberPw(rs.getString("member_pw"));		
		memberTakeOffVO.setMemberName(rs.getString("member_name"));
		memberTakeOffVO.setMemberRank(rs.getString("member_Rank"));
		memberTakeOffVO.setMemberEmail(rs.getString("member_email"));
		memberTakeOffVO.setMemberCell(rs.getString("member_cell")); 
		memberTakeOffVO.setMemberBirth(rs.getString("member_birth"));
		memberTakeOffVO.setMemberPost(rs.getString("member_post"));
		memberTakeOffVO.setMemberAddress1(rs.getString("member_address1"));
		memberTakeOffVO.setMemberAddress2(rs.getString("member_address2"));
		memberTakeOffVO.setMemberJoin(rs.getDate("member_join"));
		memberTakeOffVO.setMemberLogin(rs.getDate("member_login"));
		
		memberTakeOffVO.setTakeOffNo(rs.getInt("takeOff_no"));
		memberTakeOffVO.setTakeOffType(rs.getString("takeOff_type"));
		memberTakeOffVO.setTakeOffMemo(rs.getString("takeOff_memo"));
		memberTakeOffVO.setTakeOffTime(rs.getDate("takeOff_time"));
		memberTakeOffVO.setTakeOffTarget(rs.getString("takeOff_target"));
		return memberTakeOffVO;
	}
	
}