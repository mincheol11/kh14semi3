package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.mapper.LectureMapper;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class LectureDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private LectureMapper lectureMapper;	
	
	
	public void insert(LectureDto lectureDto) {
		String sql = "insert into lecture("
							+ "lecture_code, lecture_department, lecture_professor, "
							+ "lecture_type, lecture_name"
								+ ") values(?, ?, ?, ?, ?)";
		Object[] data = {
				lectureDto.getLectureCode(), lectureDto.getLectureDepartment(), lectureDto.getLectureProfessor(),
				lectureDto.getLectureType(), lectureDto.getLectureName()
		};
		jdbcTemplate.update(sql, data);
	}
	
	
	
	
	// 페이징 객체를 이용한 목록 및 검색 메소드
	public List<LectureDto> selectListByPaging(PageVO pageVO){
		if(pageVO.isSearch()) { // 검색이라면 
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "lecture_code, lecture_department, lecture_professor, "
					+ "lecture_type, lecture_name, "
					+ "lecture_time, lecture_day, lecture_duration, "
					+ "lecture_room, lecture_count, lecture_regist "
					+ "from lecture "
					+ "where instr("+pageVO.getColumn()+",?)>0 "
					// 트리정렬				
					+ "order by lecture_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";		
			Object[] data = {pageVO.getKeyword(), 
						pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, lectureMapper, data);
		}
		else { // 목록이라면
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "lecture_code, lecture_department, lecture_professor, "
					+ "lecture_type, lecture_name, "
					+ "lecture_time, lecture_day, lecture_duration, "
					+ "lecture_room, lecture_count, lecture_regist "
					+ "from lecture "
					// 트리정렬					
					+ "order by lecture_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, lectureMapper, data);
		}	
	}

	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) { // 검색카운트
			String sql = "select count(*) from lecture "
					+ "where instr("+pageVO.getColumn()+", ?) > 0";	
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from lecture";		
			return jdbcTemplate.queryForObject(sql, int.class);	
		}
	}

	// 수강신청 갱신(최신화) 기능
	public boolean updateRegistration(String lectureCode) {
		String sql = "update lecture set lecture_regist = ( " // 반정규화
				+ "select count(*) from registration where registration_lecture = ? "
				+ ") where lecture_code = ?";
		Object[] data = {lectureCode, lectureCode};
		return jdbcTemplate.update(sql, data) > 0 ;		
	}
	
	// 수강신청한 강의 목록을 조회
	public List<LectureDto> selectListByRegistration(String studentId) {
		String sql = "select * from lecture where lecture_code in (" 
					+ "select registration_lecture from registration "
					+ "where registration_student = ? "
					+ ") order by lecture_code desc";
		Object[] data = {studentId};
		return jdbcTemplate.query(sql, lectureMapper, data);
	}
	
}
