package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.vo.GradeStudentVO;

@Service
public class GradeStudentMapper implements RowMapper<GradeStudentVO>{
	
	@Override
	public GradeStudentVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		GradeStudentVO gradeStudentVO = new GradeStudentVO();
		gradeStudentVO.setGradeCode(rs.getString("grade_code"));
		gradeStudentVO.setGradeStudent(rs.getString("grade_student"));
		gradeStudentVO.setGradeLecture(rs.getString("grade_lecture"));
		gradeStudentVO.setGradeAttendance(rs.getInt("grade_attendance"));
		gradeStudentVO.setGradeAttendance(rs.getInt("grade_attendance"));
		gradeStudentVO.setGradeScore1(rs.getInt("grade_score1"));
		gradeStudentVO.setGradeHomework(rs.getInt("grade_homework"));
		gradeStudentVO.setGradeRank(rs.getInt("grade_rank"));
		
		gradeStudentVO.setMemberId(rs.getString("member_id"));
		gradeStudentVO.setMemberName(rs.getString("member_name"));
		
		return gradeStudentVO;
	}

}
