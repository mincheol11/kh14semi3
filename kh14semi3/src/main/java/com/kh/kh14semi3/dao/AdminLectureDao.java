package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.LectureDto;
import com.kh.kh14semi3.mapper.LectureMapper;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class AdminLectureDao {
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	LectureMapper lectureMapper;
	
	//강의 추가
	public void add(LectureDto lectureDto) {
		String sql = "insert into lecture("
				+ "lecture_code, lecture_department, lecture_professor, "
				+ "lecture_type, lecture_name, lecture_time, "
				+ "lecture_duration, lecture_day, lecture_room, lecture_count"
				+ ") values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] data = {
				lectureDto.getLectureCode(), lectureDto.getLectureDepartment(),
				lectureDto.getLectureProfessor(), lectureDto.getLectureType(), 
				lectureDto.getLectureName(), lectureDto.getLectureTime(), 
				lectureDto.getLectureDuration(), lectureDto.getLectureDay(), 
				lectureDto.getLectureRoom(), lectureDto.getLectureCount()
				};
		jdbcTemplate.update(sql,data);		
	}
	
	//강의 시스템 관리
		public List<LectureDto>selectList(){
			String sql = "select * from lecture order by lecture_code asc";
			return jdbcTemplate.query(sql, lectureMapper);
		}
		
		//강의 상세정보 목록
		public LectureDto selectOne(String lectureCode) {
			String sql= "select * from lecture where lecture_code=?";
			Object[] data = {lectureCode};
			List<LectureDto> list = jdbcTemplate.query(sql, lectureMapper, data);
			return list.isEmpty() ? null : list.get(0);
		}
		
		//강의 상세정보 검색
		public List<LectureDto> selectList(String column, String keyword){
			String sql = "select * from lecture "
					+ "where instr("+column+", ?)>0 "
					+ "order by "+column+" asc ,lecture_code asc";
			Object[] data = {keyword};
			return jdbcTemplate.query(sql, lectureMapper,data);
		}

		//목록 페이지
		public List<LectureDto> selectListByPaging(PageVO pageVO) { 
			if(pageVO.isSearch()) {//검색
				String sql = "select * from ("
									+ "select rownum rn, TMP.* from ("
										+ "select * from lecture where instr(#1, ?) > 0 "
										+ "order by #1 asc, lecture_code asc"
									+ ")TMP"
								+ ") where rn between ? and ?";
				sql = sql.replace("#1", pageVO.getColumn());
				Object[] data = {
					pageVO.getKeyword(), 
					pageVO.getBeginRow(), pageVO.getEndRow()
				};
				return jdbcTemplate.query(sql, lectureMapper, data);
			}
			else {//목록
				String sql = "select * from ("
									+ "select rownum rn, TMP.* from ("
										+ "select * from lecture order by lecture_code asc"
									+ ")TMP"
								+ ") where rn between ? and ?";
				Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
				return jdbcTemplate.query(sql, lectureMapper, data);
			}
		}
		public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select count(*) from lecture where instr(#1, ?) > 0";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {//목록
			String sql = "select count(*) from lecture";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}
		
		//수정 페이지
		public boolean edit(LectureDto lectureDto) {
			String sql = "update lecture set "
					+ "lecture_department=?, lecture_professor=?, "
					+ "lecture_type=?, lecture_time=?, "
					+ "lecture_duration=?, lecture_day=?, "
					+ "lectrure_room=?, lecture_count=? "
					+ "where lecture_code = ?";
			Object[] data = {
					lectureDto.getLectureDepartment(),lectureDto.getLectureProfessor(),
					lectureDto.getLectureType(),lectureDto.getLectureTime(),
					lectureDto.getLectureDuration(),lectureDto.getLectureDay(),
					lectureDto.getLectureRoom(),lectureDto.getLectureCount(),
					lectureDto.getLectureCode()
			};
			return jdbcTemplate.update(sql, data) > 0;
	}

		//코드 중복검사
		public LectureDto selectOneByLectureCode(String lectureCode) {
			String sql="select * from lecture where lecture_code=?";
			Object[] data= {lectureCode};
			List<LectureDto>list = jdbcTemplate.query(sql,  lectureMapper, data);
			return list.isEmpty()? null:list.get(0);
		}

		//강의명 중복검사
		public LectureDto selectOneByLectureName(String lectureName) {
			String sql="select * from lecture where lecture_name=?";
			Object[] data= {lectureName};
			List<LectureDto>list = jdbcTemplate.query(sql, lectureMapper, data);
			return list.isEmpty()? null:list.get(0);
		}		
		//학과 통폐합
		public boolean remove(String lectureCode) {
			String sql = "delete lecture where lecture_code=?";
			Object[] data = {lectureCode};
			return jdbcTemplate.update(sql, data) > 0;
			}

}
