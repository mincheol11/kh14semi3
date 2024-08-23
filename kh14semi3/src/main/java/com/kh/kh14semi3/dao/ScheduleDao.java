package com.kh.kh14semi3.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.kh14semi3.dto.ScheduleDto;
import com.kh.kh14semi3.mapper.ScheduleDetailMapper;
import com.kh.kh14semi3.mapper.ScheduleListMapper;
import com.kh.kh14semi3.vo.PageVO;

@Repository
public class ScheduleDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private ScheduleDetailMapper scheduleDetailMapper;
	
	@Autowired
	private ScheduleListMapper scheduleListMapper;
	
	
   public int sequence() {
		String sql ="select schedule_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}


	public void insert(ScheduleDto scheduleDto) {
		String sql = "insert into board"
				+ "("
				+ " schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
				+ ")"
				+ "values(?, ?, ?, ?,?,?,)";
		Object[] data = {
			scheduleDto.getScheduleNo(),
			scheduleDto.getScheduleWriter(),
			scheduleDto.getScheduleType(),
			scheduleDto.getScheduleTitle(),
			scheduleDto.getScheduleContent(),
			scheduleDto.getScheduleWtime()
		};
		jdbcTemplate.update(sql, data);
	}

		
		

	public List<ScheduleDto> selectList() {
		String sql = "select  "
				+ "schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
				+ "from schedule order by schedule_no desc";
		return jdbcTemplate.query(sql,scheduleListMapper );
	}


	public List<ScheduleDto> selectList(String column, String keyword) {
		String sql = "select "
				+ "schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
				+ " from schedule "
				+ "where instr(#1, ?) > 0 "
				+ "order by schedule_no desc";
		sql = sql.replace("#1", column);
		Object[] data = {keyword};
		return jdbcTemplate.query(sql, scheduleListMapper, data);
	}

	public ScheduleDto selectOne(int scheduleNo) {
		String sql = "select * from schedule where schedule_no = ?";
		Object[] data = {scheduleNo};
		List<ScheduleDto> list = jdbcTemplate.query(sql,scheduleDetailMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	public boolean update(ScheduleDto scheduleDto) {
		String sql = "update schedule set "
						+ "schedule_title=?, schedule_content=?, schedule_utime=sysdate "
						+ "where schedule_no=?";
		Object[] data = {
		scheduleDto.getScheduleTitle(),
		scheduleDto.getScheduleContent(),
		scheduleDto.getScheduleNo()
		};
		return jdbcTemplate.update(sql, data) > 0;
	}

	public boolean delete(int scheduleNo) {
		String sql ="delete from schedule"
				+ "where schedule_no=? ";
		 Object[] data = {scheduleNo};
		 return jdbcTemplate.update(sql,data) > 0;
		
	}
	
	
	public List<ScheduleDto>selectListByPaging(int page, int size){
		      int endRow= page * size;
		      int beginRow = endRow - (size-1);
				
	String sql = "select * from ("
				+ "select rownum rn, TMP.* from ( "
				+ "select "
					+ "schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
				+ "from schedule order by schedule_no desc "
			+ ")TMP "
	+ ") where rn between ? and ?";
				
		
		Object[] data= {beginRow,endRow};
		return jdbcTemplate.query(sql, scheduleListMapper,data);
	}
	public List<ScheduleDto>selectListByPaging(
			String column,
			String keyword,
			int page,
			int size){

		int endRow= page * size;
	    int beginRow = endRow - (size-1);
			
	String sql = "select * from ( "
			+ "select rownum rn, TMP.* from ( "
			+ "select "
			+ " schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
			+ " from schedule "
			+ "where instr(#1, ?) >  0  "
			+ "order by schedule_no desc "
		+ ")TMP "
	+ ") where rn between ? and ?";
			sql = sql.replace("#1", column);

	Object[] data= {keyword,beginRow,endRow};
	return jdbcTemplate.query(sql, scheduleListMapper,data);
	}

	public int countByPaging() {
		
		String sql ="select count(*) from schedule";
		
		return jdbcTemplate.queryForObject(sql, int.class);
	}



	public int countByPaging(String column, String keyword) {
		
		String sql="select count(*) from schedule where instr(#1,?) > 0";
		sql= sql.replace("#1", column);
		Object[]data= {keyword};
		return jdbcTemplate.queryForObject(sql, int.class,data);
	}


	public List<ScheduleDto> selectListByPaging(PageVO pageVO) {
		
		if(pageVO.isSearch()) {
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ "schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
					+ " from schedule "
					+ "where instr(#1, ?) > 0 "
					+ "order by schedule_no asc "
				+ ")TMP "
			+ ") where rn between ? and ?";
					sql = sql.replace("#1", pageVO.getColumn());

			Object[] data= {pageVO.getKeyword(),pageVO.getBeginRow(),pageVO.getEndRow()};
			return jdbcTemplate.query(sql, scheduleListMapper,data);
		}
		else {
			
			String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "select "
					+ " schedule_no, SCHEDULE_WRITER, SCHEDULE_TYPE, SCHEDULE_TITLE, SCHEDULE_CONTENT, SCHEDULE_WTIME "
					+ "from schedule "
					+ "order by schedule_no asc " 
				+ ")TMP"
		+ ") where rn between ? and ?";
			
			Object[] data= {pageVO.getBeginRow(),pageVO.getEndRow()};
			return jdbcTemplate.query(sql, scheduleListMapper,data);
		}
		}


	public int countByPaging(PageVO pageVO) {
		if(pageVO.isSearch()) {
			String sql="select count(*) from schedule where instr(#1,?) > 0";
			sql= sql.replace("#1",pageVO.getColumn() );
			Object[]data= {pageVO.getKeyword()};
			return jdbcTemplate.queryForObject(sql, int.class,data);
		}
		else {
			String sql ="select count(*) from schedule";
			
			return jdbcTemplate.queryForObject(sql, int.class);
		}
		}
		public int  findImage(int scheduleNo) {
			String sql = "select attachment from schedule_image where schedule=?";
			Object[] data = {scheduleNo};
			return jdbcTemplate.queryForObject(sql ,int.class,data);

}
	}