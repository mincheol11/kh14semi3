package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.AdminDepartmentDto;
import com.kh.kh14semi3.mapper.AdminDepartmentMapper;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class AdminDepartmentDao {
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	private AdminDepartmentMapper adminDepartmentMapper;
	
	//학과 증설
	public void insert(AdminDepartmentDto adminDepartmentDto) {
		String sql = "insert into department("
				+ "department_code, department_name"
				+ ") values(?, ?)";
		Object[] data = {
				adminDepartmentDto.getDepartmentCode(),adminDepartmentDto.getDepartmentName()
				};
		jdbcTemplate.update(sql,data);
	}
	
	//학과 시스템 관리
	public List<AdminDepartmentDto>selectList(){
		String sql = "select * from department order by department_code asc";
		return jdbcTemplate.query(sql, adminDepartmentMapper);
	}
	
	//학과 상세정보 목록
	public AdminDepartmentDto selectOne(String departmentCode) {
		String sql= "select * from department where department_code=?";
		Object[] data = {departmentCode};
		List<AdminDepartmentDto> list = jdbcTemplate.query(sql, adminDepartmentMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//학과 상세정보 검색
	public List<AdminDepartmentDto> selectList(String column, String keyword){
		String sql = "select * from department "
				+ "where instr("+column+", ?)>0 "
				+ "order by "+column+" asc ,department_code asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, adminDepartmentMapper,data);
	}
	
	//학과 통폐합
	public boolean reduce(String departmentCode) {
		String sql = "delete department where department_code=?";
		Object[] data = {departmentCode};
		return jdbcTemplate.update(sql, data) > 0;
		}

	//목록 페이지
	public List<AdminDepartmentDto> selectListByPaging(PageVO pageVO) { 
		if(pageVO.isSearch()) {//검색
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select * from department where instr(#1, ?) > 0 "
									+ "order by #1 asc, department_code asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {
				pageVO.getKeyword(), 
				pageVO.getBeginRow(), pageVO.getEndRow()
			};
			return jdbcTemplate.query(sql, adminDepartmentMapper, data);
		}
		else {//목록
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select * from department order by department_code asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, adminDepartmentMapper, data);
		}
	}
	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) {//검색
			String sql = "select count(*) from department where instr(#1, ?) > 0";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else {//목록
			String sql = "select count(*) from department";
			return jdbcTemplate.queryForObject(sql, int.class);
		}
	}

	public boolean edit(AdminDepartmentDto adminDepartmentDto) {
		String sql = "update department set "
				+ "department_name=? "
				+ "where department_code = ?";
		Object[] data = {
				adminDepartmentDto.getDepartmentName(),
				adminDepartmentDto.getDepartmentCode()
		};
		return jdbcTemplate.update(sql, data) > 0;
}	



}
