package com.kh.kh14semi3.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.mapper.ProfessorMapper;

@Repository
public class ProfessorDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private ProfessorMapper professorMapper;
	
t}
