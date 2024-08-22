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
	
	// 페이징 객체를 이용한 목록 및 검색 메소드
	public List<RegistrationDto> selectListByPaging(PageVO pageVO){
		if(pageVO.isSearch()) { // 검색이라면 
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "registration_code, registration_student, "
					+ "registration_lecture, registration_date "
					+ "from registration "
					+ "where instr("+pageVO.getColumn()+",?)>0 "
					// 트리정렬				
					+ "order by registration_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";		
			Object[] data = {pageVO.getKeyword(), 
						pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, registrationMapper, data);
		}
		else { // 목록이라면
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "registration_code, registration_student, "
					+ "registration_lecture, registration_date "
					+ "from registration "
					// 트리정렬					
					+ "order by registration_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, registrationMapper, data);
		}	
	}

	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) { // 검색카운트
			String sql = "select count(*) from board "
					+ "where instr("+pageVO.getColumn()+", ?) > 0";	
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from board";		
			return jdbcTemplate.queryForObject(sql, int.class);	
		}
	}
}
