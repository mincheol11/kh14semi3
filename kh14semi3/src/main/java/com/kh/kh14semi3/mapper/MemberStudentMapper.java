package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.vo.MemberStudentVO;

@Service
public class MemberStudentMapper implements RowMapper<MemberStudentVO> {
	@Override
	public MemberStudentVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberStudentVO memberStudentVO = new MemberStudentVO();
		
		memberStudentVO.setMemberId(rs.getString("member_id"));
		memberStudentVO.setMemberPw(rs.getString("member_pw"));		
		memberStudentVO.setMemberName(rs.getString("member_name"));
		memberStudentVO.setMemberRank(rs.getString("member_rank"));
		memberStudentVO.setMemberEmail(rs.getString("member_email"));
		memberStudentVO.setMemberCell(rs.getString("member_cell")); 
		memberStudentVO.setMemberBirth(rs.getString("member_birth"));
		memberStudentVO.setMemberPost(rs.getString("member_post"));
		memberStudentVO.setMemberAddress1(rs.getString("member_address1"));
		memberStudentVO.setMemberAddress2(rs.getString("member_address2"));
		memberStudentVO.setMemberJoin(rs.getDate("member_join"));
		memberStudentVO.setMemberLogin(rs.getDate("member_login"));
		
		memberStudentVO.setStudentId(rs.getString("student_id"));
		memberStudentVO.setStudentDepartment(rs.getString("student_department"));
		memberStudentVO.setStudentLevel(rs.getInt("student_level"));
		
		return memberStudentVO;
	}
}
