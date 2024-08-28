package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.DepartmentDto;
import com.kh.kh14semi3.mapper.DepartmentMapper;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class AdminDepartmentDao {
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	private DepartmentMapper departmentMapper;
	
	//학과 증설
	public void insert(DepartmentDto departmentDto) {
		String sql = "insert into department("
				+ "department_code, department_name"
				+ ") values(?, ?)";
		Object[] data = {
				departmentDto.getDepartmentCode(),departmentDto.getDepartmentName()
				};
		jdbcTemplate.update(sql,data);
	}
	
	//학과 시스템 관리
	public List<DepartmentDto>selectList(){
		String sql = "select * from department order by department_code asc";
		return jdbcTemplate.query(sql, departmentMapper);
	}
	
	//학과 상세정보 목록
	public DepartmentDto selectOne(String departmentCode) {
		String sql= "select * from department where department_code=?";
		Object[] data = {departmentCode};
		List<DepartmentDto> list = jdbcTemplate.query(sql, departmentMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//학과 상세정보 검색
	public List<DepartmentDto> selectList(String column, String keyword){
		String sql = "select * from department "
				+ "where instr("+column+", ?)>0 "
				+ "order by "+column+" asc ,department_code asc";
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, departmentMapper,data);
	}
	
	//학과 통폐합
	public boolean reduce(String departmentCode) {
		String sql = "delete department where department_code=?";
		Object[] data = {departmentCode};
		return jdbcTemplate.update(sql, data) > 0;
		}

	//목록 페이지
	public List<DepartmentDto> selectListByPaging(PageVO pageVO) { 
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
			return jdbcTemplate.query(sql, departmentMapper, data);
		}
		else {//목록
			String sql = "select * from ("
								+ "select rownum rn, TMP.* from ("
									+ "select * from department order by department_code asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
			Object[] data = {pageVO.getBeginRow(), pageVO.getEndRow()};
			return jdbcTemplate.query(sql, departmentMapper, data);
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

	//수정 페이지
	public boolean edit(DepartmentDto departmentDto) {
		String sql = "update department set "
				+ "department_name=? "
				+ "where department_code = ?";
		Object[] data = {
				departmentDto.getDepartmentName(),
				departmentDto.getDepartmentCode()
		};
		return jdbcTemplate.update(sql, data) > 0;
}

	//코드 중복검사
	public DepartmentDto selectOneByDepartmentCode(String departmentCode) {
		String sql="select * from department where department_code=?";
		Object[] data= {departmentCode};
		List<DepartmentDto>list = jdbcTemplate.query(sql, departmentMapper, data);
		return list.isEmpty()? null:list.get(0);
	}

	//학과명 중복검사
	public DepartmentDto selectOneByDepartmentName(String departmentName) {
		String sql="select * from department where department_name=?";
		Object[] data= {departmentName};
		List<DepartmentDto>list = jdbcTemplate.query(sql, departmentMapper, data);
		return list.isEmpty()? null:list.get(0);
	}

	



}
