package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.vo.LectureMemberVO;

@Service
public class LectureMemberMapper implements RowMapper<LectureMemberVO> {
	@Override
	public LectureMemberVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		LectureMemberVO lectureMemberVO = new LectureMemberVO();
		
		lectureMemberVO.setLectureCode(rs.getString("lecture_code"));
		lectureMemberVO.setLectureDepartment(rs.getString("lecture_department"));
		lectureMemberVO.setLectureProfessor(rs.getString("lecture_professor"));
		lectureMemberVO.setLectureType(rs.getString("lecture_type"));
		lectureMemberVO.setLectureName(rs.getString("lecture_name"));
		lectureMemberVO.setLectureTime(rs.getString("lecture_time"));
		lectureMemberVO.setLectureDuration(rs.getInt("lecture_duration"));
		lectureMemberVO.setLectureDay(rs.getString("lecture_day"));
		lectureMemberVO.setLectureRoom(rs.getString("lecture_room"));
		lectureMemberVO.setLectureCount(rs.getInt("lecture_count"));
		lectureMemberVO.setLectureRegist(rs.getInt("lecture_regist"));
		
		lectureMemberVO.setDepartmentCode(rs.getString("department_Code"));
		lectureMemberVO.setDepartmentName(rs.getString("department_name"));
		
		lectureMemberVO.setMemberId(rs.getString("member_id"));
		lectureMemberVO.setMemberPw(rs.getString("member_pw"));		
		lectureMemberVO.setMemberName(rs.getString("member_name"));
		lectureMemberVO.setMemberRank(rs.getString("member_rank"));
		lectureMemberVO.setMemberEmail(rs.getString("member_email"));
		lectureMemberVO.setMemberCell(rs.getString("member_cell")); 
		lectureMemberVO.setMemberBirth(rs.getString("member_birth"));
		lectureMemberVO.setMemberPost(rs.getString("member_post"));
		lectureMemberVO.setMemberAddress1(rs.getString("member_address1"));
		lectureMemberVO.setMemberAddress2(rs.getString("member_address2"));
		lectureMemberVO.setMemberJoin(rs.getDate("member_join"));
		lectureMemberVO.setMemberLogin(rs.getDate("member_login"));
		
		return lectureMemberVO;
	}
}
