package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.GradeDto;
import com.kh.kh14semi3.mapper.GradeMapper;
import com.kh.kh14semi3.mapper.GradeStudentMapper;
import com.kh.kh14semi3.vo.GradeStudentVO;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class GradeDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private GradeMapper gradeMapper;
	@Autowired
	private GradeStudentMapper gradeStudentMapper;
	
	// 시퀀스 생성 구문
	public int sequence() {
		String sql = "select grade_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
	
	// 등록
	public void insert(GradeDto gradeDto) {
		String sql = "insert into grade( "
				+ "grade_code, grade_student, grade_lecture, "
				+ "grade_attendance, grade_score1, grade_score2, "
				+ "grade_homwork "
				+ ") values (?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				gradeDto.getGradeCode(), gradeDto.getGradeStudent(),
				gradeDto.getGradeLecture(), gradeDto.getGradeAttendance(),
				gradeDto.getGradeScore1(), gradeDto.getGradeScore2(),
				gradeDto.getGradeHomework()
				};
		jdbcTemplate.update(sql, data);
	}
	
	// 목록(+페이징)
	public List<GradeDto> selectListByPaging(PageVO pageVO){
		if(pageVO.isSearch()) { // 검색이라면 
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "grade_code, grade_student, grade_lecture, "
					+ "grade_attendance, grade_score1, "
					+ "grade_score2, grade_homework "
					+ "from grade "
					+ "where instr("+pageVO.getColumn()+",?)>0 "
					// 트리정렬				
					+ "order by grade_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";		
			Object[] data = {pageVO.getKeyword(), 
						pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, gradeMapper, data);
		}
		else { // 목록이라면
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "grade_code, grade_student, grade_lecture, "
					+ "grade_attendance, grade_score1, "
					+ "grade_score2, grade_homework "
					+ "from grade "
					// 트리정렬					
					+ "order by grade_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, gradeMapper, data);
		}	
	}

	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) { // 검색카운트
			String sql = "select count(*) from grade "
					+ "where instr("+pageVO.getColumn()+", ?) > 0";	
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from grade";		
			return jdbcTemplate.queryForObject(sql, int.class);	
		}
	}
	
	// 학생이 수강신청한 강의 목록을 조회
	public List<GradeDto> selectListByRegistration(PageVO pageVO, String studentId) {
		String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "grade_code, grade_student, grade_lecture, "
					+ "grade_attendance, grade_score1, "
					+ "grade_score2, grade_homework "
					+ "from grade "
					+ "where grade_student = ? "
					+ ") TMP"
					+ ") where rn between ? and ?";	
		Object[] data = {studentId, pageVO.getBeginRow(), pageVO.getEndRow()};
		return jdbcTemplate.query(sql, gradeMapper, data);
	}
	
	// 교수가 가르치고 있는 강의 목록을 조회
	public List<GradeDto> selectListByTeaching(PageVO pageVO, String professorId){
		String sql = "select * from ("
					+ "select "
					+ "grade_code, grade_student, grade_lecture, "
					+ "grade_attendance, grade_score1, "
					+ "grade_score2, grade_homework "
					+ "from grade "
					+ "where grade_student = ? "
					+ ") TMP"
					+ ") where rn between ? and ?";	
		Object[] data = {professorId, pageVO.getBeginRow(), pageVO.getEndRow()};
		return jdbcTemplate.query(sql, gradeMapper, data);
	}
		
	// 학생이 수강신청한 강의 목록 카운트
	public int countByPagingWithStudent(PageVO pageVO, String studentId) {
		if(pageVO.isSearch()) { // 검색카운트
			String sql = "select count(*) from lecture "
					+ "where instr("+pageVO.getColumn()+", ?) > 0 and "
					+ "lecture_code in ( "
					+ "select registration_lecture from registration where registration_student = ? )";	
			Object[] data = {pageVO.getKeyword(), studentId};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from lecture "
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
					+ "where instr("+pageVO.getColumn()+", ?) > 0 and "
					+ "lecture_professor = ? ";	
			Object[] data = {pageVO.getKeyword(), professorId};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from lecture where lecture_professor = ? ";	
			Object[] data = {professorId};
			return jdbcTemplate.queryForObject(sql, int.class, data);	
		}
	}
	
	// 수정
	public boolean update(GradeDto gradeDto) {
		String sql = "update grade "
				+ "set grade_student = ?, grade_lecture = ?, "
				+ "grade_attendance = ?, grade_score1 = ?, "
				+ "grade_score2 = ?, grade_homework = ? "
				+ "where grade_code = ?";
		Object[] data = {
				gradeDto.getGradeStudent(), gradeDto.getGradeLecture(),
				gradeDto.getGradeAttendance(), gradeDto.getGradeScore1(),
				gradeDto.getGradeScore2(), gradeDto.getGradeHomework(),
				gradeDto.getGradeCode()
				};
		return jdbcTemplate.update(sql, data) > 0 ;
	}
	
	// 삭제
	public boolean delete(String gradeCode) {
		String sql = "delete grade where grade_code = ?";
		Object[] data = {gradeCode};
		return jdbcTemplate.update(sql, data) > 0 ;
	}
	
	// 조회
	public GradeDto selectOne(String gradeCode) {
		String sql = "select * from grade where grade_code = ?";
		Object[] data = {gradeCode};
		List<GradeDto> list = jdbcTemplate.query(sql, gradeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	// 입력 개수 파악
	public int count(String gradeLecture) {
		String sql = "select count(*) from grade where grade_lecture = ?";
		Object[] data = {gradeLecture};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	// 특정 강의를 듣는 학생 목록
		public List<GradeStudentVO> studentList(GradeStudentVO gradeStudentVO, String gradeLecture) {
			String sql = "select member_name, grade_student "
								+ "from member join grade "
									+ "on member_id=grade_student "
										+ "where grade_lecture=?";
			Object[] data = {gradeLecture};
			return jdbcTemplate.query(sql, gradeStudentMapper, data);
		}
		

}
