package com.kh.kh14semi3.vo;

import lombok.Data;

@Data
public class GradeStudentVO {
	// grade Dto
	private String gradeCode;
	private String gradeStudent;
	private String gradeLecture;
	private int gradeAttendance;
	private int gradeScore1;
	private int gradeScore2;
	private int gradeHomework;
	private int gradeRank;
	
	// member Dto
	private String memberId;
	private String memberName;
	
}
