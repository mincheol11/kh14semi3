package com.kh.kh14semi3.vo;

import java.sql.Date;

import lombok.Data;

//회원과 차단 정보가 같이 담길 수 있는 VO (관리자 회원 검색 시 사용)
@Data
public class MemberTakeOffVO {
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
	private Date memberJoin;//멤버 가입일
	private Date memberLogin;//멤버 최종 로그인 일시
	
	private int takeOffNo;
	private String takeOffType;
	private String takeOffMemo;
	private Date takeOffTime;
	private String takeOffTarget;
	
}