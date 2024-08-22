package com.kh.kh14semi3.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class TakeOffDto {
	private int takeOffNo;
	private String takeOffType;
	private String takeOffMemo;
	private Date takeOffTime;
	private String takeOffTarget;//회원ID(외래키,FK)
}
