package com.kh.kh14semi3.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class LectureStudentVO {
	// 강의 Dto
	private String lectureCode;
	private String lectureDepartment;
	private String lectureProfessor;
	private String lectureType;
	private String lectureName;
	private Date lectureTime;
	private int lectureDuration;
	private Date lectureDay;
	private String lectureRoom;
	private int lectureCount;
	private int lectureRegist;
	
	// 멤버 Dto
	private String memberId;//멤버 아이디
	private String memberName;//멤버 이름
	
}
