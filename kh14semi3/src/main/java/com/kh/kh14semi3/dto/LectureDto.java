package com.kh.kh14semi3.dto;

import lombok.Data;

@Data
public class LectureDto {
	private int lectureCode;
	private String lectureType;
	private String lectureName;
	private String lectureTime;
	private int lectureDuration;
	private String lectureDay;
	private String lectureRoom;
	private int lectureCount;
	
	private int lectureDepartmentCode;
}
