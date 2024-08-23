package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.RegistrationDto;
import com.kh.kh14semi3.mapper.RegistrationMapper;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class RegistrationDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private RegistrationMapper registrationMapper;
	
	// [1] 학번과 강의코드를 가지고 기록 유무를 조회하는 기능
	public boolean check(String studentId, String lectureCode) {
		if(studentId == null) return false; // 학번 없으면 나가
		String sql = "select count(*) from registration "
				+ "where registration_student = ? and registration_lecture = ?";
		Object[] data = {studentId, lectureCode};
		return jdbcTemplate.queryForObject(sql, int.class, data) > 0; 
	}
	
	// [2] 수강인원 카운트 기능
	public int count(String lectureCode) {
		String sql = "select count(*) from registration where registration_lecture = ?";
		Object[] data = {lectureCode};
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
	
	// [3] 강의 수강신청 기능
	public void insert(String studentId, String lecturCode) {
		String sql = "insert into registration "
				+ "values(registration_seq.nextval, ?, ?, sysdate)";
		Object[] data = {studentId, lecturCode};
		jdbcTemplate.update(sql, data);
	}
	
	// [4] 강의 수강취소 기능
	public boolean delete(String studentId, String lectureCode) {
		String sql = "delete registration "
				+ "where registration_student = ? and registration_lecture = ?";
		Object[] data = {studentId, lectureCode};
		return jdbcTemplate.update(sql, data) > 0 ;		
	}	
	
}
