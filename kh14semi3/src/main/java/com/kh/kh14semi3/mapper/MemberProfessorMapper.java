package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.ProfessorDto;
import com.kh.kh14semi3.vo.MemberProfessorVO;
import com.kh.kh14semi3.vo.MemberStudentVO;

@Service
public class MemberProfessorMapper implements RowMapper<MemberProfessorVO> {
	@Override
	public MemberProfessorVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		MemberProfessorVO memberProfessorVO = new MemberProfessorVO();
		
		memberProfessorVO.setMemberId(rs.getString("member_id"));
		memberProfessorVO.setMemberPw(rs.getString("member_pw"));		
		memberProfessorVO.setMemberName(rs.getString("member_name"));
		memberProfessorVO.setMemberRank(rs.getString("member_rank"));
		memberProfessorVO.setMemberEmail(rs.getString("member_email"));
		memberProfessorVO.setMemberCell(rs.getString("member_cell")); 
		memberProfessorVO.setMemberBirth(rs.getString("member_birth"));
		memberProfessorVO.setMemberPost(rs.getString("member_post"));
		memberProfessorVO.setMemberAddress1(rs.getString("member_address1"));
		memberProfessorVO.setMemberAddress2(rs.getString("member_address2"));
		memberProfessorVO.setMemberJoin(rs.getDate("member_join"));
		memberProfessorVO.setMemberLogin(rs.getDate("member_login"));
		
		memberProfessorVO.setProfessorId(rs.getString("professor_id"));
		memberProfessorVO.setProfessorDepartment(rs.getString("professor_department"));
		
		return memberProfessorVO;
	}
}
