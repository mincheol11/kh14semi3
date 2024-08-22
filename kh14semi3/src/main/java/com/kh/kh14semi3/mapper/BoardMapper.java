package com.kh.kh14semi3.mapper;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import com.kh.kh14semi3.dto.BoardDto;

@Service
public class BoardMapper implements RowMapper<BoardDto> {

	@Override
	public BoardDto mapRow(ResultSet rs, int rowNum) throws SQLException {
	BoardDto boardDto = new BoardDto();
	boardDto.setBoardNo(rs.getInt("board_no"));
	boardDto.setBoardWriter(rs.getString("board_writer"));
	boardDto.setBoardType(rs.getString("board_type"));
	boardDto.setBoardTitle(rs.getString("board_title"));
	boardDto.setBoardContent(rs.getString("board_content"));
	boardDto.setBoardWtime(rs.getDate("board_wtime"));
	boardDto.setBoardUtime(rs.getDate("board_utime"));
	boardDto.setBoardViews(rs.getInt("board_views"));
		return boardDto;
	}

}
