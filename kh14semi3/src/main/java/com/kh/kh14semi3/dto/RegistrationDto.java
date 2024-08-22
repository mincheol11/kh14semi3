package com.kh.kh14semi3.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class RegistrationDto {
	private String registrationCode;
	private String registrationStudent;
	private String registrationLecture;
	private Date registrationDate;
	
}