package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.DepartmentDto;
import com.kh.kh14semi3.dto.ProfessorDto;
import com.kh.kh14semi3.mapper.DepartmentMapper;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class DepartmentDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private DepartmentMapper departmentMapper;
	
	// 페이징 객체를 이용한 목록 및 검색 메소드
	public List<DepartmentDto> selectListByPaging(PageVO pageVO){
		if(pageVO.isSearch()) { // 검색이라면 
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "department_code, department_name "
					+ "from department "
					+ "where instr("+pageVO.getColumn()+",?)>0 "
					// 트리정렬				
					+ "order by department_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";		
			Object[] data = {pageVO.getKeyword(), 
						pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, departmentMapper, data);
		}
		else { // 목록이라면
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "department_code, department_name "
					+ "from department "
					// 트리정렬					
					+ "order by department_code asc"
					+ ") TMP"
					+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, departmentMapper, data);
		}	
	}

	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) { // 검색카운트
			String sql = "select count(*) from department "
					+ "where instr("+pageVO.getColumn()+", ?) > 0";	
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else { // 목록카운트
			String sql = "select count(*) from department";		
			return jdbcTemplate.queryForObject(sql, int.class);	
		}
	}

	public DepartmentDto selectOne(String lectureDepartment) {
		String sql = "select * from department where department_code = ?";
		Object[] data = {lectureDepartment};
		List<DepartmentDto> list = jdbcTemplate.query(sql, departmentMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	
}
