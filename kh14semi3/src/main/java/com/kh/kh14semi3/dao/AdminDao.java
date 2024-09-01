package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.AdminDto;
import com.kh.kh14semi3.mapper.AdminMapper;

@Repository
public class AdminDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private AdminMapper adminMapper;
	
	public void insert(AdminDto adminDto) {
		String sql = "insert into admin(admin_id) values(?)";
		Object[] data = {adminDto.getAdminId()};
		jdbcTemplate.update(sql, data);
	}
	
	public AdminDto selectOne(String adminId) {
		String sql = "select * from admin where admin_id = ?";
		Object[] data = {adminId};
		List<AdminDto> list = jdbcTemplate.query(sql, adminMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	public boolean update(AdminDto adminDto) {
		String sql = "update admin set where admin_id = ?"; // 수정할 컬럼이 없어서 오류 발생 중
		Object[] data = {adminDto.getAdminId()};
		return jdbcTemplate.update(sql, data) > 0 ;
	}
	
	public boolean delete(String adminId) {
		String sql = "delete from admin where admin_id = ?";
		Object[] data = {adminId};
		return jdbcTemplate.update(sql, data) > 0 ;
	}
	
	
	
}
