package com.kh.kh14semi3.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class LectureDto {
	private String lectureCode;
	private String lectureDepartment;
	private String lectureProfessor;
	private String lectureType;
	private String lectureName;
	private String lectureTime;
	private int lectureDuration;
	private String lectureDay;
	private String lectureRoom;
	private int lectureCount;
	private int lectureRegist;
	
}
