package com.kh.kh14semi3.vo;

import lombok.Data;

@Data
public class GradeLectureVO {
	
	private String gradeCode;
	private String gradeStudent;
	private String gradeLecture;
	private int gradeAttendance;
	private int gradeScore1;
	private int gradeScore2;
	private int gradeHomework;
	private int gradeRank;
	
	private String lectureCode;
	private String lectureDepartment;
	private String lectureProfessor;
	private String lectureType;
	private String lectureName;
	private String lectureTime;
	private Integer lectureDuration;
	private String lectureDay;
	private String lectureRoom;
	private Integer lectureCount;
	private Integer lectureRegist;
}
