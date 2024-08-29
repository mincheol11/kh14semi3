package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.vo.GradeLectureVO;

@Service
public class GradeLectureMapper implements RowMapper<GradeLectureVO> {
	@Override
	public GradeLectureVO mapRow(ResultSet rs, int rowNum) throws SQLException {
		GradeLectureVO gradeLectureVO = new GradeLectureVO();
		
		gradeLectureVO.setGradeCode(rs.getString("grade_code"));
		gradeLectureVO.setGradeStudent(rs.getString("grade_student"));
		gradeLectureVO.setGradeLecture(rs.getString("grade_lecture"));
		gradeLectureVO.setGradeAttendance(rs.getInt("grade_attendance"));
		gradeLectureVO.setGradeScore1(rs.getInt("grade_score1"));
		gradeLectureVO.setGradeScore2(rs.getInt("grade_score2"));
		gradeLectureVO.setGradeHomework(rs.getInt("grade_homework"));
		gradeLectureVO.setGradeRank(rs.getInt("grade_rank"));
		
		gradeLectureVO.setLectureCode(rs.getString("lecture_code"));
		gradeLectureVO.setLectureDepartment(rs.getString("lecture_department"));
		gradeLectureVO.setLectureProfessor(rs.getString("lecture_professor"));
		gradeLectureVO.setLectureType(rs.getString("lecture_type"));
		gradeLectureVO.setLectureName(rs.getString("lecture_name"));
		gradeLectureVO.setLectureTime(rs.getString("lecture_time"));
		gradeLectureVO.setLectureDuration(rs.getInt("lecture_duration"));
		gradeLectureVO.setLectureDay(rs.getString("lecture_day"));
		gradeLectureVO.setLectureRoom(rs.getString("lecture_room"));
		gradeLectureVO.setLectureCount(rs.getInt("lecture_count"));
		gradeLectureVO.setLectureRegist(rs.getInt("lecture_regist"));
		
		return gradeLectureVO;
	}
}
