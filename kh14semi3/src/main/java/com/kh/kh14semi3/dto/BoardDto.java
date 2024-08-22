package com.kh.kh14semi3.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class BoardDto {
	private  int boardNo;
	private  String boardWriter;
	private  String boardType;
	private  String boardTitle;
	private  String boardContent;
	private  Date boardWtime;
	private  Date boardUtime;
	private int boardViews;
	
}
