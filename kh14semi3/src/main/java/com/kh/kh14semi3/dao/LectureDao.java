package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.mapper.GradeLectureMapper;
import com.kh.kh14semi3.mapper.GradeStudentMapper;
import com.kh.kh14semi3.mapper.LectureMapper;
import com.kh.kh14semi3.mapper.LectureMemberMapper;
import com.kh.kh14semi3.vo.GradeLectureVO;
import com.kh.kh14semi3.vo.GradeStudentVO;
import com.kh.kh14semi3.vo.LectureMemberVO;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class LectureDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private LectureMapper lectureMapper;
	
	@Autowired
	private GradeLectureMapper gradeLectureMapper;
	
	@Autowired
	private LectureMemberMapper lectureMemberMapper;
	
	// 강의 등록
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
	
	// 강의 상세
	public LectureDto selectOne(String lectureCode) {
		String sql = "select * from lecture where lecture_code = ?";
		Object[] data = {lectureCode};
		List<LectureDto> list = jdbcTemplate.query(sql, lectureMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	// 페이징 객체를 이용한 목록 및 검색 메소드
	public List<LectureMemberVO> selectListByPaging(PageVO pageVO){
		if(pageVO.isSearch()) { // 검색이라면 
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
//					+ "select "
//					+ "lecture_code, lecture_department, lecture_professor, "
//					+ "lecture_type, lecture_name, "
//					+ "lecture_time, lecture_day, lecture_duration, "
//					+ "lecture_room, lecture_count, lecture_regist "
//					+ "from lecture "
//					+ "where instr("+pageVO.getColumn()+",?)>0 "
					// 트리정렬				
//					+ "order by lecture_code asc"
					+ "select * from lecture " 
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "where instr("+pageVO.getColumn()+",?)>0 "
					+ "order by lecture_code asc "
					+ ") TMP"
					+ ") where rn between ? and ?";		
			Object[] data = {pageVO.getKeyword(), 
						pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, lectureMemberMapper, data);
		}
		else { // 목록이라면
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
//					+ "select "
//					+ "lecture_code, lecture_department, lecture_professor, "
//					+ "lecture_type, lecture_name, "
//					+ "lecture_time, lecture_day, lecture_duration, "
//					+ "lecture_room, lecture_count, lecture_regist "
//					+ "from lecture "
//					// 트리정렬					
//					+ "order by lecture_code asc"
					+ "select * from lecture " 
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "order by lecture_code asc "
					+ ") TMP"
					+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, lectureMemberMapper, data);
		}	
	}

	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) { // 검색카운트
			String sql = "select count(*) from lecture "
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "where instr("+pageVO.getColumn()+", ?) > 0";	
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from lecture "
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id ";		
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
	
	// 학생이 수강신청한 강의 목록을 조회
	public List<LectureDto> selectListByRegistration(PageVO pageVO, String studentId) {
		String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from lecture where lecture_code in (" 
					+ "select registration_lecture from registration "
					+ "where registration_student = ? "
					+ ") order by lecture_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";	
		Object[] data = {studentId, pageVO.getBeginRow(), pageVO.getEndRow()};
		return jdbcTemplate.query(sql, lectureMapper, data);
	}
	
	// 학생이 수강신청한 강의 목록을 조회
	public List<LectureMemberVO> selectListByRegistration2(PageVO pageVO, String studentId) {
		if(pageVO.isSearch()) {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from lecture "
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "where lecture_code in (" 
					+ "select registration_lecture from registration "
					+ "where registration_student = ? "
					+ "and instr("+pageVO.getColumn()+", ?) > 0"
					+ ") order by lecture_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";	
			Object[] data = {studentId, pageVO.getKeyword(), pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, lectureMemberMapper, data);
		}
		else {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select * from lecture "
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "where lecture_code in (" 
					+ "select registration_lecture from registration "
					+ "where registration_student = ? "
					+ ") order by lecture_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";	
			Object[] data = {studentId, pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, lectureMemberMapper, data);
		}
	}
	
	// 교수가 가르치고 있는 강의 목록을 조회
	public List<LectureDto> selectListByTeaching(PageVO pageVO, String professorId){
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from lecture where lecture_professor = ? "
				+ "order by lecture_code asc"
				+ ") TMP"
				+ ") where rn between ? and ?";	
		Object[] data = {professorId, pageVO.getBeginRow(), pageVO.getEndRow()};
		return jdbcTemplate.query(sql, lectureMapper, data);
	}
	
	// 교수가 가르치고 있는 강의 목록을 조회
	public List<LectureMemberVO> selectListByTeaching2(PageVO pageVO, String professorId){
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from lecture "
				+ "left outer join DEPARTMENT "
				+ "on lecture_department = department_code "
				+ "left outer join member "
				+ "on lecture_professor = member_id "
				+ "where lecture_professor = ? "
				+ "order by lecture_code asc"
				+ ") TMP"
				+ ") where rn between ? and ?";	
		Object[] data = {professorId, pageVO.getBeginRow(), pageVO.getEndRow()};
		return jdbcTemplate.query(sql, lectureMemberMapper, data);
	}
	
	// 학생이 수강신청한 강의 목록 카운트
	public int countByPagingWithStudent(PageVO pageVO, String studentId) {
		if(pageVO.isSearch()) { // 검색카운트
			String sql = "select count(*) from lecture "
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "where instr("+pageVO.getColumn()+", ?) > 0 and "
					+ "lecture_code in ( "
					+ "select registration_lecture from registration where registration_student = ? )";	
			Object[] data = {pageVO.getKeyword(), studentId};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from lecture "
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "where lecture_code in ( "
					+ "select registration_lecture from registration where registration_student = ? )";	
			Object[] data = {studentId};
			return jdbcTemplate.queryForObject(sql, int.class, data);	
		}
	}
	
	// 교수가 가르치고 있는 강의 목록 카운트
	public int countByPagingWithProfessor(PageVO pageVO, String professorId) {
		if(pageVO.isSearch()) { // 검색카운트
			String sql = "select count(*) from lecture "
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "where instr("+pageVO.getColumn()+", ?) > 0 and "
					+ "lecture_professor = ? ";	
			Object[] data = {pageVO.getKeyword(), professorId};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from lecture "
					+ "left outer join DEPARTMENT "
					+ "on lecture_department = department_code "
					+ "left outer join member "
					+ "on lecture_professor = member_id "
					+ "where lecture_professor = ? ";	
			Object[] data = {professorId};
			return jdbcTemplate.queryForObject(sql, int.class, data);	
		}
	}
	
	// 학생의 성적 조회 리스트
	public List<GradeLectureVO> selectListWithGrade(PageVO pageVO, String studentId){
//		if(pageVO.isSearch()) {
//		}
//		else {
			String sql = "select * from lecture L "
					+ "left outer join grade G on L.lecture_code = G.grade_lecture "
					+ "where G.grade_student = ? "
					+ "and G.grade_lecture in ("
					+ "select R.registration_lecture from registration R "
					+ "where R.registration_student = ? ) "
					+ "order by lecture_name asc";	
			Object[] data = {studentId, studentId};
			return jdbcTemplate.query(sql, gradeLectureMapper, data);			
//		}
	}

}
