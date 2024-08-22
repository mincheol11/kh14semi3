package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.DepartmentDto;
import com.kh.kh14semi3.mapper.DepartmentMapper;

@Repository
public class DepartmentDao {
	@Autowired
	JdbcTemplate jdbcTemplate;
	@Autowired
	private DepartmentMapper departmentMapper;
	
	//학과 증설
	public void insert(DepartmentDto departmentDto) {
		String sql = "insert into department("
				+ "department_code, department_name"
				+ ")"
				+ " values(?, ?)";
		
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
	public DepartmentDto selectOne(int departmentCode) {
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
	
}
