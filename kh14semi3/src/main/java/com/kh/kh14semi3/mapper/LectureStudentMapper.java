package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.vo.LectureStudentVO;

@Service
public class LectureStudentMapper implements RowMapper<LectureStudentVO>{

	@Override
	public LectureStudentVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		LectureStudentVO lectureStudentVO = new LectureStudentVO();
		lectureStudentVO.setLectureCode(rs.getString("lecture_code"));
		lectureStudentVO.setLectureDepartment(rs.getString("lecture_department"));
		lectureStudentVO.setLectureProfessor(rs.getString("lecture_professor"));
		lectureStudentVO.setLectureType(rs.getString("lecture_type"));
		lectureStudentVO.setLectureName(rs.getString("lecture_name"));
		lectureStudentVO.setLectureTime(rs.getDate("lecture_time"));
		lectureStudentVO.setLectureDuration(rs.getInt("lecture_duration"));
		lectureStudentVO.setLectureDay(rs.getDate("lecture_day"));
		lectureStudentVO.setLectureRoom(rs.getString("lecture_room"));
		lectureStudentVO.setLectureCount(rs.getInt("lecture_count"));
		lectureStudentVO.setLectureRegist(rs.getInt("lecture_regist"));
		
		lectureStudentVO.setMemberId(rs.getString("member_id"));
		lectureStudentVO.setMemberName(rs.getString("member_name"));
		
		return lectureStudentVO;
	}

}
