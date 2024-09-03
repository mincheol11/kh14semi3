package com.kh.kh14semi3.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class LectureMemberVO {
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
	
	private String departmentCode;
	private String departmentName;	
	
	private String memberId;//멤버 아이디
	private String memberPw;//멤버 비밀번호
	private String memberName;//멤버 이름
	private String memberRank;//멤버 등급
	private String memberEmail;//멤버 이메일
	private String memberCell;//멤버 연락처
	private String memberBirth;//멤버 생년월일
	private String memberPost;//멤버 우편번호
	private String memberAddress1;//멤버 상세주소
	private String memberAddress2;//멤버 일반주소
	private Date memberJoin;
	private Date memberLogin;
}
